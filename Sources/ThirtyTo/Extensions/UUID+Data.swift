import Foundation

extension UUID {
  /// Create a UUID from bytes.
  /// - Parameter data: Bytes of the UUID.
  public init(data: Data) {
    assert(data.count == 16)
    let uuidC = data.withUnsafeBytes {
      $0.load(as: uuid_t.self)
    }
    self.init(uuid: uuidC)
  }
}
