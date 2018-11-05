import Foundation

extension String {
  func pad(toSize: Int) -> String {
    var padded = self
    for _ in 0..<(toSize - self.count) {
      padded = "0" + padded
    }
    return padded
  }
  
  func split(by length: Int) -> [String] {
    var startIndex = self.startIndex
    var results = [Substring]()
    
    while startIndex < self.endIndex {
      let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
      results.append(self[startIndex..<endIndex])
      startIndex = endIndex
    }
    
    return results.map { String($0) }
  }
}

struct Base32Crockford {
  static let characters = "0123456789abcdefghjkmnpqrtuvwxyz".uppercased()
  static let checksum = [1,1,2,4]
  
  struct ChecksumError : Error {
    
  }
  
  func encode (data : Data) -> String {
    let dataBitCount = data.count * 8
    let resBitCount = Int(ceil(Double(dataBitCount) / 5) * 5.0)
    let difference = resBitCount - dataBitCount
    let lastSegment = difference == 0 ? 0 : 5 - difference
    var binary = Binary(data: data)
    var encodedString = ""
    var index : Int?
    
    
    repeat {
      index = binary.next(bits: 5)
      guard let index = index else {
        break
      }
      encodedString.append(Base32Crockford.characters[Base32Crockford.characters.index(Base32Crockford.characters.startIndex, offsetBy: index)])
      
    }
      while (index != nil)
    if lastSegment > 0 {
      
      let lastIndex = (binary.next(bits: lastSegment)! << difference) + Base32Crockford.checksum[difference - 1]
      encodedString.append(Base32Crockford.characters[Base32Crockford.characters.index(Base32Crockford.characters.startIndex, offsetBy: lastIndex)])
    }
    return encodedString
  }
  
  func decode (string: String) throws -> Data {
    let strBitCount = string.count * 5
    let dataBitCount = Int(floor(Double(strBitCount) / 8)) * 8
    let checksumSize = strBitCount - dataBitCount
    let lastValue : UInt8? = checksumSize == 0 ? nil : UInt8(Base32Crockford.characters.distance(from: Base32Crockford.characters.startIndex, to: Base32Crockford.characters.index(of: string.last!)!))
    
    if let lastValue = lastValue {
      let checksumValue = (lastValue << (8 - checksumSize)) >> (8 - checksumSize)
      guard checksumValue == Base32Crockford.checksum[checksumSize-1] else {
        print(checksumValue)
        print(checksumSize)
        print(Base32Crockford.checksum[checksumSize-1])
        throw ChecksumError()
      }
    }
    
    
    let values = string.map{
      Base32Crockford.characters.distance(from: Base32Crockford.characters.startIndex, to: Base32Crockford.characters.index(of: $0)!)
    }
    let bitString = values.map{String($0, radix: 2).pad(toSize: 5)}.joined(separator: "")
    
    let bitStringWithoutChecksum  = String(bitString[bitString.startIndex...bitString.index(bitString.endIndex, offsetBy: -checksumSize-1)])
    let dataBytes = bitStringWithoutChecksum.split(by: 8).compactMap{UInt8($0, radix: 2)}
    
    return Data(dataBytes)
  }
}


public struct Binary {
  public let bytes: [UInt8]
  public var readingOffset: Int = 0
  public let byteSize : Int
  public init(bytes: [UInt8], byteSize : Int = 8) {
    self.bytes = bytes
    self.byteSize = byteSize
  }
  
  public init(data: Data, byteSize : Int = 8) {
    self.byteSize = byteSize
    let bytesLength = data.count
    var bytesArray  = [UInt8](repeating: 0, count: bytesLength)
    (data as NSData).getBytes(&bytesArray, length: bytesLength)
    self.bytes      = bytesArray
  }
  
  public func bit(_ position: Int) -> Int {
    let bytePosition    = position / byteSize
    let bitPosition     = (self.byteSize - 1) - (position % byteSize)
    let byte            = self.byte(bytePosition)
    return (byte >> bitPosition) & 0x01
  }
  
  public func bits(_ range: Range<Int>) -> Int {
    var positions = [Int]()
    
    for position in range.lowerBound..<range.upperBound {
      positions.append(position)
    }
    
    return positions.reversed().enumerated().reduce(0) {
      $0 + (bit($1.element) << $1.offset)
    }
  }
  
  public func bits(_ start: Int, _ length: Int) -> Int {
    return self.bits(start..<(start + length))
  }
  
  public func byte(_ position: Int) -> Int {
    return Int(self.bytes[position])
  }
  
  public func bytes(_ start: Int, _ length: Int) -> [UInt8] {
    return Array(self.bytes[start..<start+length])
  }
  
  public func bytes(_ start: Int, _ length: Int) -> Int {
    return bits(start*self.byteSize, length*self.byteSize)
  }
  
  public func bitsWithInternalOffsetAvailable(_ length: Int) -> Bool {
    return (self.bytes.count * self.byteSize) >= (self.readingOffset + length)
  }
  
  public mutating func next(bits length: Int) -> Int? {
    if self.bitsWithInternalOffsetAvailable(length) {
      let returnValue = self.bits(self.readingOffset, length)
      self.readingOffset = self.readingOffset + length
      return returnValue
    } else {
      return nil
    }
  }
  
  public func bytesWithInternalOffsetAvailable(_ length: Int) -> Bool {
    let availableBits = self.bytes.count * self.byteSize
    let requestedBits = readingOffset + (length * self.byteSize)
    let possible      = availableBits >= requestedBits
    return possible
  }
  
  public mutating func next(bytes length: Int) -> [UInt8] {
    if bytesWithInternalOffsetAvailable(length) {
      let returnValue = self.bytes[(self.readingOffset / self.byteSize)..<((self.readingOffset / self.byteSize) + length)]
      self.readingOffset = self.readingOffset + (length * self.byteSize)
      return Array(returnValue)
    } else {
      fatalError("Couldn't extract Bytes.")
    }
  }
}

extension Array where Element == UInt8 {
  init(uuid: UUID) {
    self = Mirror(reflecting: uuid.uuid).children.map{ $0.value as! UInt8}
  }
}

extension UUID {
  init(data: Data) {
    var bytes = [UInt8](repeating: 0, count: data.count)
    bytes.withUnsafeMutableBufferPointer {
      data.copyBytes(to: $0)
    }
    
    //data.getBytes(&bytes, length: data.length * sizeof(UInt8))
    self =  NSUUID(uuidBytes: bytes) as UUID
  }
}


let b32cf = Base32Crockford()
for length in 1...20 {
  print(length, "...",separator: "", terminator: "")
let bytes = (0...length-1).map{_ in
  UInt8.random(in: 0...UInt8.max)
}
let expectedData = Data(bytes: bytes)
let encodedString = b32cf.encode(data: expectedData)
let actualData = try! b32cf.decode(string: encodedString)
  guard expectedData.elementsEqual(actualData) else {
    print()
    print(expectedData.count, actualData.count)
    print(expectedData.base64EncodedString(), actualData.base64EncodedString())
    break
  
  }
  print(encodedString)
}
