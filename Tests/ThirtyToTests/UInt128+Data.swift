import XCTest

extension UInt128 {
  var data: Data {
    var upperBits = byteSwapped.value.upperBits
    var lowerBits = byteSwapped.value.lowerBits
    return Data(bytes: &lowerBits, count: MemoryLayout<UInt64>.size) +
      Data(bytes: &upperBits, count: MemoryLayout<UInt64>.size)
  }
}
