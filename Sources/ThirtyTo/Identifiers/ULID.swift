import Foundation

public struct ULID: ComposableIdentifier {
  public enum RandomPartSpecifications {
    case random(RandomDataGenerator?)
    case specific(Data)
  }

  public enum Specifications {
    case data(Data)
    case parts(Date?, RandomPartSpecifications)

    public static let `default`: Specifications = .parts(nil, .random(nil))
  }

  public let data: Data

  public var randomPart: Data {
    data.suffix(10)
  }

  public var timestamp: Date {
    Date(timestampData: data.prefix(6))
  }

  public init(specifications: Specifications) {
    switch specifications {
    case let .data(data):
      assert(data.count == 16)
      self.data = data
    case let .parts(date, randomSpec):
      let date = date ?? Date()
      let randomPart: Data
      switch randomSpec {
      case let .random(generator):
        var generator = generator ?? Data.defaultRandomGenerator()
        randomPart = generator.generate(withCount: 10)

      case let .specific(data):
        assert(data.count == 10)
        randomPart = data
      }
      let fillerCount = max(10 - randomPart.count, 0)
      let timestampData = date.data(withMaximumByteCount: 6)
      let fillerData = Data(count: fillerCount)
      let randomPartData = randomPart.prefix(10)
      data = timestampData + fillerData + randomPartData
      assert(data.count == 16)
    }
  }
}
