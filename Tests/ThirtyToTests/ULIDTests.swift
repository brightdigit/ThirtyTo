import ThirtyTo
import XCTest

final class ULIDTests: XCTestCase {
  func testBasic() throws {
    _ = ULID()
  }

  func testData() {
    let bytes = Array(uuid: .init())
    let data: Data = .init(bytes)
    let ulid = ULID(specifications: .data(data))

    XCTAssertEqual(data, ulid.data)
  }

  func testParts() {
    let date = Date(timeIntervalSince1970: .random(in: 1_000_000 ... 2_000_000))
    let bytes = Array(uuid: .init())
    let data: Data = .init(bytes)
    let expectedDataPart = data.prefix(10)
    let timestampPart = date.data(withMaximumByteCount: 6)

    let ulid = ULID(specifications: .parts(date, .specific(expectedDataPart)))

    let ulidData = ulid.data

    XCTAssertEqual(ulidData.prefix(6), timestampPart)
    XCTAssertEqual(ulidData.suffix(10), expectedDataPart)

    XCTAssertEqual(ulid.timestamp.timeIntervalSince1970, date.timeIntervalSince1970, accuracy: 100)
    XCTAssertEqual(ulid.randomPart, expectedDataPart)
  }
}
