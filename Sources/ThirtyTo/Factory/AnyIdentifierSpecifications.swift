import Foundation

public struct AnyIdentifierSpecifications {
  internal let randomData: () -> RandomDataGenerator
  internal let size: SizeSpecification

  public init(size: SizeSpecification) {
    self.init(size: size, randomDataGenerator: Data.defaultRandomGenerator())
  }

  public init(
    size: SizeSpecification,
    randomDataGenerator: @autoclosure @escaping () -> RandomDataGenerator
  ) {
    randomData = randomDataGenerator
    self.size = size
  }
}
