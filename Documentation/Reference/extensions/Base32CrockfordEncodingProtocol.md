**EXTENSION**

# `Base32CrockfordEncodingProtocol`
```swift
public extension Base32CrockfordEncodingProtocol
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

### `standardize(string:)`

```swift
func standardize(string: String) -> String
```

### `generateIdentifier(from:)`

```swift
public func generateIdentifier(from identifierDataType: IdentifierDataType) -> String
```

### `generate(_:from:)`

```swift
public func generate(_ count: Int, from identifierDataType: IdentifierDataType) -> [String]
```
