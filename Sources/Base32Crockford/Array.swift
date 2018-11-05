import Foundation

extension Array where Element == UInt8 {
  init(uuid: UUID) {
    self = Mirror(reflecting: uuid.uuid).children.map{ $0.value as! UInt8}
  }
}