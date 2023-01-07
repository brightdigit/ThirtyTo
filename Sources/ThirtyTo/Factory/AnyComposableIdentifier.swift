import Foundation

@available(swift, obsoleted: 5.7)
public struct AnyComposableIdentifier: ComposableIdentifier {
  public typealias Specifications = () -> Never

  public let data: Data

  internal init<IdentifierType: ComposableIdentifier>(
    wrapped: IdentifierType
  ) {
    data = wrapped.data
  }

  public init(specifications: () -> Never) {
    specifications()
  }
}
