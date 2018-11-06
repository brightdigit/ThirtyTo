import Foundation

extension Array where Element == UInt8 {
  public init(uuid: UUID) {
    self = Mirror(reflecting: uuid.uuid).children.map{ $0.value as! UInt8}
  }
}

extension Array where Element : FixedWidthInteger {
  public static func random(withCount count: Int, in range: ClosedRange<Element>? = nil) -> Array {
    let range = range ?? (Element.min...Element.max)
    guard count >= 0 else {
      fatalError("Array count cannot be less than 0.")
    }
    guard count >= 1 else {
      return [Element]()
    }
    return (1...count).map{
      _ in
      Element.random(in: range)
    }
  }
}

