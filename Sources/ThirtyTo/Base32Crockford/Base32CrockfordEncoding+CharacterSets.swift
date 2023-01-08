import Foundation

extension Base32CrockfordEncoding {
  /// Character Sets used by `Base32CrockfordEncoding`
  public enum CharacterSets {
    /// Characters used by Base32Crockford.
    public static let symbols = "0123456789ABCDEFGHJKMNPQRSTVWXYZ"
    private static let additionalCheckSymbols = "*~$=U"

    /// All characters available as a checksum character by Base32Crockford.
    public static let checkSymbols = symbols + additionalCheckSymbols
  }
}
