import Foundation

public struct Base32CrockfordDecodingOptions {
  public static let none = Base32CrockfordDecodingOptions(withChecksum: false)
  public let withChecksum: Bool
}
