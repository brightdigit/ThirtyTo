import Foundation

/// A type that provides uniformly distributed random data.
public protocol RandomDataGenerator {
  /// Creates a new uniformly distributed random data object.
  /// - Parameter count: The number of bytes to fill randomly.
  /// - Returns: New Data object with random bytes.
  mutating func generate(withCount count: Int) -> Data
}
