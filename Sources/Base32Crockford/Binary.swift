import Foundation

public struct Binary {
  public let sectionSize: Int
  public let bytes: [UInt8]
  public var readingOffset: Int = 0
  public let byteSize: Int

  public init(data: Data, sectionSize: Int, byteSize: Int = 8) {
    self.byteSize = byteSize
    let bytesLength = data.count
    var bytesArray = [UInt8](repeating: 0, count: bytesLength)
    (data as NSData).getBytes(&bytesArray, length: bytesLength)
    bytes = bytesArray
    self.sectionSize = sectionSize
    readingOffset = (data.count * byteSize) % sectionSize - sectionSize
  }

  public func bit(_ position: Int) -> Int {
    guard position >= 0 else {
      return 0
    }
    let bytePosition = position / byteSize
    let bitPosition = (byteSize - 1) - (position % byteSize)
    let byte = self.byte(bytePosition)
    return (byte >> bitPosition) & 0x01
  }

  public func bits(_ range: Range<Int>) -> Int {
    var positions = [Int]()

    for position in range.lowerBound ..< range.upperBound {
      positions.append(position)
    }

    return positions.reversed().enumerated().reduce(0) {
      $0 + (bit($1.element) << $1.offset)
    }
  }

  public func bits(_ start: Int, _ length: Int) -> Int {
    bits(start ..< (start + length))
  }

  public func byte(_ position: Int) -> Int {
    Int(bytes[position])
  }

  public func bitsWithInternalOffsetAvailable(_ length: Int) -> Bool {
    (bytes.count * byteSize) >= (readingOffset + length)
  }

  public mutating func nextSection() -> Int? {
    if bitsWithInternalOffsetAvailable(sectionSize) {
      let returnValue = bits(readingOffset, sectionSize)
      readingOffset += sectionSize
      return returnValue
    } else {
      return nil
    }
  }

  public mutating func string(basedOnCharacterMap characterMap: String) -> String {
    var encodedString = ""
    var index: Int?

    repeat {
      index = nextSection()
      guard let index = index else {
        break
      }
      encodedString.append(
        characterMap.characterAtOffset(index)
      )
    } while index != nil

    return encodedString
  }
}
