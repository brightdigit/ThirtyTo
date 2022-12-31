import Foundation

extension Array where Element == UInt8 {
  public init(uuid: UUID) {
    // swiftlint:disable:next force_cast
    self = Mirror(reflecting: uuid.uuid).children.map { $0.value as! UInt8 }
  }
}

extension Array where Element: FixedWidthInteger {
  public static func random(
    withCount count: Int,
    in range: ClosedRange<Element>? = nil
  ) -> Array {
    // swiftlint:disable:next force_unwrapping
    random(withCount: count, in: range, fatalError: nil)!
  }

  #if DEBUG
    internal static func debugRandom(
      withCount count: Int,
      in range: ClosedRange<Element>? = nil,
      fatalError: ((String?) -> Void)? = nil
    ) -> Array? {
      random(withCount: count, in: range, fatalError: fatalError)
    }
  #endif

  private static func random(
    withCount count: Int,
    in range: ClosedRange<Element>? = nil,
    fatalError: ((String?) -> Void)? = nil
  ) -> Array? {
    let range = range ?? (Element.min ... Element.max)
    // swiftlint:disable empty_count
    guard count >= 0 else {
      if let fatalError = fatalError {
        fatalError("Array count cannot be less than 0.")
        return nil
      } else {
        Swift.fatalError("Array count cannot be less than 0.")
      }
    }

    // swiftlint:enable empty_count
    guard count >= 1 else {
      return [Element]()
    }
    return (1 ... count).map { _ in
      Element.random(in: range)
    }
  }
}
