#if canImport(Security)
  import Foundation
  import Security

  public struct SecRandomDataGenerator: RandomDataGenerator {
    public static let shared = SecRandomDataGenerator()

    private init() {}

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
