import Foundation

extension UUID: ComposableIdentifier {
  public init(specifications _: Void) {
    self.init()
  }

  public typealias Specifications = Void

  public var data: Data {
    Data(Array(uuid: self))
  }
}
