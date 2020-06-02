**PROTOCOL**

# `Base32CrockfordEncodingProtocol`

```swift
public protocol Base32CrockfordEncodingProtocol: Base32CrockfordGenerator
```

## Methods
### `encode(data:)`

```swift
func encode(data: Data) -> String
```

### `decode(base32Encoded:)`

```swift
func decode(base32Encoded string: String) throws -> Data
```
