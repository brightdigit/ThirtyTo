@testable import Base32Crockford
import XCTest

final class Base32CrockfordTests: XCTestCase {
  func testExample() {
    let b32cf = Base32CrockfordEncoding()
    for length in 1 ... 20 {
      let bytes = (0 ... length - 1).map { _ in
        UInt8.random(in: 0 ... UInt8.max)
      }
      let expectedData = Data(bytes)
      print(bytes.map{String($0, radix: 2)}.joined())
      let encodedString = b32cf.encode(data: expectedData)
      let actualData = try? b32cf.decode(base32Encoded: encodedString)
      XCTAssertEqual(
        expectedData.hexEncodedString().replacingOccurrences(of: "^0+", with: "", options: .regularExpression), actualData?.hexEncodedString().replacingOccurrences(of: "^0+", with: "", options: .regularExpression))
    }
  }

//  func testMinimumUniqueCount() {
//    [Int].random(withCount: 20, in: 0 ... 256).forEach(minimumUniqueCount(_:))
//    minimumUniqueCount(0)
//  }

//  func testMinimumUniqueCountLessThanZero() {
//    minimumUniqueCountLessThanZero(-1)
//    minimumUniqueCountLessThanZero(Int.min)
//  }

//  func testUUID() {
//    let b32cf = Base32CrockfordEncoding()
//    (1 ... 20).forEach { _ in
//
//      let uuidb32 = b32cf.generateIdentifier(from: .uuid)
//      let data: Data
//      do {
//        data = try b32cf.decode(base32Encoded: uuidb32)
//        _ = UUID(data: data)
//      } catch {
//        XCTFail(error.localizedDescription)
//      }
//    }
//  }

//  func testGenerateArray() {
//    [Int].random(withCount: 20, in: 0 ... 256).forEach(generateArrayTest(withCount:))
//    generateArrayTest(withCount: 0)
//  }

//  func testGenerateArrayLessThanZero() {
//    [Int].random(withCount: 3, in: Int.min ... -1).forEach(generateArrayLessThanZero(withCount:))
//
//    generateArrayLessThanZero(withCount: -1)
//    generateArrayLessThanZero(withCount: Int.min)
//  }
//
//  func generateArrayLessThanZero(withCount count: Int) {
//    let expectedMessage = "Array count cannot be less than 0."
//    var actualMessage: String?
//    let expectation = self.expectation(description: "expectingFatalError")
//    let b32cf = Base32CrockfordEncoding()
//    let result = b32cf.debugGenerate(
//      count,
//      from: .default,
//      fatalError: { message in
//        actualMessage = message
//        expectation.fulfill()
//      }
//    )
//    waitForExpectations(timeout: 5) { error in
//      XCTAssertNil(error)
//      XCTAssertNil(result)
//      XCTAssertEqual(actualMessage, expectedMessage)
//    }
//  }

//  func generateArrayTest(withCount count: Int) {
//    let b32cf = Base32CrockfordEncoding()
//    let ids = b32cf.generate(count, from: .default)
//    XCTAssertEqual(ids.count, count)
//    XCTAssertNil(ids.first(where: { $0.count != 8 }))
//    XCTAssertNil(ids.first(where: { (try? b32cf.decode(base32Encoded: $0))?.count != 5 }))
//  }
//
//  func minimumUniqueCount(_ count: Int) {
//    let length: Int?
//    if count == 0 {
//      length = 0
//    } else if count < 0 {
//      length = nil
//    } else {
//      let numberOfBytes = Int(ceil(log(Double(count)) / log(256.0)))
//      length = Int(ceil(Double(numberOfBytes) * 8.0 / 5.0))
//    }
//    let b32cf = Base32CrockfordEncoding()
//    let string = b32cf.generateIdentifier(from: .minimumCount(count))
//
//    XCTAssertEqual(string.count, length)
//  }
//
//  func minimumUniqueCountLessThanZero(_ count: Int) {
//    let expectedMessage = "Cannot construct String identifier for unique count less than 0."
//    var actualMessage: String?
//    let expectation = self.expectation(description: "expectingFatalError")
//    let b32cf = Base32CrockfordEncoding()
//    let result = b32cf.debugGenerateIdentifier(from: .minimumCount(count), fatalError: { message in
//      actualMessage = message
//      expectation.fulfill()
//    })
//    waitForExpectations(timeout: 5) { error in
//      XCTAssertNil(error)
//      XCTAssertNil(result)
//      XCTAssertEqual(actualMessage, expectedMessage)
//    }
//  }

  func identifierDataType(_ identifierDataType: IdentifierDataType, isCodableWith string: String) {
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()

    let expectedString = string.components(separatedBy: .whitespacesAndNewlines).joined(separator: "")
    let actualIdentifierDataType = try? decoder.decode(IdentifierDataType.self, from:
      string.data(using: .utf8)!)
    XCTAssertEqual(actualIdentifierDataType, identifierDataType)

    let actualString = (try? encoder.encode(identifierDataType)).map {
      String(data: $0, encoding: .utf8)
    }

    XCTAssertEqual(actualString, expectedString)
  }

  func testIdentifierDataTypeCodable() {
    identifierDataType(.minimumCount(10_000), isCodableWith: """
    {
    "minimumCount" : 10000
    }
    """)

    identifierDataType(.bytes(size: 5), isCodableWith: """
    {
    "bytes" : 5
    }
    """)

    identifierDataType(.uuid, isCodableWith: """
    {
    "type" : "uuid"
    }
    """)
    identifierDataType(.default, isCodableWith: """
    {
    "type" : null
    }
    """)
  }

  static var allTests = [
    ("testExample", testExample)
  ]
}
