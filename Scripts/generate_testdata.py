import uuid 
import base32_crockford

for int in range(255):
  id = uuid.uuid4()
  strck = base32_crockford.encode(int, checksum=False)
  print(strck)