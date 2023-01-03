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
    for parameters in parametersArray {
      let uuidData = Data(Array(uuid: parameters.uuid))
      let encodedUUID = Base32CrockfordEncoding.encoding.encode(data: uuidData).replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
      let encodedInt = Base32CrockfordEncoding.encoding.encode(data: parameters.integer.data).replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
      let decodedUUIDBytes = try Base32CrockfordEncoding.encoding.decode(base32Encoded: parameters.encoded)
      let decodedUUID = UUID(data: decodedUUIDBytes)
      XCTAssertEqual(parameters.integer.data.count, 128 / 8)
      XCTAssertEqual(encodedInt, encodedUUID)
      XCTAssertEqual(encodedInt, parameters.encoded)
      XCTAssertEqual(encodedUUID, parameters.encoded)
      XCTAssertEqual(decodedUUID, parameters.uuid)
      return
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
