public protocol IdentifierFactory {
  func createIdentifier<IdentifierType: ComposableIdentifier>(
    with specification: IdentifierType.Specifications
  ) -> IdentifierType
  #if swift(>=5.7)
    func anyIdentifierWith(
      _ specifications: AnyIdentifierSpecifications
    ) -> any ComposableIdentifier
  #else
    func anyIdentifierWith(
      _ specifications: AnyIdentifierSpecifications
    ) -> AnyComposableIdentifier
  #endif
}

extension IdentifierFactory {
  #if swift(>=5.7)
    public func anyIdentifier(
      withSize size: SizeSpecification
    ) -> any ComposableIdentifier {
      anyIdentifierWith(.init(size: size))
    }
  #else
    public func anyIdentifier(
      withSize size: SizeSpecification
    ) -> AnyComposableIdentifier {
      anyIdentifierWith(.init(size: size))
    }
  #endif

  public func createIdentifier<
    IdentifierType: ComposableIdentifier
  >(_: IdentifierType.Type) -> IdentifierType
    where IdentifierType.Specifications == Void {
    createIdentifier(with: ())
  }
}
