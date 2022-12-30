import Foundation

public enum IdentifierDataType: Equatable {
  case `default`
  case uuid
  case bytes(size: Int)
  case minimumCount(Int)

  enum CodingKeys: String, CodingKey {
    case bytes
    case minimumCount
    case type
  }
}

struct InvalidIdentifierDataTypeError: Error {}

extension IdentifierDataType: Codable {
  public init(from decoder: Decoder) throws {
    guard let container = try? decoder.container(keyedBy: CodingKeys.self) else {
      throw InvalidIdentifierDataTypeError()
    }

    if container.allKeys.contains(.bytes) {
      guard let byteSize = try? container.decode(Int.self, forKey: .bytes) else {
        throw InvalidIdentifierDataTypeError()
      }
      self = .bytes(size: byteSize)
      return
    } else if container.allKeys.contains(.minimumCount) {
      guard let minimumCount = try? container.decode(Int.self, forKey: .minimumCount) else {
        throw InvalidIdentifierDataTypeError()
      }
      self = .minimumCount(minimumCount)
      return
    } else if container.allKeys.contains(.type) {
      if (try? container.decode(String.self, forKey: .type)) == "uuid" {
        self = .uuid
        return
      } else if (try? container.decodeNil(forKey: .type)) == true {
        self = .default
        return
      }
    }
    throw InvalidIdentifierDataTypeError()
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    switch self {
    case .uuid:
      try container.encode("uuid", forKey: .type)

    case let .bytes(size):
      try container.encode(size, forKey: .bytes)

    case let .minimumCount(count):
      try container.encode(count, forKey: .minimumCount)

    default:
      try container.encodeNil(forKey: .type)
    }
  }
}
