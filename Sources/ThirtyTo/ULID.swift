import Foundation

public struct ULID: ComposableIdentifier {
  public init(specifications _: Specifications) {
    data = Data()
  }

  public let data: Data

  public enum Specifications {
    case data(Data)
    case parts(Date?, RandomPartSpecifications)

    public static let `default`: Specifications = .parts(nil, .random(nil))
  }

  public enum RandomPartSpecifications {
    case random(RandomDataGenerator?)
    case specific(Data)
  }
}
