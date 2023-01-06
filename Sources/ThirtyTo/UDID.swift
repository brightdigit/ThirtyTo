import Foundation

public struct UDID: ComposableIdentifier {
  public init(specifications: AnyIdentifierSpecifications) {
    var randomDataGenerator = specifications.randomData()
    data = Data.random(count: specifications.size.byteCount, using: &randomDataGenerator)
  }

  public let data: Data
  public typealias Specifications = AnyIdentifierSpecifications
}
