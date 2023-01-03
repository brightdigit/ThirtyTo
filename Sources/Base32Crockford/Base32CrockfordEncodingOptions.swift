import Foundation

public struct Base32CrockfordEncodingOptions: OptionSet {
  public static let withChecksum = Base32CrockfordEncodingOptions(rawValue: 1 << 0)
  public static let none: Base32CrockfordEncodingOptions = []

  public let rawValue: Int

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
}
