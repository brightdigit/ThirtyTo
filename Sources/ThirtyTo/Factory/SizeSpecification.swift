import Foundation

public enum SizeSpecification {
  case bytes(Int)
  case minimumCount(Double, factorOf: Int?)

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
