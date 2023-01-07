import Foundation

public struct UDID: ComposableIdentifier {
  public typealias Specifications = AnyIdentifierSpecifications

  public let data: Data

  public init(specifications: AnyIdentifierSpecifications) {
    var randomDataGenerator = specifications.randomData()
    data = Data.random(count: specifications.size.byteCount, using: &randomDataGenerator)
  }
}
