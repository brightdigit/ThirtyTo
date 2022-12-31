import Foundation

public protocol Base32CrockfordEncodingProtocol: Base32CrockfordGenerator {
  static var encoding: Base32CrockfordEncodingProtocol { get }

  func encode(data: Data, options: Base32CrockfordEncodingOptions) -> String
  func decode(
    base32Encoded string: String,
    options: Base32CrockfordDecodingOptions
  ) throws -> Data
}

extension Base32CrockfordEncodingProtocol {
  public func encode(data: Data) -> String {
    encode(data: data, options: .none)
  }

  public func decode(base32Encoded string: String) throws -> Data {
    try decode(base32Encoded: string, options: .none)
  }
}

extension Base32CrockfordEncodingProtocol {
  public func standardize(string: String) -> String {
    string
      .uppercased()
      .replacingOccurrences(of: "O", with: "0")
      .replacingOccurrences(of: "I", with: "1")
      .replacingOccurrences(of: "L", with: "1")
  }
}
