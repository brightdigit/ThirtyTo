import uuid 
import base32_crockford

for _ in range(100):
  id = uuid.uuid4()
  strck = base32_crockford.encode(id.int, checksum=False)
  print(id, strck)