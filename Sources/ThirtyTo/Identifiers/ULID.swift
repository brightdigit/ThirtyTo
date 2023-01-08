import Foundation

/// Universally Unique Lexicographically Sortable Identifier
///
/// For more information checkout the [ULID specifications](https://github.com/ulid/spec).
public struct ULID: ComposableIdentifier {
  /// Whether the _random part_ of the identifier should a specific value
  /// or based on a ``RandomDataGenerator``.
  public enum RandomPartSpecifications {
    /// Randomly generate the data based on the ``RandomDataGenerator``.
    /// - Note: If none is provided ``Identifier/defaultRandomGenerator`` is used.
    case random(RandomDataGenerator?)
    /// Use the specific data.
    case specific(Data)
  }

  /// Specifications for creating the ULID.
  public enum Specifications {
    /// Use the specific data.
    case data(Data)
    /// Use the date, (_now_ if nil) and the specifications for the _random part_.
    case parts(Date?, RandomPartSpecifications)

    /// The default specifications which use now and the ``Identifier/defaultRandomGenerator``.
    public static let `default`: Specifications = .parts(nil, .random(nil))
  }

  /// The underlying data of the object.
  public let data: Data

  /// The _random part_ which is the last 10 bytes.
  public var randomPart: Data {
    data.suffix(10)
  }

  /// The timestamp part which is the first 6 bytes.
  public var timestamp: Date {
    Date(timestampData: data.prefix(6))
  }

  /// Creates the ULID baed on the specifications.
  /// - Parameter specifications: How to build the ULID for both sections.
  public init(specifications: Specifications = .default) {
    switch specifications {
    case let .data(data):
      assert(data.count == 16)
      self.data = data

    case let .parts(date, randomSpec):
      let date = date ?? Date()
      let randomPart: Data
      switch randomSpec {
      case let .random(generator):
        var generator = generator ?? Data.defaultRandomGenerator()
        randomPart = generator.generate(withCount: 10)

      case let .specific(data):
        assert(data.count == 10)
        randomPart = data
      }
      let fillerCount = max(10 - randomPart.count, 0)
      let timestampData = date.data(withMaximumByteCount: 6)
      let fillerData = Data(count: fillerCount)
      let randomPartData = randomPart.prefix(10)
      data = timestampData + fillerData + randomPartData
      assert(data.count == 16)
    }
  }
}
