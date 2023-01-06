import Foundation

public struct NumberedDataGenerator<RandomNumberGeneratorType: RandomNumberGenerator>: RandomDataGenerator {
  public init(generator: RandomNumberGeneratorType) {
    self.generator = generator
  }

  var generator: RandomNumberGeneratorType
  public mutating func generate(withCount count: Int) -> Data {
    var data = Data(capacity: count)
    while data.count < count {
      data.append(generator.next())
    }
    return data
  }
}
