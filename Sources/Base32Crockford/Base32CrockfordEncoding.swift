import Foundation

public struct Base32CrockfordEncoding {
  public static let encoding = Base32CrockfordEncoding()

  private static let characters = "0123456789abcdefghjkmnpqrstvwxyz".uppercased()

  // periphery:ignore
  private static let checkSymbols = "*~$=U"

  private func decode(
    standardizedString standardized: String
  ) -> Data {
    let values = standardized.map { character -> Int in
      guard let lastIndex = Base32CrockfordEncoding.characters.firstIndex(
        of: character
      ) else {
        preconditionFailure("Invalid Characters should never be passed.")
      }
      return Base32CrockfordEncoding.characters.distance(
        from: Base32CrockfordEncoding.characters.startIndex,
        to: lastIndex
      )
    }

    let bitString = values.map { String($0, radix: 2).pad(toSize: 5) }.joined()
    let dataBytes = bitString.split(by: 8).compactMap {
      UInt8($0, radix: 2)
    }
    let expectedByteCount = ((bitString.count - 1) / 8) + 1

    // swiftlint:disable:next line_length
    precondition(expectedByteCount == dataBytes.count, "Expected \(expectedByteCount) bytes from \(bitString.count) bits but received \(dataBytes.count)")

    return Data(dataBytes)
  }

  public func encode(
    data: Data,
    options _: Base32CrockfordEncodingOptions = .none
  ) -> String {
    var encodedString = ""
    var index: Int?

    var binary = Binary(data: data, sectionSize: 5)
    repeat {
      index = binary.nextSection()
      guard let index = index else {
        break
      }
      let characterIndex = Base32CrockfordEncoding.characters.index(
        Base32CrockfordEncoding.characters.startIndex, offsetBy: index
      )
      encodedString.append(
        Base32CrockfordEncoding.characters[characterIndex]
      )
    } while index != nil
    return encodedString
      .replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
  }

  public func decode(
    base32Encoded string: String,
    options _: Base32CrockfordDecodingOptions = .none
  ) throws -> Data {
    let standardized = standardize(string: string)
    return decode(standardizedString: standardized)
  }

  public func standardize(string: String) -> String {
    string
      .uppercased()
      .replacingOccurrences(of: "O", with: "0")
      .replacingOccurrences(of: "I", with: "1")
      .replacingOccurrences(of: "L", with: "1")
  }
}
