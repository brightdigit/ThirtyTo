//
//  IdentifierTests.swift
//  
//
//  Created by Leo Dion on 1/5/23.
//

import XCTest
import ThirtyTo

final class IdentifierTests: XCTestCase {

  public func testFactory() {
    let identifier = Identifer.factory.anyIdentifierWith(.bytes(12))
    
    XCTAssertEqual(identifier.data.count, 12)
    
  }

}
