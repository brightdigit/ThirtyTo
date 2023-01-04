import Foundation

/// Encoder and Decoder for Base32Crockford.
public struct Base32CrockfordEncoding {
  /// Shared encoding object.
  public static let encoding = Base32CrockfordEncoding()

  private func validate(
    _ result: Data,
    from standardized: String,
    withChecksum checksum: Character
  ) throws {
    let expected = Self.CharacterSets.checkSymbols.firstOffsetOf(character: checksum)
    let actual = result.remainderBy(Self.CharacterSets.checkSymbols.count)

    guard expected == actual else {
      throw Base32CrockfordDecodingError.checksumError(
        from: standardized,
        actualValue: actual,
        expectedValue: expected
      )
    }
  }

  private func decode(
    standardizedString standardized: String,
    options: Base32CrockfordDecodingOptions = .none
  ) throws -> Data {
    let (valueString, checksum) = standardized.split(withChecksum: options.withChecksum)

    let values = try valueString.offsets(
      basedOnCharacterMap: Self.CharacterSets.symbols,
      onInvalidCharacter: Base32CrockfordDecodingError.invalidCharacter(_:from:)
    )

    let bitString = values.map { String($0, radix: 2).pad(toSize: 5) }.joined()
    let dataBytes = bitString.split(by: 8).compactMap { UInt8($0, radix: 2) }
    let expectedByteCount = ((bitString.count - 1) / 8) + 1

    // swiftlint:disable:next line_length
    assert(expectedByteCount == dataBytes.count, "Expected \(expectedByteCount) bytes from \(bitString.count) bits but received \(dataBytes.count)")

    let result = Data(dataBytes)

    guard let checksum = checksum else {
      return result
    }

    try validate(result, from: standardized, withChecksum: checksum)

    return result
  }

  /// Encode the data to a Base32Crockford string.
  /// - Parameters:
  ///   - data: The Data to encode
  ///   - options: Encoding options.
  /// - Returns: Base32Crockford String.
  public func encode(
    data: Data,
    options: Base32CrockfordEncodingOptions = .none
  ) -> String {
    var binary = Binary(data: data, sectionSize: 5)
    var encodedString = binary.string(basedOnCharacterMap: Self.CharacterSets.symbols)

    if options.withChecksum {
      encodedString.append(
        Self.CharacterSets.checkSymbols.characterAtOffset(
          data.remainderBy(
            Self.CharacterSets.checkSymbols.count
          )
        )
      )
    }

    encodedString = encodedString
      .replacingOccurrences(of: "^0+", with: "", options: .regularExpression)

    guard let groupingOptions = options.groupingBy else {
      return encodedString
    }

    return encodedString
      .split(by: groupingOptions.maxLength)
      .joined(
        separator: Base32CrockfordEncodingOptions.GroupingOptions.separator
      )
  }

  /// Decode a Base32Crockford String.
  /// - Parameters:
  ///   - string: The Base32Crockford String.
  ///   - options: Options for decoding a Base32Crockford String.
  /// - Throws: `Base32CrockfordDecodingError`
  ///  If there's an invalid character or checksum value.
  /// - Returns: Decoded Data
  public func decode(
    base32Encoded string: String,
    options: Base32CrockfordDecodingOptions = .none
  ) throws -> Data {
    let standardized = standardize(string: string)
    return try decode(standardizedString: standardized, options: options)
  }

  /// Standardizes a Base32Crockford encoded string by
  /// * Converting O,I,L to their respective digits
  /// * Removing all group separating hyphens
  /// * Convert all alphabet characters to uppercase.
  ///
  /// - Parameter string: The String to standardize.
  /// - Returns: The standardized String.
  public func standardize(string: String) -> String {
    string
      .uppercased()
      .replacingOccurrences(of: "O", with: "0")
      .replacingOccurrences(of: "I", with: "1")
      .replacingOccurrences(of: "L", with: "1")
      .replacingOccurrences(of: "-", with: "")
  }
}
