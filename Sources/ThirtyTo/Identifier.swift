import Foundation

public protocol Identifier {
  associatedtype Specifications
  var data: Data { get }
}

extension UUID: Identifier {
  public typealias Specifications = Void

  public var data: Data {
    Data(Array(uuid: self))
  }
}

public struct USID: Identifier {
  public let data: Data

  public struct Specifications {
    let count: Int
  }
}

public struct ULID: Identifier {
  public let data: Data
  public typealias Specifications = Void
}

public struct UDID: Identifier {
  public let data: Data
  public typealias Specifications = AnyIdentifierSpecifications
}

public enum AnyIdentifierSpecifications {
  case bytes(Int)
  case minimumCount(Int)
}

public protocol IdentifierFactory {
  func indentifierOf<IdentifierType: Identifier>(_ type: IdentifierType.Type) -> IdentifierType
  func anyIdentifierWith(_ specifications: AnyIdentifierSpecifications) -> any Identifier
}
