#if canImport(Security)
  import Foundation
  import Security

  /// Uses `SecRandomCopyBytes` to generate a random `Data` object.
  public struct SecRandomDataGenerator: RandomDataGenerator {
    /// ``SecRandomDataGenerator`` does not need to be created.
    /// Just use this static instance.
    public static let shared = SecRandomDataGenerator()

    private init() {}

    /// Creates a new uniformly distributed random data object.
    /// - Parameter count: The number of bytes to fill randomly.
    /// - Returns: New Data object with random bytes.
    public func generate(withCount count: Int) -> Data {
      var bytes = [Int8](repeating: 0, count: count)

      // Fill bytes with secure random data
      let status = SecRandomCopyBytes(
        kSecRandomDefault,
        count,
        &bytes
      )

      assert(status == errSecSuccess)
      // Convert bytes to Data
      return Data(bytes: bytes, count: count)
    }
  }
#endif
