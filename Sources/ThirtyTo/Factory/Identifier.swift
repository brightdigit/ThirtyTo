/// Contains the factory to create `ComposableIdentifier` objects.
public enum Identifier {
  private struct ComposableIdentifierFactory: IdentifierFactory {
    func createIdentifier<IdentifierType>(
      with specification: IdentifierType.Specifications
    ) -> IdentifierType where IdentifierType: ComposableIdentifier {
      IdentifierType(specifications: specification)
    }

    #if swift(>=5.7)
      func anyIdentifierWith(
        _ specifications: AnyIdentifierSpecifications
      ) -> any ComposableIdentifier {
        UDID(specifications: specifications)
      }
    #else
      func anyIdentifierWith(
        _ specifications: AnyIdentifierSpecifications
      ) -> AnyComposableIdentifier {
        _AnyComposableIdentifier(wrapped: UDID(specifications: specifications))
      }
    #endif
  }

  /// Object for creating different types of identiifiers.
  public static let factory: IdentifierFactory = ComposableIdentifierFactory()
}
