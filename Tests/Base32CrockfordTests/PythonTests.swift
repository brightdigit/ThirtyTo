//
//  PythonTests.swift
//  
//
//  Created by Leo Dion on 1/2/23.
//

@testable import Base32Crockford
import XCTest

final class PythonTests: XCTestCase {
  var python : [Parameters]!
  struct Parameters {
    internal init(uuid: UUID, integer: UInt128, encoded: String, encodedWithChecksum: String) {
      self.uuid = uuid
      self.integer = integer
      self.encoded = encoded
      self.encodedWithChecksum = encodedWithChecksum
    }
    
    internal init?(line: String) {
      guard !line.isEmpty else {
        return nil
      }
      let components = line.components(separatedBy: .whitespaces)
      precondition(components.count == 4)
      guard let uuid = UUID(uuidString: components[0]) else {
        preconditionFailure()
      }
      guard let integer = UInt128(components[1]) else {
        preconditionFailure()
      }
      let encoded = components[2]
      let encodedWithChecksum = components[3]
      self.init(uuid: uuid, integer: integer, encoded: encoded, encodedWithChecksum: encodedWithChecksum)
    }
    
    let uuid: UUID
    let integer : UInt128
    let encoded: String
    let encodedWithChecksum : String
  }
  
  override func setUp() {
    let pythonUrl = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("../../Data/python")
    guard let pythonText = try? String(contentsOf: pythonUrl) else {
      return
    }
    
    python = pythonText.components(separatedBy: .newlines).compactMap(Parameters.init)
  }

    func testExample() throws {
      for parameters in self.python {
        let uuidData = Data(Array(uuid: parameters.uuid))
        let encodedUUID = Base32CrockfordEncoding.encoding.encode(data: uuidData)
        let encodedInt = Base32CrockfordEncoding.encoding.encode(data: parameters.integer.data)
        XCTAssertEqual(encodedInt, encodedUUID)
        XCTAssertEqual(encodedInt, parameters.encoded)
        XCTAssertEqual(encodedUUID, parameters.encoded)
      }
    }


}

extension UInt128 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt128>.size)
    }
    

}
