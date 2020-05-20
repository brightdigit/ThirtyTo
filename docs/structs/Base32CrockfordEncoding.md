**STRUCT**

# `Base32CrockfordEncoding`

```swift
public struct Base32CrockfordEncoding: Base32CrockfordEncodingProtocol
```

## Methods
### `encode(data:)`

```swift
public func encode(data: Data) -> String
```

### `decodeWithoutChecksum(base32Encoded:)`

```swift
public func decodeWithoutChecksum(base32Encoded string: String) -> Data
```

### `decode(base32Encoded:)`

```swift
public func decode(base32Encoded string: String) throws -> Data
```
