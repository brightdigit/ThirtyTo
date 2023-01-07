import Foundation

extension UUID: ComposableIdentifier {
  public typealias Specifications = Void

  public var data: Data {
    Data(Array(uuid: self))
  }

  public init(specifications _: Void) {
    self.init()
  }
}
