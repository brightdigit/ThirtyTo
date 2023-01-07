import Foundation

/// Specifies the size of the identifier to use.
public enum SizeSpecification {
  /// The exact number of bytes
  case bytes(Int)
  /// Based on the number of unique values and a whether it needs to be a factor.
  case minimumCount(Double, factorOf: Int?)

  /// Creates a `SizeSpecification` based on the number of unique values
  /// which is optimized the Base32.
  /// - Parameter count: The minimum number of unique values
  /// - Returns: The `SizeSpecification`
  public static func base32Optimized(
    forUniqueCountOf count: Double
  ) -> SizeSpecification {
    .minimumCount(count, factorOf: 5)
  }
}

extension SizeSpecification {
  internal var byteCount: Int {
    switch self {
    case let .bytes(byteCount):
      return byteCount

    case let .minimumCount(uniqueCount, factorOf: factor):
      return Self.bytesRequired(
        forUniqueCountOf: uniqueCount,
        factorOf: factor
      )
    }
  }

  private static func bytesRequired(
    forUniqueCountOf count: Double,
    factorOf factor: Int?
  ) -> Int {
    var floatingCount = log(count) / log(256.0)

    if let factor = factor.map(Double.init) {
      let remainder = floatingCount.truncatingRemainder(dividingBy: factor)
      if remainder > 0 {
        floatingCount += (factor - remainder)
      }
    }

    return Int(ceil(floatingCount))
  }
}
