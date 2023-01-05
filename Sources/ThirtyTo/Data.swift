import Foundation


public protocol RandomDataGenerator {
  mutating func generate(withCount count: Int) -> Data
}

public struct SecRandomDataGenerator : RandomDataGenerator {
  private init () {
    
  }
  
  public static let shared = SecRandomDataGenerator()
  public func generate(withCount count: Int) -> Data {
    var bytes = [Int8](repeating: 0, count: count)

        // Fill bytes with secure random data
        let status = SecRandomCopyBytes(
            kSecRandomDefault,
            count,
            &bytes
        )
        
    assert(status == errSecSuccess)
            // Convert bytes to Data
            return Data(bytes: bytes, count: count)
  }
}

public struct NumberedDataGenerator<RandomNumberGeneratorType : RandomNumberGenerator> : RandomDataGenerator {
  public init(generator: RandomNumberGeneratorType) {
    self.generator = generator
  }
  
  var generator : RandomNumberGeneratorType
  public mutating func generate(withCount count: Int) -> Data {
    
    var data = Data(capacity: count)
    while data.count < count {
      data.append(generator.next())
    }
    return data
  }
}
extension Data {
  static let byteRange = ((UInt8.min)...(UInt8.max))
  
  
  @inlinable public static func random(count: Int, using generator: inout RandomDataGenerator) -> Data {
    return generator.generate(withCount: count)
   
  }
  
  @inlinable public static func random<T>(count: Int, using numberGenerator: inout T) -> Data where T : RandomNumberGenerator {
    var dataGenerator : RandomDataGenerator = NumberedDataGenerator(generator: numberGenerator)
    return Self.random(count: count, using: &dataGenerator)
    
   
  }
  
  @inlinable public static func random(count: Int) -> Data {
    return SecRandomDataGenerator.shared.generate(withCount: count)
   
  }
  
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

  internal func trim(to count: Int, andPadWith fill: UInt8 = 0) -> Data {
    let fillSize = Swift.max(count - self.count, 0)
    let fillData = Data(repeating: fill, count: fillSize)
    let bytes = (fillData + self).suffix(count)
    return Data(bytes)
  }
}
