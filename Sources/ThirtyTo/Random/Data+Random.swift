import Foundation

extension Data {
  /// Creates the default `RandomDataGenerator` based on the operating system.
  /// - Returns: For Apple OSes, this uses `SecRandomCopyBytes`
  ///    otherwise it uses `SystemRandomNumberGenerator`.
  public static func defaultRandomGenerator() -> RandomDataGenerator {
    #if canImport(Security)
      return SecRandomDataGenerator.shared
    #else
      return NumberedDataGenerator(generator: SystemRandomNumberGenerator())
    #endif
  }

  /// Creates a Data object based on the `RandomDataGenerator` and the number of bytes.
  /// - Parameters:
  ///   - count: The number of bytes to create.
  ///   - generator: The `RandomDataGenerator`
  /// - Returns: `Data` object.
  public static func random(
    count: Int,
    using generator: inout RandomDataGenerator
  ) -> Data {
    generator.generate(withCount: count)
  }

  /// Creates a Data object based on the `RandomNumberGenerator` and the number of bytes.
  /// - Parameters:
  ///   - count: The number of bytes to create.
  ///   - numberGenerator: The `RandomNumberGenerator`
  /// - Returns: `Data` object.
  public static func random<T>(
    count: Int,
    using numberGenerator: inout T
  ) -> Data where T: RandomNumberGenerator {
    let numberGenerator = NumberedDataGenerator(generator: numberGenerator)
    var dataGenerator: RandomDataGenerator = numberGenerator
    return Self.random(count: count, using: &dataGenerator)
  }

  /// Creates a Data object based on the default `RandomDataGenerator`
  ///  and the number of bytes.
  /// - Parameters:
  ///   - count: The number of bytes to create.
  /// - Returns: `Data` object.
  public static func random(count: Int) -> Data {
    #if canImport(Security)
      return SecRandomDataGenerator.shared.generate(withCount: count)
    #else
      var numberGenerator = SystemRandomNumberGenerator()
      return random(count: count, using: &numberGenerator)
    #endif
  }
}
