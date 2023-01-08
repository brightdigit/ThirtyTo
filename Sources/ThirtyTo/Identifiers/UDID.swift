import Foundation

/// _Universally Unique Dynamic Identifier_
/// which is a wrapper around a data object for
/// creating random bytes to be used as an identifier.
public struct UDID: ComposableIdentifier {
  /// Specifies the size and method of generating random bytes.
  public typealias Specifications = AnyIdentifierSpecifications

  /// The underlying data of the object.
  public let data: Data

  /// Creates UDID based on the size and method of generating random bytes.
  /// - Parameter specifications: The size and method of generating random bytes.
  public init(specifications: AnyIdentifierSpecifications) {
    var randomDataGenerator = specifications.randomData()
    data = Data.random(count: specifications.size.byteCount, using: &randomDataGenerator)
  }
}
