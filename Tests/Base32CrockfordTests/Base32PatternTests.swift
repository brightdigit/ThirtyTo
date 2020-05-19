@testable import Base32Crockford
import XCTest

final class Base32EqualityTests: XCTestCase {
  func testExample() {
    let values = ["0": "O", "1": "I", "I": "L"]
    let encoding = Base32CrockfordEncoding()
    var checks = 0
    for _ in 0 ... 2000 {
      let id = UUID()
      let data = Data(Array(uuid: id))
      let fullId = encoding.encode(data: data)
      let shortId = String(fullId[fullId.startIndex ... fullId.index(fullId.startIndex, offsetBy: 4)])
      var shortValues = values.reduce([shortId]) { (shortValues, arg1) -> [String] in

        let (key, value) = arg1
        let current = shortValues.last ?? shortId

        return shortValues + [current.replacingOccurrences(of: key, with: value)]
      }
      shortValues.append((shortValues.last ?? shortId).lowercased())
      shortValues = [String](Set(shortValues))
      for aShortId in shortValues {
        debugPrint(aShortId, fullId)
        checks += 1
        let result = encoding.decodeWithoutChecksum(base32Encoded: aShortId)
        for (lhs, rhs) in zip(data, result) {
          XCTAssertEqual(lhs, rhs)
        }
      }
      if checks > 500 {
        return
      }
    }
  }
}
