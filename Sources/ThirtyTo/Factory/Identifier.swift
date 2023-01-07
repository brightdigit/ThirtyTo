public enum Identifier {
  public static let factory: IdentifierFactory = ComposableIdentifierFactory()

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
        .init(wrapped: UDID(specifications: specifications))
      }
    #endif
  }
}
