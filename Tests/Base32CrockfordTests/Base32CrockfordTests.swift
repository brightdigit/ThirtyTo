import XCTest
@testable import Base32Crockford

final class Base32CrockfordTests: XCTestCase {
    func testExample() {
      let b32cf = Base32Crockford()
      for length in 1...20 {
        print(length, "...",separator: "", terminator: "")
        let bytes = (0...length-1).map{_ in
          UInt8.random(in: 0...UInt8.max)
        }
        let expectedData = Data(bytes: bytes)
        let encodedString = b32cf.encode(data: expectedData)
        let actualData = try! b32cf.decode(string: encodedString)
        XCTAssertEqual(expectedData, actualData)
      }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}



