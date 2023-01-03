@testable import Base32Crockford
import XCTest

final class Base32CrockfordTests: XCTestCase {
  var parametersArray: [Parameters]!
  struct Parameters {
    internal init(uuid: UUID, integer: UInt128, encoded: String, encodedWithChecksum: String) {
      self.uuid = uuid
      self.integer = integer
      self.encoded = encoded
      self.encodedWithChecksum = encodedWithChecksum
    }

    internal init?(line: String) {
      guard !line.isEmpty else {
        return nil
      }
      let components = line.components(separatedBy: .whitespaces)
      precondition(components.count == 4)
      guard let uuid = UUID(uuidString: components[0]) else {
        preconditionFailure()
      }
      guard let integer = UInt128(components[1]) else {
        preconditionFailure()
      }
      let encoded = components[2]
      let encodedWithChecksum = components[3]
      self.init(uuid: uuid, integer: integer, encoded: encoded, encodedWithChecksum: encodedWithChecksum)
    }

    let uuid: UUID
    let integer: UInt128
    let encoded: String
    let encodedWithChecksum: String
  }

  override func setUp() {
    let pythonUrl = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("../../Data/python")
    guard let pythonText = try? String(contentsOf: pythonUrl) else {
      return
    }

    parametersArray = pythonText.components(separatedBy: .newlines).compactMap(Parameters.init)
  }

  func testNumbersAndUUIDs() throws {
    for (index, parameters) in parametersArray.enumerated() {
      let divisor: UInt128 = 37
      let uuidData = Data(Array(uuid: parameters.uuid))
      let encodedUUID = Base32CrockfordEncoding.encoding.encode(data: uuidData)
      let encodedInt = Base32CrockfordEncoding.encoding.encode(data: parameters.integer.data)
      let encodedUUIDChecksum = Base32CrockfordEncoding.encoding.encode(data: uuidData, options: .withChecksum)

      let decodedUUIDBytes = try Base32CrockfordEncoding.encoding.decode(base32Encoded: parameters.encoded).trim(to: 16)
      let decodedUUID = UUID(data: decodedUUIDBytes)

      let decodedUUIDChecksumBytes = try Base32CrockfordEncoding.encoding.decode(base32Encoded: parameters.encodedWithChecksum, options: .init(withChecksum: true)).trim(to: 16)
      let decodedUUIDChecksum = UUID(data: decodedUUIDChecksumBytes)

      let moduloIndex = Base32CrockfordEncoding.allChecksumSymbols.firstIndex(of: parameters.encodedWithChecksum.last!)!

      let modulo = Base32CrockfordEncoding.allChecksumSymbols.distance(
        from: Base32CrockfordEncoding.allChecksumSymbols.startIndex,
        to: moduloIndex
      )

      let actualMod = Int(parameters.integer % divisor)
      XCTAssertEqual(parameters.integer.data.count, 128 / 8)
      XCTAssertEqual(encodedInt, encodedUUID)
      XCTAssertEqual(encodedInt, parameters.encoded)
      XCTAssertEqual(encodedUUID, parameters.encoded)
      XCTAssertEqual(decodedUUID, parameters.uuid, "Invalid Row \(index)")
      XCTAssertEqual(actualMod, modulo, "Invalid Row \(index)")
      XCTAssertEqual(modulo, parameters.integer.data.remainderBy(37))
      XCTAssertEqual(encodedUUIDChecksum, parameters.encodedWithChecksum)
      XCTAssertEqual(decodedUUIDChecksum, parameters.uuid)
    }
  }

  func testBadChecksum() {
    let data = Data(Array(uuid: .init()))
    let encodedWithChecksum = Base32CrockfordEncoding.encoding.encode(data: data, options: .withChecksum)
    let (encoded, checksum) = encodedWithChecksum.split(withChecksum: true)
    guard let checksum = checksum else {
      XCTFail()
      return
    }
    var badChecksum = checksum
    repeat {
      badChecksum = Base32CrockfordEncoding.allChecksumSymbols.randomElement()!
    } while badChecksum == checksum
    let badEncodedWithChecksum = encoded.appending(String(badChecksum))
    let mismatchValueExpected = Base32CrockfordEncoding.allChecksumSymbols.firstOffsetOf(character: badChecksum)
    let badChecksumExpected = Base32CrockfordEncoding.allChecksumSymbols.firstOffsetOf(character: checksum)
    do {
      _ = try Base32CrockfordEncoding.encoding.decode(base32Encoded: badEncodedWithChecksum, options: .init(withChecksum: true))
      XCTFail()
    } catch let error as Base32CrockfordDecodingError {
      guard case let .checksum(badChecksumActual, mismatchValue: mismatchValueActual) = error.details else {
        XCTFail()
        return
      }
      XCTAssertEqual(mismatchValueActual, mismatchValueExpected)
      XCTAssertEqual(badChecksumActual, badChecksumExpected)
      return
    } catch {
      XCTFail()
    }
  }

  func testInvalidCharacter() {
    let invalidCharacters = "!@#$%^&*()_-+{}[]:;<>,./?"
    let expectedCharacter = invalidCharacters.randomElement()!
    let badString = String("0123456789ABCDEFGHJKMNPQRSTVWXYZ".shuffled() + [expectedCharacter])
    XCTAssertEqual(badString.count, 33)
    do {
      _ = try Base32CrockfordEncoding.encoding.decode(base32Encoded: badString)
      XCTFail()
    } catch let error as Base32CrockfordDecodingError {
      guard case let .invalidCharacter(actualCharacter) = error.details else {
        XCTAssertNil(error)
        return
      }
      XCTAssertEqual(actualCharacter, expectedCharacter)
    } catch {
      XCTAssertNil(error)
    }
  }

  func testRandomData() {
    let b32cf = Base32CrockfordEncoding()
    for length in 1 ... 20 {
      let bytes = (0 ... length - 1).map { _ in
        UInt8.random(in: 0 ... UInt8.max)
      }
      let expectedData = Data(bytes)
      let encodedString = b32cf.encode(data: expectedData)
      let actualData = try? b32cf.decode(base32Encoded: encodedString)
      XCTAssertEqual(
        expectedData.hexEncodedString().replacingOccurrences(of: "^0+", with: "", options: .regularExpression), actualData?.hexEncodedString().replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
      )
    }
  }
}
