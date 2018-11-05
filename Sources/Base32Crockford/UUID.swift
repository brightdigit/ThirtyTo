import Foundation

extension UUID {
  init(data: Data) {
    var bytes = [UInt8](repeating: 0, count: data.count)
    _ = bytes.withUnsafeMutableBufferPointer {
      data.copyBytes(to: $0)
    }
    
    //data.getBytes(&bytes, length: data.length * sizeof(UInt8))
    self =  NSUUID(uuidBytes: bytes) as UUID
  }
}