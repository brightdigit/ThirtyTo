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

  public init(specifications _: Specifications) {
    data = Data()
  }
}
