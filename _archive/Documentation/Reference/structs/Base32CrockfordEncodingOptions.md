**STRUCT**

# `Base32CrockfordEncodingOptions`

```swift
public struct Base32CrockfordEncodingOptions: OptionSet
```

## Properties
### `rawValue`

```swift
public let rawValue: Int
```

## Methods
### `init(rawValue:)`

```swift
public init(rawValue: Int)
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| rawValue | The raw value of the option set to create. Each bit of `rawValue` potentially represents an element of the option set, though raw values may include bits that are not defined as distinct values of the `OptionSet` type. |