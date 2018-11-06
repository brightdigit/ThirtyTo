import XCTest
@testable import Base32Crockford


extension XCTestCase {
  func expectFatalError(expectedMessage: String, testcase: @escaping () -> Void, completed: @escaping (String?) -> Void) {
    
    // arrange
    let expectation = self.expectation(description: "expectingFatalError")
    var assertionMessage: String? = nil
    
    // override fatalError. This will pause forever when fatalError is called.
    FatalErrorUtil.replaceFatalError { message, _, _ in
      assertionMessage = message
      expectation.fulfill()
      unreachable()
    }
    
    // act, perform on separate thead because a call to fatalError pauses forever
    DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
    
    waitForExpectations(timeout: 5) { _ in
      // assert
      XCTAssertEqual(assertionMessage, expectedMessage)
      
      // clean up
      FatalErrorUtil.restoreFatalError()
      
      completed(assertionMessage)
    }
  }
}

final class Base32CrockfordTests: XCTestCase {
  func testExample() {
    
    let b32cf = Base32CrockfordEncoding()
    for length in 1...20 {
      let bytes = (0...length-1).map{_ in
        UInt8.random(in: 0...UInt8.max)
      }
      let expectedData = Data(bytes: bytes)
      let encodedString = b32cf.encode(data: expectedData)
      let actualData = try! b32cf.decode(string: encodedString)
      XCTAssertEqual(expectedData, actualData)
    }
  }
  
  
  func testMinimumUniqueCount () {
    [Int].random(withCount: 20, in: (0...256)).forEach(self.minimumUniqueCount(_:))
    self.minimumUniqueCount(0)
    //self.minimumUniqueCount(0, withExpectedLength: 0)
    
  }
  
  
  func testMinimumUniqueCountLessThanZero () {
    
    self.minimumUniqueCountLessThanZero(-1)
    self.minimumUniqueCountLessThanZero(Int.min)
  }
  
  func testUUID() {
    let b32cf = Base32CrockfordEncoding()
    (1...20).forEach { _ in
      
      let uuidb32 = b32cf.generateFromUUID()
      let data = try! b32cf.decode(string: uuidb32)
      let uuid = UUID(data: data)
      
    }
  }
  
  func testGenerateArray () {
    
    [Int].random(withCount: 20, in: (0...256)).forEach(self.generateArrayTest(withCount: ))
    self.generateArrayTest(withCount: 0)
    
  }
  
  func testGenerateArrayLessThanZero () {
    
    [Int].random(withCount: 3, in: (Int.min ... -1)).forEach(self.generateArrayLessThanZero(withCount: ))
    
    self.generateArrayLessThanZero(withCount: -1)
    self.generateArrayLessThanZero(withCount: Int.min)
  }
  
  func generateArrayLessThanZero (withCount count: Int) {
    let b32cf = Base32CrockfordEncoding()
    let semaphore = DispatchSemaphore(value: 0)
    expectFatalError(expectedMessage: "Array count cannot be less than 0.", testcase: {
      b32cf.generateArray(withCount: count)
      
    }, completed: {
      XCTAssertNotNil($0, "\(count) does not fatalError.")

      semaphore.signal()
      
    })
    semaphore.wait()
    sleep(5)
  }
  
  func generateArrayTest (withCount count: Int) {
    
    let b32cf = Base32CrockfordEncoding()
    let ids = b32cf.generateArray(withCount: count)
    XCTAssertEqual(ids.count, count)
    XCTAssertNil(ids.first(where: {$0.count != 8}))
    XCTAssertNil(ids.first(where: {try! b32cf.decode(string: $0).count != 5}))
  }
  
  func minimumUniqueCount(_ count: Int) {
    let length : Int?
    if count == 0 {
      length = 0
    } else if count < 0 {
      length = nil
    } else {
      let numberOfBytes = Int(ceil(log(Double(count))/log(256.0)))
      length = Int(ceil(Double(numberOfBytes) * 8.0 / 5.0))
    }
    let b32cf = Base32CrockfordEncoding()
    let string = b32cf.generate(forMinimumUniqueCount: count)
    
    XCTAssertEqual(string.count, length)
  }
  
  
  func minimumUniqueCountLessThanZero (_ count: Int) {
    let b32cf = Base32CrockfordEncoding()
    let semaphore = DispatchSemaphore(value: 0)
    expectFatalError(expectedMessage: "Cannot construct String identifier for unique count less than 0.", testcase: {
      b32cf.generate(forMinimumUniqueCount: count)
      
    }, completed: {
      XCTAssertNotNil($0, "\(count) does not fatalError.")
      
      semaphore.signal()
      
    })
    semaphore.wait()
    sleep(100)
  }
  
  
  static var allTests = [
    ("testExample", testExample),
    ]
}



