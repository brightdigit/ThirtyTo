@testable import ThirtyTo
import XCTest

#if swift(<5.7)
  final class AnyComposableIdentifierTests: XCTestCase {
    private func unreachable() -> Never {
      repeat {
        RunLoop.current.run()
      } while true
    }

    func testNever() {
      let expectation = expectation(description: "`Never` called.")
      DispatchQueue.global(qos: .userInitiated).async {
        _ = _AnyComposableIdentifier {
          expectation.fulfill()
          self.unreachable()
        }
      }

      waitForExpectations(timeout: 0.1) { _ in }
    }

    func testWrapped() {
      let udid = UDID(specifications: .init(size: .bytes(12)))
      let identifier = _AnyComposableIdentifier(wrapped: udid)
      XCTAssertEqual(udid.data, identifier.data)
    }
  }
#endif
