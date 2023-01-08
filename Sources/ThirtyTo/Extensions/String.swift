extension String {
  internal func pad(toSize: Int) -> String {
    var padded = self
    for _ in 0 ..< (toSize - count) {
      padded = "0" + padded
    }
    return padded
  }

  internal func split(by length: Int) -> [String] {
    var endIndex = self.endIndex
    var results = [Substring]()

    while startIndex < endIndex {
      let startIndex = index(
        endIndex,
        offsetBy: -length,
        limitedBy: self.startIndex
      ) ?? self.startIndex
      results.append(self[startIndex ..< endIndex])
      endIndex = startIndex
    }

    return results.reversed().map { String($0) }
  }

  internal func characterAtOffset(
    _ offset: Int,
    fromIndex index: String.Index? = nil
  ) -> Character {
    let fromIndex = index ?? startIndex
    let characterIndex = self.index(fromIndex, offsetBy: offset)
    return self[characterIndex]
  }

  internal func firstOffsetOf(
    character: Character,
    fromIndex index: String.Index? = nil
  ) -> Int? {
    let fromIndex = index ?? startIndex
    guard let characterIndex = firstIndex(of: character) else {
      return nil
    }
    return distance(from: fromIndex, to: characterIndex)
  }

  internal func split(withChecksum: Bool) -> (String, Character?) {
    var valueString = self
    let checksum: Character?
    if withChecksum {
      checksum = valueString.popLast()
    } else {
      checksum = nil
    }
    return (valueString, checksum)
  }

  internal func offsets(
    basedOnCharacterMap characterMap: String,
    onInvalidCharacter throwsError: @escaping (Character, String) -> Error
  ) throws -> [Int] {
    try map { character -> Int in
      guard let lastIndex = characterMap.firstOffsetOf(character: character) else {
        throw throwsError(character, self)
      }
      return lastIndex
    }
  }
}
