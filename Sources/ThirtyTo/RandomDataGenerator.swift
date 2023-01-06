import Foundation

public protocol RandomDataGenerator {
  mutating func generate(withCount count: Int) -> Data
}
