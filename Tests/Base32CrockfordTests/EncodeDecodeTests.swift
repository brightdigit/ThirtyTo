@testable import Base32Crockford
import XCTest

final class EncodeDecodeTests: XCTestCase {
  var data: [String: String]!
  var checksumData: [UUID: String]!

  override func setUp() {
    let valuesUrl = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("../../Data/values")
    guard let allText = try? String(contentsOf: valuesUrl) else {
      return
    }
    data = allText.components(separatedBy: .newlines).reduce([String: String]()) { data, line in
      let components = line.components(separatedBy: .whitespaces)
      guard let key = components.first, let value = components.last, components.first != components.last else {
        return data
      }
      var dictionary = data
      dictionary[key] = value
      return dictionary
    }

//      let checksumUrl = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("../../Data/checksum")
//      guard let checksumText = try? String(contentsOf: checksumUrl) else {
//        return
//      }
//      checksumData = checksumText.components(separatedBy: .newlines).reduce([UUID: String]()) { data, line in
//        let components = line.components(separatedBy: .whitespaces)
//        guard let key = components.first, let value = components.last, components.first != components.last else {
//          return data
//        }
//        var dictionary = data
//        dictionary[UUID(uuidString: key)!] = value
//        return dictionary
//      }
  }

  func testEncoding() {
    for (value, expected) in data {
      guard let data = value.data(using: .utf8) else {
        XCTFail("Unable to create data from string")
        continue
      }
      let actual = Base32CrockfordEncoding.encoding.encode(data: data).lowercased()
      XCTAssertEqual(actual, expected)
    }
  }

//  func testEncodingWithChecksum () {
//
  ////
  ////      for (uuid, expected) in checksumData {
  ////        print(uuid, expected)
  ////
//    let uuid = UUID(uuidString: "221b469c-d38d-417c-8faa-9113648240ec")!
//        let data = Data(Array(uuid: uuid))
//        let actual = Base32CrockfordEncoding.encoding.encode(data: data, options: .withChecksum)
//        XCTAssertEqual(actual, "123D39SMWD85Y8ZAMH2DJ84G7C")
//
//
//    print(try! Base32CrockfordEncoding.encoding.decode(base32Encoded: actual, options: .withChecksum))
//    print(try! Base32CrockfordEncoding.encoding.decode(base32Encoded: "123D39SMWD85Y8ZAMH2DJ84G7C", options: .withChecksum))
  ////      }
//  }

  func decode(value: String, withExpected expected: Data) {
    let actual: Data
    do {
      actual = try Base32CrockfordEncoding.encoding.decode(base32Encoded: value)
    } catch {
      XCTFail(error.localizedDescription)
      return
    }
    XCTAssertEqual(actual, expected)
  }

  func testDecoding() {
    for (expectedString, value) in data {
      guard let expected = expectedString.data(using: .utf8) else {
        XCTFail("Unable to create data from string")
        continue
      }
      var newValue = value
      decode(value: value, withExpected: expected)
      newValue = newValue.replacingOccurrences(of: "0", with: "O")
      decode(value: newValue, withExpected: expected)
      newValue = newValue.replacingOccurrences(of: "1", with: "L")
      decode(value: newValue, withExpected: expected)
      newValue = newValue.replacingOccurrences(of: "L", with: "I")
      decode(value: newValue, withExpected: expected)
      newValue = newValue.lowercased()
      decode(value: newValue, withExpected: expected)
    }
  }
}
