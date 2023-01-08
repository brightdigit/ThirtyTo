@testable import ThirtyTo
import XCTest

final class SizeSpecificationTests: XCTestCase {
  func testBytes() {
    let count: Int = .random(in: 1 ... 1_000)
    let specs = SizeSpecification.bytes(count)
    XCTAssertEqual(specs.byteCount, count)
  }

  func testMinimumCount() {
    let count: Int = .random(in: 1 ... 1_000)
    let specs = SizeSpecification.bytes(count)
    XCTAssertEqual(specs.byteCount, count)
  }

  fileprivate func runTestOn(_ minimumUniqueCount: Double, _ factor: Int?, _ expectedByteSize: Int) {
    let specs = SizeSpecification.minimumCount(minimumUniqueCount, factorOf: factor)
    XCTAssertEqual(specs.byteCount, expectedByteSize)
  }

  func testMinimumCountWithFactor() {
    runTestOn(1_000, nil, 2)
    runTestOn(1_000_000, nil, 3)
    runTestOn(1_000, 2, 2)
    runTestOn(1_000_000, 2, 4)
    runTestOn(1_000_000_000, 2, 4)
    runTestOn(2.93874e+25, nil, 11)
    runTestOn(2.93874e+25, 4, 12)
  }

  func testMinimumCountForBase32() {
    XCTAssertEqual(SizeSpecification.base32Optimized(forUniqueCountOf: 1_000).byteCount, 5)
    XCTAssertEqual(SizeSpecification.base32Optimized(forUniqueCountOf: 1_000_000).byteCount, 5)
    XCTAssertEqual(SizeSpecification.base32Optimized(forUniqueCountOf: 2.93874e+25).byteCount, 15)
  }
}
