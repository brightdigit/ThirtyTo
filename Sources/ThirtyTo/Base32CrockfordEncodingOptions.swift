import Foundation

public struct Base32CrockfordEncodingOptions {
  public struct GroupingOptions {
    public init(maxLength: Int) {
      self.maxLength = maxLength
    }

    public let maxLength: Int
    public let separator: String = "-"
  }

  public static let none = Base32CrockfordEncodingOptions(withChecksum: false)

  public let withChecksum: Bool
  public let groupingBy: GroupingOptions?

  internal init(
    withChecksum: Bool = false,
    groupingBy: Base32CrockfordEncodingOptions.GroupingOptions? = nil
  ) {
    self.withChecksum = withChecksum
    self.groupingBy = groupingBy
  }
}
