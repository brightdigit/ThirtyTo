/// Factory object for creating identifiers.
public protocol IdentifierFactory {
  /// Creates an identifier of a speciifc type based on the specifications.
  /// - Parameter specification: The specifications for the identifier.
  /// - Returns: A new identifier.
  func createIdentifier<IdentifierType: ComposableIdentifier>(
    with specification: IdentifierType.Specifications
  ) -> IdentifierType

  #if swift(>=5.7)
    /// Creates an identifier of a speciifc type based on the specifications.
    /// - Parameter specification: The specifications for the identifier.
    /// - Returns: A new identifier.
    func anyIdentifierWith(
      _ specifications: AnyIdentifierSpecifications
    ) -> any ComposableIdentifier
  #else
    /// Creates an identifier of a speciifc type based on the specifications.
    /// - Parameter specification: The specifications for the identifier.
    /// - Returns: A new identifier.
    func anyIdentifierWith(
      _ specifications: AnyIdentifierSpecifications
    ) -> AnyComposableIdentifier
  #endif
}

extension IdentifierFactory {
  #if swift(>=5.7)
    /// Creates an identifier of a speciifc type based on the specifications.
    /// - Parameter size: The specifications for the size of the identifier.
    /// - Returns: A new identifier.
    public func anyIdentifier(
      withSize size: SizeSpecification
    ) -> any ComposableIdentifier {
      anyIdentifierWith(.init(size: size))
    }
  #else
    /// Creates an identifier of a speciifc type based on the specifications.
    /// - Parameter size: The specifications for the size of the identifier.
    /// - Returns: A new identifier.
    public func anyIdentifier(
      withSize size: SizeSpecification
    ) -> AnyComposableIdentifier {
      anyIdentifierWith(.init(size: size))
    }
  #endif

  /// Creates and identifier of a specific type.
  /// - Returns: A new identifier.
  public func createIdentifier<
    IdentifierType: ComposableIdentifier
  >(_: IdentifierType.Type) -> IdentifierType
    where IdentifierType.Specifications == Void {
    createIdentifier(with: ())
  }
}
