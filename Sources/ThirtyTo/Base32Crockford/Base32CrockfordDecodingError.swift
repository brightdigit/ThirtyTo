import Foundation

/// An error which occured in decoding a Base32Crockford String.
public struct Base32CrockfordDecodingError: Error {
  /// Type of error which occured
  public enum Details {
    /// Mismatch checksum.
    /// - Parameter checksum: Expected checksum value.
    /// - Parameter mismatchValue: Actual checksum value.
    case checksum(Int, mismatchValue: Int?)
    // swiftlint:disable line_length
    /// Invalid character.
    /// - Parameter invalidCharacter: The character which is invalid in a Base32Crockford string.
    ///
    /// For a list of valid symbols go to ``Base32CrockfordEncoding/CharacterSets/symbols``.
    case invalidCharacter(Character)
    // swiftlint:enable line_length
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
