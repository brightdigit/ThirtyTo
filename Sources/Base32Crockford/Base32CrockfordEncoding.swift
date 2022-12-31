import Foundation

public struct Base32CrockfordEncodingOptions: OptionSet {
  public static let withChecksum = Base32CrockfordEncodingOptions(rawValue: 1 << 0)
  public static let none: Base32CrockfordEncodingOptions = []

  public let rawValue: Int

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
}

public typealias Base32CrockfordDecodingOptions = Base32CrockfordEncodingOptions

// swiftlint:disable:next line_length
public struct Base32CrockfordEncoding: Base32CrockfordEncodingProtocol, Base32CrockfordComparer {
  private struct ChecksumError: Error {}

  private static let _encoding = Base32CrockfordEncoding()

  public static var encoding: Base32CrockfordEncodingProtocol {
    _encoding
  }

  public static var comparer: Base32CrockfordComparer {
    _encoding
  }

  private static let characters = "0123456789abcdefghjkmnpqrtuvwxyz".uppercased()
  private static let checkSymbols = "*~$=U"

  private func sizeOf(extensionFrom string: String) -> Int {
    let strBitCount = string.count * 5
    let dataBitCount = Int(floor(Double(strBitCount) / 8)) * 8
    return strBitCount - dataBitCount
  }

  private func decodeWithoutExtension(base32Encoded string: String) -> Data {
    let standardized = standardize(string: string)
    let extensionSize = sizeOf(extensionFrom: standardized)

    return decode(standardizedString: standardized, withExtensionSize: extensionSize)
  }

  private func verifyExtension(_ size: Int, _ standardized: String) throws {
    let lastValue: UInt8?
    if let last = standardized.last, size != 0 {
      if let lastIndex = Base32CrockfordEncoding.characters.firstIndex(
        of: last
      ) {
        lastValue = UInt8(
          Base32CrockfordEncoding.characters.distance(
            from: Base32CrockfordEncoding.characters.startIndex,
            to: lastIndex
          )
        )
      } else {
        lastValue = nil
      }
    } else {
      lastValue = nil
    }

    if let lastValue = lastValue {
      let extensionValue = (lastValue << (8 - size)) >> (8 - size)
      guard extensionValue == 0 else {
        throw ChecksumError()
      }
    }
  }

  private func decode(
    standardizedString standardized: String,
    withExtensionSize checksumSize: Int
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

    let bitStringWithoutChecksum = String(
      bitString[
        bitString.startIndex ...
          bitString.index(bitString.endIndex, offsetBy: -checksumSize - 1)
      ]
    )
    let dataBytes = bitStringWithoutChecksum.split(by: 8).compactMap {
      UInt8($0, radix: 2)
    }
    return Data(dataBytes)
  }

  public func encode(data: Data, options _: Base32CrockfordEncodingOptions) -> String {
    let dataBitCount = data.count * 8
    let resBitCount = Int(ceil(Double(dataBitCount) / 5) * 5.0)
    let difference = resBitCount - dataBitCount
    let lastSegment = difference == 0 ? 0 : 5 - difference
    var binary = Binary(data: data)
    var encodedString = ""
    var index: Int?

    repeat {
      index = binary.next(bits: 5)
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

    if lastSegment > 0 {
      let lastIndex = (binary.next(bits: lastSegment)! << difference)
      let characterIndex = Base32CrockfordEncoding
        .characters
        .index(
          Base32CrockfordEncoding.characters.startIndex,
          offsetBy: lastIndex
        )
      encodedString.append(Base32CrockfordEncoding.characters[characterIndex])
    }
    return encodedString
  }

  public func decode(
    base32Encoded string: String,
    options _: Base32CrockfordDecodingOptions
  ) throws -> Data {
    let standardized = standardize(string: string)
    let extensionSize = sizeOf(extensionFrom: standardized)
    try verifyExtension(extensionSize, standardized)

    return decode(standardizedString: standardized, withExtensionSize: extensionSize)
  }

  public func data(_ data: Data, hasEncodedPrefix prefix: String) -> Bool {
    let prefixData = decodeWithoutExtension(base32Encoded: prefix)
    return zip(data, prefixData).allSatisfy { $0 == $1 }
  }
}
