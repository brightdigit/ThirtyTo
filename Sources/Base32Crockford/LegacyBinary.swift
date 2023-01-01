import Foundation

@available(*, deprecated)
public struct LegacyBinary {
  public let bytes: [UInt8]
  public var readingOffset: Int = 0
  public let byteSize: Int

  public init(data: Data, byteSize: Int = 8) {
    self.byteSize = byteSize
    let bytesLength = data.count
    var bytesArray = [UInt8](repeating: 0, count: bytesLength)
    (data as NSData).getBytes(&bytesArray, length: bytesLength)
    bytes = bytesArray
  }

  public func bit(_ position: Int) -> Int {
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

  public mutating func nextSection(bits length: Int) -> Int? {
    if bitsWithInternalOffsetAvailable(length) {
      let returnValue = bits(readingOffset, length)
      readingOffset += length
      return returnValue
    } else {
      return nil
    }
  }
}
