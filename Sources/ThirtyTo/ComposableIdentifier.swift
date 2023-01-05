import Foundation

public enum Identifer {
  public static let factory : IdentifierFactory = ComposableIdentifierFactory()
  
  struct ComposableIdentifierFactory : IdentifierFactory {
    func createIdentifier<IdentifierType>(with specification: IdentifierType.Specifications) -> IdentifierType where IdentifierType : ComposableIdentifier {
      return IdentifierType(specifications: specification)
    }
    
    func anyIdentifierWith(_ specifications: AnyIdentifierSpecifications) -> any ComposableIdentifier {
      return UDID(specifications: specifications)
    }
  }
}


public protocol ComposableIdentifier {
  associatedtype Specifications
  var data: Data { get }
  init(specifications: Specifications)
}

extension UUID: ComposableIdentifier {
  public init(specifications: Void) {
    self.init()
  }
  
  public typealias Specifications = Void

  public var data: Data {
    Data(Array(uuid: self))
  }
}

public struct ULID: ComposableIdentifier {
  public init(specifications: Void) {
    self.data = Data()
  }
  
  public let data: Data
  public typealias Specifications = Void
}

public struct UDID: ComposableIdentifier {
  public init(specifications: AnyIdentifierSpecifications) {
    self.data = Data(repeating: 0, count: specifications.byteCount)
  }
  
  public let data: Data
  public typealias Specifications = AnyIdentifierSpecifications
}

public enum AnyIdentifierSpecifications {
  case bytes(Int)
  case minimumCount(Int, factorOf: Int?)
  
  public static func base32Optimized(forUniqueCountOf count: Int) -> AnyIdentifierSpecifications {
    return .minimumCount(count, factorOf: 5)
  }
}

extension AnyIdentifierSpecifications {
  public static func bytesRequired(forUniqueCountOf count: Int, factorOf factor: Int?) -> Int {
    var floatingCount = log(Double(count)) / log(256.0)
    
    if let factor = factor.map(Double.init) {
      let remainder = floatingCount.remainder(dividingBy: factor)
      floatingCount += (factor - remainder)
    }
    
    return Int(ceil(floatingCount))
  }
  
  var byteCount : Int {
    switch self {
    case .bytes(let byteCount): return byteCount
    case .minimumCount(let uniqueCount, factorOf: let factor): return Self.bytesRequired(forUniqueCountOf: uniqueCount, factorOf: factor)
    }
  }
}

public protocol IdentifierFactory {
  func createIdentifier<IdentifierType: ComposableIdentifier>(with specification: IdentifierType.Specifications) -> IdentifierType
  func anyIdentifierWith(_ specifications: AnyIdentifierSpecifications) -> any ComposableIdentifier
}
