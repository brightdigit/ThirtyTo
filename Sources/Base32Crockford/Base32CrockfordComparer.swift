import Foundation

public protocol Base32CrockfordComparer {
  func data(_ data: Data, hasEncodedPrefix prefix: String) -> Bool
}
