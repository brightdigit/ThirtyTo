import Foundation

public struct Base32CrockfordEncoding: Base32CrockfordEncodingProtocol, Base32CrockfordComparer {
  fileprivate static let _encoding = Base32CrockfordEncoding()

  public static var encoding: Base32CrockfordEncodingProtocol {
    return _encoding
  }

  public static var comparer: Base32CrockfordComparer {
    return _encoding
  }

  fileprivate static let characters = "0123456789abcdefghjkmnpqrtuvwxyz".uppercased()
  fileprivate static let checkSymbols = "*~$=U"

  fileprivate struct ChecksumError: Error {}

  fileprivate func sizeOf(checksumFrom string: String) -> Int {
    let strBitCount = string.count * 5
    let dataBitCount = Int(floor(Double(strBitCount) / 8)) * 8
    return strBitCount - dataBitCount
  }

  fileprivate func decodeWithoutChecksum(base32Encoded string: String) -> Data {
    let standardized = standardize(string: string)
    let checksumSize = sizeOf(checksumFrom: standardized)

    return decode(standardizedString: standardized, withChecksumSize: checksumSize)
  }

  fileprivate func verifyChecksum(_ checksumSize: Int, _ standardized: String) throws {
    let lastValue: UInt8?
    if checksumSize != 0 {
      let lastIndex = Base32CrockfordEncoding.characters.firstIndex(of: standardized.last!)!
      lastValue = UInt8(Base32CrockfordEncoding.characters.distance(from: Base32CrockfordEncoding.characters.startIndex, to: lastIndex))
    } else {
      lastValue = nil
    }

    if let lastValue = lastValue {
      let checksumValue = (lastValue << (8 - checksumSize)) >> (8 - checksumSize)
      guard checksumValue == 0 else {
        throw ChecksumError()
      }
    }
  }

  fileprivate func decode(standardizedString standardized: String, withChecksumSize checksumSize: Int) -> Data {
    let values = standardized.map { character -> String.IndexDistance in
      let lastIndex = Base32CrockfordEncoding.characters.firstIndex(of: character)!
      return Base32CrockfordEncoding.characters.distance(from: Base32CrockfordEncoding.characters.startIndex, to: lastIndex)
    }

    let bitString = values.map { String($0, radix: 2).pad(toSize: 5) }.joined(separator: "")

    let bitStringWithoutChecksum = String(bitString[bitString.startIndex ... bitString.index(bitString.endIndex, offsetBy: -checksumSize - 1)])
    let dataBytes = bitStringWithoutChecksum.split(by: 8).compactMap { UInt8($0, radix: 2) }
    return Data(dataBytes)
  }

  public func encode(data: Data) -> String {
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
        Base32CrockfordEncoding.characters[characterIndex])

    } while index != nil

    if lastSegment > 0 {
      let lastIndex = (binary.next(bits: lastSegment)! << difference)
      let characterIndex = Base32CrockfordEncoding.characters.index(Base32CrockfordEncoding.characters.startIndex, offsetBy: lastIndex)
      encodedString.append(Base32CrockfordEncoding.characters[characterIndex])
    }
    return encodedString
  }

  public func decode(base32Encoded string: String) throws -> Data {
    let standardized = standardize(string: string)
    let checksumSize = sizeOf(checksumFrom: standardized)
    try verifyChecksum(checksumSize, standardized)

    return decode(standardizedString: standardized, withChecksumSize: checksumSize)
  }

  public func data(_ data: Data, hasEncodedPrefix prefix: String) -> Bool {
    let prefixData = decodeWithoutChecksum(base32Encoded: prefix)
    return zip(data, prefixData).allSatisfy { $0 == $1 }
  }
}
