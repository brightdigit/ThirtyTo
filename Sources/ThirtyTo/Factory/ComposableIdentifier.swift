import Foundation

/// An identifier type which can be composed.
public protocol ComposableIdentifier {
  /// Designated type which specifies how the identifier should be built.
  associatedtype Specifications

  /// Underlying Data of the object.
  var data: Data { get }

  /// Creates the identifier based on the specifications.
  /// - Parameters:
  ///   - specifications: Information which can be used to construct the identifier.
  init(specifications: Specifications)
}
