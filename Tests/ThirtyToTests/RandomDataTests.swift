//
//  RandomDataTests.swift
//  
//
//  Created by Leo Dion on 1/6/23.
//

import XCTest
@testable import ThirtyTo

final class RandomDataTests: XCTestCase {

  func testRandomGenerator() {
    let count : Int =  .random(in: 100...200)
    let mockGenerator = MockRandomGenerator()
    var generator: RandomDataGenerator = mockGenerator
    
    let data = Data.random(count: count, using: &generator)
    XCTAssertEqual(mockGenerator.callCount, 1)
    XCTAssertEqual(count, data.count )
  }

  
  func testRandomDefault() {
    let count =  Int.random(in: 100...200)
    let data = Data.random(count: count)
    XCTAssertEqual(count, data.count )
  }
}
