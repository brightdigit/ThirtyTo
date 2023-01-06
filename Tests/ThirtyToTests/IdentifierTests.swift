//
//  IdentifierTests.swift
//  
//
//  Created by Leo Dion on 1/5/23.
//

import XCTest
@testable import ThirtyTo

class MockRandomGenerator : RandomDataGenerator {
  var callCount = 0
  func generate(withCount count: Int) -> Data {
    defer{
      callCount += 1
    }
    return Data(count: count)
  }
  
  
}

final class IdentifierTests: XCTestCase {

  public func testFactory() {
    let identifier = Identifer.factory.anyIdentifier(withSize: .bytes(12))
    
    XCTAssertEqual(identifier.data.count, 12)
  }
  
  
  public func testFactoryWithGenerator() {
    
      let generator = MockRandomGenerator()
    let identifierSpecs = AnyIdentifierSpecifications(size: .bytes(12), randomDataGenerator: generator)
    let identifier = Identifer.factory.anyIdentifierWith(identifierSpecs)
      
      XCTAssertEqual(identifier.data.count, 12)
    XCTAssertEqual(generator.callCount, 1)
  }
  

  public func testFactoryUsingNumberedDataGenerator() {
    
      let generator = NumberedDataGenerator(generator: SystemRandomNumberGenerator())
    let identifierSpecs = AnyIdentifierSpecifications(size: .bytes(102), randomDataGenerator: generator)
    let identifier = Identifer.factory.anyIdentifierWith(identifierSpecs)
      
      XCTAssertEqual(identifier.data.count, 102)
  }
  
  
  func testUUID () {
    let identifier = Identifer.factory.createIdentifier(UUID.self)
    XCTAssertEqual(identifier.data.count, 16)
  }
  
  func testUDID () {
    let generator = MockRandomGenerator()
    func runTestOn(_ minimumUniqueCount: Double, _ factor: Int?, _ expectedByteSize: Int) {
      let specs = AnyIdentifierSpecifications(size:  SizeSpecification.minimumCount(minimumUniqueCount, factorOf: factor), randomDataGenerator: generator)
      let identifier : UDID = Identifer.factory.createIdentifier(with: specs)
      XCTAssertEqual(identifier.data.count, expectedByteSize)
    }
    
    
      runTestOn(1000, nil, 2)
      runTestOn(1000000, nil,   3)
      runTestOn(1000,  2,  2)
      runTestOn(1000000,  2, 4)
      runTestOn(1000000000,  2, 4)
      runTestOn(2.93874E+25,  nil,  11)
      runTestOn(2.93874E+25,  4,  12)
    XCTAssertEqual(generator.callCount, 7)
    
    
  
  }
}
