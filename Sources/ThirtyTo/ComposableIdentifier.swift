import Foundation

public protocol ComposableIdentifier {
  associatedtype Specifications
  var data: Data { get }
  init(specifications: Specifications)
}
