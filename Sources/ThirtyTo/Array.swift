import Foundation

extension Array where Element == UInt8 {
  /// Create an array of bytes based on the UUID.
  /// - Parameter uuid: UUID to convert to bytes.
  public init(uuid: UUID) {
    // swiftlint:disable:next force_cast
    self = Mirror(reflecting: uuid.uuid).children.map { $0.value as! UInt8 }
  }
  
}
