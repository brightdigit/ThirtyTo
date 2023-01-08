import Foundation

/// Type erased identifier object.
@available(swift, obsoleted: 5.7)
// swiftlint:disable:next type_name
public struct _AnyComposableIdentifier: ComposableIdentifier {
  public typealias Specifications = () -> Never

  public let data: Data

  // periphery:ignore
  internal init<IdentifierType: ComposableIdentifier>(
    wrapped: IdentifierType
  ) {
    data = wrapped.data
  }

  public init(specifications: () -> Never) {
    specifications()
  }
}

#if swift(<5.7)
  /// Deprecated type erased identifier object.
  public typealias AnyComposableIdentifier = _AnyComposableIdentifier
#endif
