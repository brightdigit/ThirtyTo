import XCTest
@testable import Base32Crockford

final class Base32CrockfordTests: XCTestCase {
  func testExample() {
    let b32cf = Base32Crockford()
    for length in 1...20 {
      let bytes = (0...length-1).map{_ in
        UInt8.random(in: 0...UInt8.max)
      }
      let expectedData = Data(bytes: bytes)
      let encodedString = b32cf.encode(data: expectedData)
      let actualData = try! b32cf.decode(string: encodedString)
      XCTAssertEqual(expectedData, actualData)
    }
  }
  
  func testMinimumUniqueCount () {
    self.minimumUniqueCount(32, withExpectedLength: 2)
    self.minimumUniqueCount(64, withExpectedLength: 2)
    self.minimumUniqueCount(256, withExpectedLength: 2)
    self.minimumUniqueCount(1000, withExpectedLength: 4)
    self.minimumUniqueCount(256 * 256, withExpectedLength: 4)
    self.minimumUniqueCount(256 * 256 + 1, withExpectedLength: 5)
    //self.minimumUniqueCount(0, withExpectedLength: 0)
  }
  
  func minimumUniqueCount(_ count: Int, withExpectedLength length: Int) {
    
    let b32cf = Base32Crockford()
    let string = b32cf.generate(forMinimumUniqueCount: count)
    XCTAssertEqual(string.count, length)
  }
  
  static var allTests = [
    ("testExample", testExample),
    ]
}



