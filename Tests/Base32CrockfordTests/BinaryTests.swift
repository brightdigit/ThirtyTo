//
//  BinaryTests.swift
//  
//
//  Created by Leo Dion on 12/31/22.
//

import XCTest
import Base32Crockford

final class BinaryTests: XCTestCase {

  func testBinaryValues () {    
    var value = Binary(data: .init([UInt8(8)]), sectionSize: 5)
    XCTAssertEqual(value.readingOffset, -2)
    var section : Int?
    var lastSectionValue : Int = -1
    repeat {
      section = value.nextSection()
      if let section {
        lastSectionValue = section
      }
    } while section != nil
    XCTAssertEqual(8, lastSectionValue)
  }

}
