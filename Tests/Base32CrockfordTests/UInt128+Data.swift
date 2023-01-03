//
//  PythonTests.swift
//  
//
//  Created by Leo Dion on 1/2/23.
//

@testable import Base32Crockford
import XCTest

extension UInt128 {
    var data: Data {
      var upperBits = self.byteSwapped.value.upperBits
      var lowerBits = self.byteSwapped.value.lowerBits
      return Data(bytes: &lowerBits, count: MemoryLayout<UInt64>.size) +
      Data(bytes: &upperBits, count: MemoryLayout<UInt64>.size)
    }
}
