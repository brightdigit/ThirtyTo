import Foundation

/// An error which occured in decoding a Base32Crockford String.
public struct Base32CrockfordDecodingError: Error {
  /// Type of error which occured
  public enum Details {
    // invalid checksum
    case checksum(Int, mismatchValue: Int?)
    // unacceptable character
    case invalidCharacter(Character)
  }

  /// The source string which triggered the error
  public let source: String

  /// The details of the type of error.
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
