import uuid 
import base32_crockford

for int in range(255):
  id = uuid.uuid4()
  intencoded = base32_crockford.encode(id.int, checksum=False)
  intencodedcs = base32_crockford.encode(id.int, checksum=True)
  #bytesencoded = base32_crockford.encode(id.bytes, checksum=False)
  print(id, id.int, intencoded, intencodedcs)