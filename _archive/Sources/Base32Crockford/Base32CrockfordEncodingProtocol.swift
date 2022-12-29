import Foundation

public protocol Base32CrockfordEncodingProtocol: Base32CrockfordGenerator {
  func encode(data: Data, options: Base32CrockfordEncodingOptions) -> String
  func decode(base32Encoded string: String, options: Base32CrockfordDecodingOptions) throws -> Data
  static var encoding: Base32CrockfordEncodingProtocol { get }
}

public extension Base32CrockfordEncodingProtocol {
  func encode(data: Data) -> String {
    encode(data: data, options: .none)
  }

  func decode(base32Encoded string: String) throws -> Data {
    try decode(base32Encoded: string, options: .none)
  }
}

public extension Base32CrockfordEncodingProtocol {
  func standardize(string: String) -> String {
    return string
      .uppercased()
      .replacingOccurrences(of: "O", with: "0")
      .replacingOccurrences(of: "I", with: "1")
      .replacingOccurrences(of: "L", with: "1")
  }
}
