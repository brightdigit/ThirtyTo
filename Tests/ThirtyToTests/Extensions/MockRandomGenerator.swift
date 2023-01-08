import Foundation
import ThirtyTo

class MockRandomGenerator: RandomDataGenerator {
  var callCount = 0
  func generate(withCount count: Int) -> Data {
    defer {
      callCount += 1
    }
    return Data(count: count)
  }
}
