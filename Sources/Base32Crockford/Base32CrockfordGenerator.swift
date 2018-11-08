//
//  Base32CrockfordEncodingProtocol.Base32CrockfordGenerator.swift
//  Base32Crockford
//
//  Created by Leo Dion on 11/8/18.
//

import Foundation

public protocol Base32CrockfordGenerator {
  func generateIdentifier(from identifierDataType: IdentifierDataType) -> String
}

extension Base32CrockfordEncodingProtocol {
  private func generateFromUUID () -> String {
    let uuid = UUID()
    let bytes = ByteCollection(uuid: uuid)
    let data = Data(bytes: bytes)
    return self.encode(data: data)
  }
  
  private func generateSingle() -> String {
    return self.generate(withByteSize: 5)
  }
  
  private func generate(withByteSize size: Int) -> String {
    let data = Data.random(withNumberOfBytes: size)
    return self.encode(data: data)
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
    return self.encode(data: data)
  }
  
  public func generateIdentifier(from identifierDataType: IdentifierDataType) -> String {
    return self.generateIdentifier(from: identifierDataType)!
  }
  
  private func generateIdentifier(from identifierDataType: IdentifierDataType, fatalError: ((String?) -> Void)? = nil) -> String? {
    switch identifierDataType {
      
    case .default:
      return self.generateSingle()
    case .uuid:
      return self.generateFromUUID()
    case .bytes(let size):
      return self.generate(withByteSize: size)
    case .minimumCount(let count):
      return self.generate(forMinimumUniqueCount: count, fatalError: fatalError)
    }
  }
  
  private func generate(_ count: Int, from identifierDataType: IdentifierDataType, fatalError: ((String?) -> Void)? = nil) -> [String]?  {
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
    return (1...count).map{
      _ in
      self.generateIdentifier(from: identifierDataType)
    }
  }
  
  public func generate(_ count: Int, from identifierDataType: IdentifierDataType) -> [String] {
    return self.generate(count, from: identifierDataType, fatalError: nil)!
  }
  
  #if DEBUG
  public func debugGenerate(_ count: Int, from identifierDataType: IdentifierDataType, fatalError: ((String?) -> Void)? = nil) -> [String]? {
    return self.generate(count, from: identifierDataType, fatalError: fatalError)
  }
  
  public func debugGenerateIdentifier(from identifierDataType: IdentifierDataType, fatalError: ((String?) -> Void)? = nil) -> String? {
    return self.generateIdentifier(from: identifierDataType, fatalError: fatalError)
  }
  #endif
  
}
