import Foundation

/// Wrapper for `RandomNumberGenerator` to generate `Data`.
public struct NumberedDataGenerator<
  NumberGeneratorType: RandomNumberGenerator
>: RandomDataGenerator {
  private var generator: NumberGeneratorType

  /// Creates a ``RandomDataGenerator`` from a `RandomNumberGenerator`.
  /// - Parameter generator: The `RandomNumberGenerator`.
  public init(generator: NumberGeneratorType) {
    self.generator = generator
  }

  /// Creates a new uniformly distributed random data object.
  /// - Parameter count: The number of bytes to fill randomly.
  /// - Returns: New Data object with random bytes.
  public mutating func generate(withCount count: Int) -> Data {
    var data = Data(capacity: count)
    while data.count < count {
      data.append(generator.next())
    }
    return data
  }
}
