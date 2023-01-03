extension String {
  public func pad(toSize: Int) -> String {
    var padded = self
    for _ in 0 ..< (toSize - count) {
      padded = "0" + padded
    }
    return padded
  }

  public func split(by length: Int) -> [String] {
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
}
