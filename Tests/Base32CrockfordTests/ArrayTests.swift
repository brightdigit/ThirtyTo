@testable import Base32Crockford
import XCTest

final class ArrayTests: XCTestCase {
  func testBadRandomArray() {
    var tested = false
    let result = Array.debugRandom(withCount: -100, in: 0 ... 100) { actual in
      XCTAssertEqual(actual, "Array count cannot be less than 0.")
      tested = true
    }
    XCTAssertTrue(tested)
    XCTAssertNil(result)
  }
}
