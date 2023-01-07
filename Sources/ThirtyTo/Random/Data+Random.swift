import Foundation

extension Data {
  public static func defaultRandomGenerator() -> RandomDataGenerator {
    #if canImport(Security)
      return SecRandomDataGenerator.shared
    #else
      return NumberedDataGenerator(generator: SystemRandomNumberGenerator())
    #endif
  }

  public static func random(
    count: Int,
    using generator: inout RandomDataGenerator
  ) -> Data {
    generator.generate(withCount: count)
  }

  public static func random<T>(
    count: Int,
    using numberGenerator: inout T
  ) -> Data where T: RandomNumberGenerator {
    let numberGenerator = NumberedDataGenerator(generator: numberGenerator)
    var dataGenerator: RandomDataGenerator = numberGenerator
    return Self.random(count: count, using: &dataGenerator)
  }

  public static func random(count: Int) -> Data {
    #if canImport(Security)
      return SecRandomDataGenerator.shared.generate(withCount: count)
    #else
      var numberGenerator = SystemRandomNumberGenerator()
      return random(count: count, using: &numberGenerator)
    #endif
  }
}
