import Foundation

public struct Base32CrockfordEncoding {
  public static let encoding = Base32CrockfordEncoding()
  private static let characters = "0123456789ABCDEFGHJKMNPQRSTVWXYZ"
  private static let checkSymbols = "*~$=U"
  public static let allChecksumSymbols = characters + checkSymbols

  private func validate(
    _ result: Data,
    from standardized: String,
    withChecksum checksum: Character
  ) throws {
    let expected = Self.allChecksumSymbols.firstOffsetOf(character: checksum)
    let actual = result.remainderBy(Self.allChecksumSymbols.count)

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
      basedOnCharacterMap: Self.characters,
      onInvalidCharacter: Base32CrockfordDecodingError.invalidCharacter(_:from:)
    )

    let bitString = values.map { String($0, radix: 2).pad(toSize: 5) }.joined()
    let dataBytes = bitString.split(by: 8).compactMap { UInt8($0, radix: 2) }
    let expectedByteCount = ((bitString.count - 1) / 8) + 1

    // swiftlint:disable:next line_length
    precondition(expectedByteCount == dataBytes.count, "Expected \(expectedByteCount) bytes from \(bitString.count) bits but received \(dataBytes.count)")

    let result = Data(dataBytes)

    guard let checksum = checksum else {
      return result
    }

    try validate(result, from: standardized, withChecksum: checksum)

    return result
  }

  public func encode(
    data: Data,
    options: Base32CrockfordEncodingOptions = .none
  ) -> String {
    var encodedString = ""
    var index: Int?

    var binary = Binary(data: data, sectionSize: 5)
    repeat {
      index = binary.nextSection()
      guard let index = index else {
        break
      }
      encodedString.append(
        Self.characters.characterAtOffset(index)
      )
    } while index != nil

    if options.withChecksum {
      encodedString.append(
        Self.allChecksumSymbols.characterAtOffset(
          data.remainderBy(
            Self.allChecksumSymbols.count
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
      .joined(separator: groupingOptions.separator)
  }

  public func decode(
    base32Encoded string: String,
    options: Base32CrockfordDecodingOptions = .none
  ) throws -> Data {
    let standardized = standardize(string: string)
    return try decode(standardizedString: standardized, options: options)
  }

  public func standardize(string: String) -> String {
    string
      .uppercased()
      .replacingOccurrences(of: "O", with: "0")
      .replacingOccurrences(of: "I", with: "1")
      .replacingOccurrences(of: "L", with: "1")
      .replacingOccurrences(of: "-", with: "")
  }
}
