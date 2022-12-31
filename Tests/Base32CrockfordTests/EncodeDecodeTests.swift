@testable import Base32Crockford
import XCTest

final class EncodeDecodeTests: XCTestCase {
  var data: [String: String]!
  var python: [UUID: String]!
  var checksumData: [UUID: String]!
  
  static let allValues = [
    "00",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "0A",
    "0B",
    "0C",
    "0D",
    "0E",
    "0F",
    "0G",
    "0H",
    "0J",
    "0K",
    "0M",
    "0N",
    "0P",
    "0Q",
    "0R",
    "0S",
    "0T",
    "0V",
    "0W",
    "0X",
    "0Y",
    "0Z",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "1A",
    "1B",
    "1C",
    "1D",
    "1E",
    "1F",
    "1G",
    "1H",
    "1J",
    "1K",
    "1M",
    "1N",
    "1P",
    "1Q",
    "1R",
    "1S",
    "1T",
    "1V",
    "1W",
    "1X",
    "1Y",
    "1Z",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "2A",
    "2B",
    "2C",
    "2D",
    "2E",
    "2F",
    "2G",
    "2H",
    "2J",
    "2K",
    "2M",
    "2N",
    "2P",
    "2Q",
    "2R",
    "2S",
    "2T",
    "2V",
    "2W",
    "2X",
    "2Y",
    "2Z",
    "30",
    "31",
    "32",
    "33",
    "34",
    "35",
    "36",
    "37",
    "38",
    "39",
    "3A",
    "3B",
    "3C",
    "3D",
    "3E",
    "3F",
    "3G",
    "3H",
    "3J",
    "3K",
    "3M",
    "3N",
    "3P",
    "3Q",
    "3R",
    "3S",
    "3T",
    "3V",
    "3W",
    "3X",
    "3Y",
    "3Z",
    "40",
    "41",
    "42",
    "43",
    "44",
    "45",
    "46",
    "47",
    "48",
    "49",
    "4A",
    "4B",
    "4C",
    "4D",
    "4E",
    "4F",
    "4G",
    "4H",
    "4J",
    "4K",
    "4M",
    "4N",
    "4P",
    "4Q",
    "4R",
    "4S",
    "4T",
    "4V",
    "4W",
    "4X",
    "4Y",
    "4Z",
    "50",
    "51",
    "52",
    "53",
    "54",
    "55",
    "56",
    "57",
    "58",
    "59",
    "5A",
    "5B",
    "5C",
    "5D",
    "5E",
    "5F",
    "5G",
    "5H",
    "5J",
    "5K",
    "5M",
    "5N",
    "5P",
    "5Q",
    "5R",
    "5S",
    "5T",
    "5V",
    "5W",
    "5X",
    "5Y",
    "5Z",
    "60",
    "61",
    "62",
    "63",
    "64",
    "65",
    "66",
    "67",
    "68",
    "69",
    "6A",
    "6B",
    "6C",
    "6D",
    "6E",
    "6F",
    "6G",
    "6H",
    "6J",
    "6K",
    "6M",
    "6N",
    "6P",
    "6Q",
    "6R",
    "6S",
    "6T",
    "6V",
    "6W",
    "6X",
    "6Y",
    "6Z",
    "70",
    "71",
    "72",
    "73",
    "74",
    "75",
    "76",
    "77",
    "78",
    "79",
    "7A",
    "7B",
    "7C",
    "7D",
    "7E",
    "7F",
    "7G",
    "7H",
    "7J",
    "7K",
    "7M",
    "7N",
    "7P",
    "7Q",
    "7R",
    "7S",
    "7T",
    "7V",
    "7W",
    "7X",
    "7Y"

  ]

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

      let checksumUrl = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("../../Data/checksum")
      guard let checksumText = try? String(contentsOf: checksumUrl) else {
        return
      }
      checksumData = checksumText.components(separatedBy: .newlines).reduce([UUID: String]()) { data, line in
        let components = line.components(separatedBy: .whitespaces)
        guard let key = components.first, let value = components.last, components.first != components.last else {
          return data
        }
        var dictionary = data
        dictionary[UUID(uuidString: key)!] = value
        return dictionary
      }
    
    let pythonUrl = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("../../Data/python")
    guard let pythonText = try? String(contentsOf: pythonUrl) else {
      return
    }
    python = pythonText.components(separatedBy: .newlines).reduce([UUID: String]()) { data, line in
      let components = line.components(separatedBy: .whitespaces)
      guard let key = components.first, let value = components.last, components.first != components.last else {
        return data
      }
      var dictionary = data
      dictionary[UUID(uuidString: key)!] = value
      return dictionary
    }
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
  
  func testIntegers() {
    for value : UInt8 in 1...254 {
      let data = Data([value])
      let actual = Base32CrockfordEncoding.encoding.encode(data: data)
      XCTAssertEqual(actual, Self.allValues[Int(value)], "Encoded value of \(value): \(actual) does not equal expected \(Self.allValues[Int(value)])")
    }
  }
  
  func testEncodingPython() {
    for (value, expected) in python {
      let data = Data(Array(uuid: value))
      let actual = Base32CrockfordEncoding.encoding.encode(data: data).uppercased()
      XCTAssertEqual(actual, expected, "Encoded value of \(value): \(actual) does not equal \(expected)")
    }
  }


  func testEncodingWithChecksum () {

      for (value, expected) in checksumData {
        let data = Data(Array(uuid: value))
        let actual = Base32CrockfordEncoding.encoding.encode(data: data, options: .withChecksum).uppercased()
        XCTAssertEqual(actual, expected)
      }
  }

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
