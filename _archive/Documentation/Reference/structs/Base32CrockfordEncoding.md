**STRUCT**

# `Base32CrockfordEncoding`

```swift
public struct Base32CrockfordEncoding: Base32CrockfordEncodingProtocol, Base32CrockfordComparer
```

## Methods
### `encode(data:options:)`

```swift
public func encode(data: Data, options _: Base32CrockfordEncodingOptions) -> String
```

### `decode(base32Encoded:options:)`

```swift
public func decode(base32Encoded string: String, options _: Base32CrockfordDecodingOptions) throws -> Data
```

### `data(_:hasEncodedPrefix:)`

```swift
public func data(_ data: Data, hasEncodedPrefix prefix: String) -> Bool
```
