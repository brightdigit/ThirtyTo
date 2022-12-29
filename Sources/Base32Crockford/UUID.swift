import Foundation

extension UUID {
  public init(data: Data) {
    var bytes = [UInt8](repeating: 0, count: data.count)
    _ = bytes.withUnsafeMutableBufferPointer {
      data.copyBytes(to: $0)
    }
    self = NSUUID(uuidBytes: bytes) as UUID
  }
}
