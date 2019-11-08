import Foundation

public struct Base32CrockfordEncoding : Base32CrockfordEncodingProtocol {

  public static let encoding : Base32CrockfordEncodingProtocol = Base32CrockfordEncoding()
  
  static let characters = "0123456789abcdefghjkmnpqrtuvwxyz".uppercased()
  static let checksum = [1,1,2,4]
  
  struct ChecksumError : Error {
    
  }
  

  
  public func encode (data : Data) -> String {
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
      encodedString.append(Base32CrockfordEncoding.characters[Base32CrockfordEncoding.characters.index(Base32CrockfordEncoding.characters.startIndex, offsetBy: index)])
      
    } while (index != nil)

    if lastSegment > 0 {
      let lastIndex = (binary.next(bits: lastSegment)! << difference) + Base32CrockfordEncoding.checksum[difference - 1]
      encodedString.append(Base32CrockfordEncoding.characters[Base32CrockfordEncoding.characters.index(Base32CrockfordEncoding.characters.startIndex, offsetBy: lastIndex)])
    }
    return encodedString
  }
  
  public func decode (base32Encoded string: String) throws -> Data {
    let strBitCount = string.count * 5
    let dataBitCount = Int(floor(Double(strBitCount) / 8)) * 8
    let checksumSize = strBitCount - dataBitCount
    let lastValue : UInt8? = checksumSize == 0 ? nil : UInt8(Base32CrockfordEncoding.characters.distance(from: Base32CrockfordEncoding.characters.startIndex, to: Base32CrockfordEncoding.characters.firstIndex(of: string.last!)!))
    
    if let lastValue = lastValue {
      let checksumValue = (lastValue << (8 - checksumSize)) >> (8 - checksumSize)
      guard checksumValue == Base32CrockfordEncoding.checksum[checksumSize-1] else {
        throw ChecksumError()
      }
    }
    
    let values = string.map{
      Base32CrockfordEncoding.characters.distance(from: Base32CrockfordEncoding.characters.startIndex, to: Base32CrockfordEncoding.characters.firstIndex(of: $0)!)
    }

    let bitString = values.map{String($0, radix: 2).pad(toSize: 5)}.joined(separator: "")
    
    let bitStringWithoutChecksum  = String(bitString[bitString.startIndex...bitString.index(bitString.endIndex, offsetBy: -checksumSize-1)])
    let dataBytes = bitStringWithoutChecksum.split(by: 8).compactMap{UInt8($0, radix: 2)}
    return Data(dataBytes)
  }
}


