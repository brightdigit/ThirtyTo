import Foundation
import ThirtyTo

class MockNumberGenerator: RandomNumberGenerator {
  var callCount = 0
  func next() -> UInt64 {
    defer {
      callCount += 1
    }
    return 12
  }
}
