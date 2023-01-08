import Foundation
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

  /// Creates the default `RandomDataGenerator` based on the operating system.
  /// - Returns: For Apple OSes, this uses `SecRandomCopyBytes`
  ///    otherwise it uses `SystemRandomNumberGenerator`.
  public static let defaultRandomGenerator = Data.defaultRandomGenerator
}
