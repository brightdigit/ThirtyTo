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
}
