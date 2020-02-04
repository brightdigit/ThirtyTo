import Foundation

public protocol Base32CrockfordGenerator {
  func generateIdentifier(from identifierDataType: IdentifierDataType) -> String
}

extension Base32CrockfordEncodingProtocol {
  private func generateFromUUID() -> String {
    let uuid = UUID()
    let bytes = ByteCollection(uuid: uuid)
    let data = Data(bytes: bytes)
    return encode(data: data)
  }

  private func generateSingle() -> String {
    return generate(withByteSize: 5)
  }

  private func generate(withByteSize size: Int) -> String {
    let data = Data.random(withNumberOfBytes: size)
    return encode(data: data)
  }

  private func generate(forMinimumUniqueCount count: Int, fatalError: ((String?) -> Void)? = nil) -> String? {
    guard count > 0 else {
      if count == 0 {
        return ""
      } else {
        if let fatalError = fatalError {
          fatalError("Cannot construct String identifier for unique count less than 0.")
          return nil
        } else {
          Swift.fatalError("Cannot construct String identifier for unique count less than 0.")
        }
      }
    }

    let data = Data.uniqueIdentifier(forMinimumCount: count)
    return encode(data: data)
  }

  public func generateIdentifier(from identifierDataType: IdentifierDataType) -> String {
    return generateIdentifier(from: identifierDataType)!
  }

  private func generateIdentifier(from identifierDataType: IdentifierDataType, fatalError: ((String?) -> Void)? = nil) -> String? {
    switch identifierDataType {
    case .default:
      return generateSingle()
    case .uuid:
      return generateFromUUID()
    case let .bytes(size):
      return generate(withByteSize: size)
    case let .minimumCount(count):
      return generate(forMinimumUniqueCount: count, fatalError: fatalError)
    }
  }

  private func generate(_ count: Int, from identifierDataType: IdentifierDataType, fatalError: ((String?) -> Void)? = nil) -> [String]? {
    guard count >= 0 else {
      if let fatalError = fatalError {
        fatalError("Array count cannot be less than 0.")
        return nil
      } else {
        Swift.fatalError("Array count cannot be less than 0.")
      }
    }
    guard count > 0 else {
      return [String]()
    }
    return (1 ... count).map { _ in
      self.generateIdentifier(from: identifierDataType)
    }
  }

  public func generate(_ count: Int, from identifierDataType: IdentifierDataType) -> [String] {
    return generate(count, from: identifierDataType, fatalError: nil)!
  }

  #if DEBUG
    internal func debugGenerate(_ count: Int, from identifierDataType: IdentifierDataType, fatalError: ((String?) -> Void)? = nil) -> [String]? {
      return generate(count, from: identifierDataType, fatalError: fatalError)
    }

    internal func debugGenerateIdentifier(from identifierDataType: IdentifierDataType, fatalError: ((String?) -> Void)? = nil) -> String? {
      return generateIdentifier(from: identifierDataType, fatalError: fatalError)
    }
  #endif
}
