extension String {
  public func pad(toSize: Int) -> String {
    var padded = self
    for _ in 0 ..< (toSize - count) {
      padded = "0" + padded
    }
    return padded
  }

  func split(by length: Int) -> [String] {
    var startIndex = self.startIndex
    var results = [Substring]()

    while startIndex < endIndex {
      let endIndex = index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
      results.append(self[startIndex ..< endIndex])
      startIndex = endIndex
    }

    return results.map { String($0) }
  }
}


