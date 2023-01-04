import Foundation

public struct Base32CrockfordDecodingError: Error {
  public enum Details {
    case checksum(Int, mismatchValue: Int?)
    case invalidCharacter(Character)
  }

  public let source: String
  public let details: Details

  private init(source: String, details: Base32CrockfordDecodingError.Details) {
    self.source = source
    self.details = details
  }

  internal static func checksumError(
    from string: String,
    actualValue: Int,
    expectedValue: Int?
  ) -> Base32CrockfordDecodingError {
    .init(source: string, details: .checksum(actualValue, mismatchValue: expectedValue))
  }

  internal static func invalidCharacter(
    _ character: Character,
    from source: String
  ) -> Base32CrockfordDecodingError {
    .init(source: source, details: .invalidCharacter(character))
  }
}
