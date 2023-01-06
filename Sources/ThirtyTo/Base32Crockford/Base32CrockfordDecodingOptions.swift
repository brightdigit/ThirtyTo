import Foundation

/// Options for decoding a Base32Crockford String.
public struct Base32CrockfordDecodingOptions {
  /// Default options.
  public static let none = Base32CrockfordDecodingOptions(withChecksum: false)

  /// Whether to include a checksum character
  public let withChecksum: Bool

  /// Options for decoding a Base32Crockford String.
  /// - Parameter withChecksum: Whether to include a checksum character.
  public init(withChecksum: Bool = false) {
    self.withChecksum = withChecksum
  }
}
