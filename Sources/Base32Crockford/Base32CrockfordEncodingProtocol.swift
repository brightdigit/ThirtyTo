import Foundation

public protocol Base32CrockfordEncodingProtocol: Base32CrockfordGenerator {
  func encode(data: Data) -> String
  func decode(base32Encoded string: String) throws -> Data
  static var encoding: Base32CrockfordEncodingProtocol { get }
}
