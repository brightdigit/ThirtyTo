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
        let encodedUUID = Base32CrockfordEncoding.encoding.encode(data: uuidData).replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
        let encodedInt = Base32CrockfordEncoding.encoding.encode(data: parameters.integer.data).replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
        
       print(uuidData.hexEncodedString())
        print(parameters.integer.data.hexEncodedString())
       // print(parameters.integer.byteSwapped.data.hexEncodedString())
       // print(Data(uuidData.reversed()).hexEncodedString())
        //print(Data(parameters.integer.data.reversed()).hexEncodedString())
//        XCTAssertEqual(parameters.integer.data.first, uuidData.first)
//        XCTAssertEqual(parameters.integer.data.last, uuidData.last)
        //XCTAssertEqual(parameters.integer.byteSwapped.data.hexEncodedString(), uuidData.hexEncodedString())
        XCTAssertEqual(parameters.integer.data.count, 128 / 8)
        XCTAssertEqual(encodedInt, encodedUUID)
        XCTAssertEqual(encodedInt, parameters.encoded)
        XCTAssertEqual(encodedUUID, parameters.encoded)
        return
      }
    }


}

extension UInt128 {
    var data: Data {
      var upperBits = self.byteSwapped.value.upperBits
      var lowerBits = self.byteSwapped.value.lowerBits
      return Data(bytes: &lowerBits, count: MemoryLayout<UInt64>.size) +
      Data(bytes: &upperBits, count: MemoryLayout<UInt64>.size)
      
    }
    

}

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
}
