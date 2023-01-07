import Foundation

/// Specifications for building an identifier.
public struct AnyIdentifierSpecifications {
  internal let randomData: () -> RandomDataGenerator
  internal let size: SizeSpecification

  /// Creates a specification for the indentifier.
  /// - Parameter size: Specifications which calculate the size of the identifier.
  public init(size: SizeSpecification) {
    self.init(size: size, randomDataGenerator: Data.defaultRandomGenerator())
  }

  /// Creates a specification for the indentifier.
  /// - Parameters:
  ///   - size: Specifications which calculate the size of the identifier.
  ///   - randomDataGenerator: For building the underlying Data object.
  public init(
    size: SizeSpecification,
    randomDataGenerator: @autoclosure @escaping () -> RandomDataGenerator
  ) {
    randomData = randomDataGenerator
    self.size = size
  }
}
