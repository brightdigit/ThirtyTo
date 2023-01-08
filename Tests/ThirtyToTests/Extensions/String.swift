extension String {
  func randomDashes() -> String {
    var result = self
    var index = endIndex
    repeat {
      guard let newIndex = self.index(index, offsetBy: .random(in: 3 ... 8) * -1, limitedBy: startIndex) else {
        return result
      }
      result.insert(Character("-"), at: newIndex)
      index = newIndex
    } while index > startIndex
    return result
  }
}
