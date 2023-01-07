import XCTest

final class TimestampDataTests: XCTestCase {
  func testDateData() {
    let date = Date()

    var size = 8
    var expectedDifference = 0.001
    repeat {
      let data = date.data(withMaximumByteCount: size)
      let actualDate = Date(timestampData: data)
      let difference = abs(actualDate.timeIntervalSince(date))
      print(difference, expectedDifference)
      XCTAssertLessThan(difference, expectedDifference)
      size -= 1
      expectedDifference *= 256
    } while size >= 1
  }
}
