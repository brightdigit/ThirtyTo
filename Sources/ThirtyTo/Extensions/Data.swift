import Foundation

extension Data {
  internal func remainderBy(_ divisor: Int) -> Int {
    var remainder = 0
    var number = self
    for (index, value) in number.enumerated() {
      let temp = remainder * 256 + Int(value)
      number[index] = UInt8(temp / divisor)
      remainder = temp % divisor
    }
    return remainder
  }

//  internal func trim(to count: Int, andPadWith fill: UInt8 = 0) -> Data {
//    let fillSize = Swift.max(count - self.count, 0)
//    let fillData = Data(repeating: fill, count: fillSize)
//    let bytes = (fillData + self).suffix(count)
//    return Data(bytes)
//  }
}
