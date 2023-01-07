@testable import ThirtyTo
import XCTest

class MockNumberGenerator: RandomNumberGenerator {
  
  var callCount = 0
  func next() -> UInt64 {
    defer {
      callCount += 1
    }
    return 12
  }
}
class MockRandomGenerator: RandomDataGenerator {
  var callCount = 0
  func generate(withCount count: Int) -> Data {
    defer {
      callCount += 1
    }
    return Data(count: count)
  }
}

final class IdentifierTests: XCTestCase {
  public func testFactory() {
    let identifier = Identifier.factory.anyIdentifier(withSize: .bytes(12))

    XCTAssertEqual(identifier.data.count, 12)
  }

  public func testFactoryWithGenerator() {
    let generator = MockRandomGenerator()
    let identifierSpecs = AnyIdentifierSpecifications(size: .bytes(12), randomDataGenerator: generator)
    let identifier = Identifier.factory.anyIdentifierWith(identifierSpecs)

    XCTAssertEqual(identifier.data.count, 12)
    XCTAssertEqual(generator.callCount, 1)
  }

  public func testFactoryUsingNumberedDataGenerator() {
    let generator = NumberedDataGenerator(generator: SystemRandomNumberGenerator())
    let identifierSpecs = AnyIdentifierSpecifications(size: .bytes(102), randomDataGenerator: generator)
    let identifier = Identifier.factory.anyIdentifierWith(identifierSpecs)

    XCTAssertEqual(identifier.data.count, 102)
  }

  func testUUID() {
    let identifier = Identifier.factory.createIdentifier(UUID.self)
    XCTAssertEqual(identifier.data.count, 16)
  }

  func testUDID() {
    let generator = MockRandomGenerator()
    func runTestOn(_ minimumUniqueCount: Double, _ factor: Int?, _ expectedByteSize: Int) {
      let specs = AnyIdentifierSpecifications(size: SizeSpecification.minimumCount(minimumUniqueCount, factorOf: factor), randomDataGenerator: generator)
      let identifier: UDID = Identifier.factory.createIdentifier(with: specs)
      XCTAssertEqual(identifier.data.count, expectedByteSize)
    }

    runTestOn(1_000, nil, 2)
    runTestOn(1_000_000, nil, 3)
    runTestOn(1_000, 2, 2)
    runTestOn(1_000_000, 2, 4)
    runTestOn(1_000_000_000, 2, 4)
    runTestOn(2.93874e+25, nil, 11)
    runTestOn(2.93874e+25, 4, 12)
    XCTAssertEqual(generator.callCount, 7)
  }
}
