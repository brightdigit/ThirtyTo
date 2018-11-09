//
//  IdentifierDataType.swift
//  Base32Crockford
//
//  Created by Leo Dion on 11/8/18.
//

import Foundation

public enum IdentifierDataType {
  case `default`
  case uuid
  case bytes(size: Int)
  case minimumCount(Int)
}
