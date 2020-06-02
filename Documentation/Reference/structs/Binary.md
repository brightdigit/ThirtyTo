**STRUCT**

# `Binary`

```swift
public struct Binary
```

## Properties
### `bytes`

```swift
public let bytes: [UInt8]
```

### `readingOffset`

```swift
public var readingOffset: Int = 0
```

### `byteSize`

```swift
public let byteSize: Int
```

## Methods
### `init(data:byteSize:)`

```swift
public init(data: Data, byteSize: Int = 8)
```

### `bit(_:)`

```swift
public func bit(_ position: Int) -> Int
```

### `bits(_:)`

```swift
public func bits(_ range: Range<Int>) -> Int
```

### `bits(_:_:)`

```swift
public func bits(_ start: Int, _ length: Int) -> Int
```

### `byte(_:)`

```swift
public func byte(_ position: Int) -> Int
```

### `bitsWithInternalOffsetAvailable(_:)`

```swift
public func bitsWithInternalOffsetAvailable(_ length: Int) -> Bool
```

### `next(bits:)`

```swift
public mutating func next(bits length: Int) -> Int?
```
