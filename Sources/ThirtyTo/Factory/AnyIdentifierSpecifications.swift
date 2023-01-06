import Foundation

public struct AnyIdentifierSpecifications {
  public init(size: SizeSpecification) {
    self.init(size: size, randomDataGenerator: Data.defaultRandomGenerator())
  }

  public init(size: SizeSpecification, randomDataGenerator: @autoclosure @escaping () -> RandomDataGenerator) {
    randomData = randomDataGenerator
    self.size = size
  }

  let randomData: () -> RandomDataGenerator
  let size: SizeSpecification
}
