@testable import ThirtyTo
import XCTest

extension Data {
  struct HexEncodingOptions: OptionSet {
    let rawValue: Int
    static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
  }

  func hexEncodedString(options: HexEncodingOptions = []) -> String {
    let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
    return map { String(format: format, $0) }.joined()
  }

  func trim(to count: Int, andPadWith fill: UInt8 = 0) -> Data {
    let fillSize = Swift.max(count - self.count, 0)
    let fillData = Data(repeating: fill, count: fillSize)
    let bytes = (fillData + self).suffix(count)
    return Data(bytes)
  }
}
