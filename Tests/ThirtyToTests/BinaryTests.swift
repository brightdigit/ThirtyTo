@testable import ThirtyTo
import XCTest

final class BinaryTests: XCTestCase {
  func testBinaryValues() {
    var value = Binary(data: .init([UInt8(8)]), sectionSize: 5)
    XCTAssertEqual(value.readingOffset, -2)
    var section: Int?
    var lastSectionValue: Int = -1
    repeat {
      section = value.nextSection()
      if let section = section {
        lastSectionValue = section
      }
    } while section != nil
    XCTAssertEqual(8, lastSectionValue)
  }
}
