import Foundation

public struct NumberedDataGenerator<
  NumberGeneratorType: RandomNumberGenerator
>: RandomDataGenerator {
  private var generator: NumberGeneratorType

  public init(generator: NumberGeneratorType) {
    self.generator = generator
  }

  public mutating func generate(withCount count: Int) -> Data {
    var data = Data(capacity: count)
    while data.count < count {
      data.append(generator.next())
    }
    return data
  }
}
