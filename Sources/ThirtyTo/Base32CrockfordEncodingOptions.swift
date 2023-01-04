import Foundation

/// Options on encoding `Data` as String in Base32Crockford.
public struct Base32CrockfordEncodingOptions {
  /// Options for grouping characters based on a group maximum length.
  public struct GroupingOptions {
    /// Set the maximum length for a Base32Crockford group within a `String`
    /// - Parameter maxLength: The maximum length for a group of charcters
    public init(maxLength: Int) {
      self.maxLength = maxLength
    }

    /// The maximum length for a group of charcters separated by hyphens.
    public let maxLength: Int

    /// Hyphen separator
    public static let separator: String = "-"
  }

  /// Default encoding options.
  public static let none = Base32CrockfordEncodingOptions(withChecksum: false)

  /// Whether to include a checksum character.
  public let withChecksum: Bool

  /// Whether to separate groups of characters by a hyphen.
  public let groupingBy: GroupingOptions?

  /// Set checksum and grouping options for encoding.
  /// - Parameters:
  ///   - withChecksum: Include a checksum character.
  ///   - groupingBy: Separate groups of characters by a hyphen.
  public init(
    withChecksum: Bool = false,
    groupingBy: Base32CrockfordEncodingOptions.GroupingOptions? = nil
  ) {
    self.withChecksum = withChecksum
    self.groupingBy = groupingBy
  }
}
