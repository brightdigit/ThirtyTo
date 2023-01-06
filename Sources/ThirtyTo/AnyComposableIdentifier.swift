import Foundation

public struct AnyComposableIdentifier: ComposableIdentifier {
  internal init<ComposableIdentifierType: ComposableIdentifier>(wrapped: ComposableIdentifierType) {
    data = wrapped.data
  }

  public let data: Data

  public init(specifications: () -> Never) {
    specifications()
  }

  public typealias Specifications = () -> Never
}
