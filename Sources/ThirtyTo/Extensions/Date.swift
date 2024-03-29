import Foundation

extension Date {
  /// Creates a Date object based on the data object.
  /// - Parameter timestampData: Data based on the unix timestamp.
  public init(timestampData: Data) {
    var data = timestampData
    data.append(contentsOf: .init(repeating: 0, count: max(0, 8 - data.count)))
    let timestamp64 = data.withUnsafeBytes { $0.load(as: UInt64.self) }
    let timeInterval = TimeInterval(timestamp64.bigEndian) / 1_000.0
    self.init(timeIntervalSince1970: timeInterval)
  }

  /// Create a Data object based on the number bytes specified.
  /// - Parameter byteCount: The number of bytes to create the timestamp from.
  /// - Returns: Data object with precision based on the  number of bytes requested.
  public func data(withMaximumByteCount byteCount: Int?) -> Data {
    var timestamp = UInt64(timeIntervalSince1970 * 1_000).bigEndian
    let data = withUnsafeBytes(of: &timestamp) { Data($0) }
    guard let byteCount = byteCount else {
      return data
    }
    assert(byteCount <= 8)
    return data.prefix(byteCount)
  }
}
