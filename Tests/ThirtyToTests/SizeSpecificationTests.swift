//
//  SizeSpecificationTests.swift
//  
//
//  Created by Leo Dion on 1/6/23.
//

import XCTest
@testable import ThirtyTo

final class SizeSpecificationTests: XCTestCase {
  func testBytes () {
    let count : Int = .random(in: 1...1000)
    let specs = SizeSpecification.bytes(count)
    XCTAssertEqual(specs.byteCount, count)
  }
  
  func testMinimumCount() {
    
    let count : Int = .random(in: 1...1000)
    let specs = SizeSpecification.bytes(count)
    XCTAssertEqual(specs.byteCount, count)
  }
  
  
  fileprivate func runTestOn(_ minimumUniqueCount: Double, _ factor: Int?, _ expectedByteSize: Int) {
    let specs = SizeSpecification.minimumCount(minimumUniqueCount, factorOf: factor)
    XCTAssertEqual(specs.byteCount, expectedByteSize)
  }
  
  func testMinimumCountWithFactor() {
    runTestOn(1000, nil, 2)
    runTestOn(1000000, nil,   3)
    runTestOn(1000,  2,  2)
    runTestOn(1000000,  2, 4)
    runTestOn(1000000000,  2, 4)
    runTestOn(2.93874E+25,  nil,  11)
    runTestOn(2.93874E+25,  4,  12)
  }
  
  
  func testMinimumCountForBase32() {
    XCTAssertEqual(SizeSpecification.base32Optimized(forUniqueCountOf: 1000).byteCount, 5)
    XCTAssertEqual(SizeSpecification.base32Optimized(forUniqueCountOf: 1000000).byteCount, 5)
    XCTAssertEqual(SizeSpecification.base32Optimized(forUniqueCountOf: 2.93874E+25).byteCount, 15)
  }
}
