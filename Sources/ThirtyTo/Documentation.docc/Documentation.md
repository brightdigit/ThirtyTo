# ``ThirtyTo``

Swift Package for using Base32Crockford Encoding for Data and Identifiers.

## Overview

**ThirtyTo** provides a way to encode data and create identifiers which is both efficient and human-readable. While Base64 is more efficient it is not very human-readable with both both upper case and lower case letters as well as punctuation.

### Requirements 

**Apple Platforms**

- Xcode 13.3 or later
- Swift 5.5.2 or later
- iOS 14 / watchOS 6 / tvOS 14 / macOS 12 or later deployment targets

**Linux**

- Ubuntu 18.04 or later
- Swift 5.5.2 or later

### Installation

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In dictum non consectetur a erat nam at lectus urna. Maecenas accumsan lacus vel facilisis volutpat est velit.

### Why use Base32Crockford

Base32Crockford offers the most reasonable compromise when it comes to encoding data. Being a super set of Base16, it uses all ten digits and 22 of the 26 Latin upper case characters.

| Symbol Value   | Decode Symbol   | Encode Symbol   |
|:------------:  |:-------------:  |:-------------:  |
| 0              | 0 O o           | 0               |
| 1              | 1 I i L l       | 1               |
| 2              | 2               | 2               |
| 3              | 3               | 3               |
| 4              | 4               | 4               |
| 5              | 5               | 5               |
| 6              | 6               | 6               |
| 7              | 7               | 7               |
| 8              | 8               | 8               |
| 9              | 9               | 9               |
| 10             | A a             | A               |
| 11             | B b             | B               |
| 12             | C c             | C               |
| 13             | D d             | D               |
| 14             | E e             | E               |
| 15             | F f             | F               |
| 16             | G g             | G               |
| 17             | H h             | H               |
| 18             | J j             | J               |
| 19             | K k             | K               |
| 20             | M m             | M               |
| 21             | N n             | N               |
| 22             | P p             | P               |
| 23             | Q q             | Q               |
| 24             | R r             | R               |
| 25             | S s             | S               |
| 26             | T t             | T               |
| 27             | V v             | V               |
| 28             | W w             | W               |
| 29             | X x             | X               |
| 30             | Y y             | Y               |
| 31             | Z z             | Z               |

### Usage

**ThirtyTo** enables the encoding and decoding data in _Base32Crockford_ as well as creation of unique identifiers. There are a variety of options available for encoding and decoding.

### Encoding and Decoding Data

All encoding and decoding is done through the `Base32CrockfordEncoding.encoding` object. This provides an interface into encoding and decoding data as well standardizing. 

To encode any data call:

```swift
public func encode(
    data: Data,
    options: Base32CrockfordEncodingOptions = .none
  ) -> String
```

Therefore to encode a `Data` object, simply call via:

```swift
let data : Data // 0x00b003786a8d4aa28411f4e268c43629 
let base32String = Base32CrockfordEncoding.encoding.encode(data: data)
print(base32String) // P01QGTMD9AH884FMW9MC8DH9
```

If you wish to decode the string you can call `Base32CrockfordEncoding.decode`:

```swift
let data = try Base32CrockfordEncoding.encoding.decode(
    base32Encoded: "P01QGTMD9AH884FMW9MC8DH9"
) // 0x00b003786a8d4aa28411f4e268c43629
```

The `Base32CrockfordEncoding.encode` object provides the ability to specify options on formatting and a checksum.

#### How Checksum Works

You can optionally provide a checksum character at the end which allows for detecting transmission and entry errors early and inexpensively.

According to the specification:

> The check symbol encodes the number modulo 37, 37 being the least prime number greater than 32. We introduce 5 additional symbols that are used only for encoding or decoding the check symbol.

The additional 5 symbols are:

| Symbol Value   | Decode Symbol   | Encode Symbol   |
|----  |-----  |---  |
| 32   | *     | *   |
| 33   | ~     | ~   |
| 34   | $     | $   |
| 35   | =     | =   |
| 36   | U u   | U   |

If you wish to include the checksum, pass true for the `withChecksum` property on the `Base32CrockfordEncodingOptions` object:

```swift
let data : Data // 0xb63d798c4329401684d1d41d3becc95c
let base32String = Base32CrockfordEncoding.encoding.encode(
    data: data,
    options: .init(withChecksum: true)
)
print(base32String) // 5P7NWRRGS980B89MEM3MXYSJAW5
```

When decoding a string wtih a checksum, you must specify true for the `withChecksum` property on `Base32CrockfordDecodingOptions`:

```swift
let data = try Base32CrockfordEncoding.encoding.decode(
    base32Encoded: "5P7NWRRGS980B89MEM3MXYSJAW5"a,
    options: .init(withChecksum: true)
) // 0xb63d798c4329401684d1d41d3becc95c
```

Besides adding a checksum, `Base32CrockfordEncodingOptions` also provides the ability to add a grouping separator.

#### Using Group Separators

According to the Base32Crockford specification:

> Hyphens (-) can be inserted into symbol strings. This can partition a string into manageable pieces, improving readability by helping to prevent confusion. Hyphens are ignored during decoding.

To insert hyphens to the encoded string, provide the `GroupingOptions` object to `Base32CrockfordEncodingOptions`:

```swift
let data : Data // 00c9c37484b85a42e8b3e7fbf806f2661b
let base32StringGroupedBy3 = Base32CrockfordEncoding.encoding.encode(
    data: data,
    options: .init(groupingBy: .init(maxLength: 3))
)
let base32StringGroupedBy9 = Base32CrockfordEncoding.encoding.encode(
    data: data,
    options: .init(groupingBy: .init(maxLength: 9))
)
print(base32StringGroupedBy3) // 69R-DT8-9E2-T8B-MB7-SZV-Z03-F4S-GV2
print(base32StringGroupedBy9) // 69RDT89E2-T8BMB7SZV-Z03F4SGV2
```

When decoding, hyphens are ignored:

```swift
let dataNoHyphens = try Base32CrockfordEncoding.encoding.decode(
    base32Encoded: "69RDT89E2T8BMB7SZVZ03F4SGV2"
) // 00c9c37484b85a42e8b3e7fbf806f2661b

let dataGroupedBy3 = try Base32CrockfordEncoding.encoding.decode(
    base32Encoded: "69R-DT8-9E2-T8B-MB7-SZV-Z03-F4S-GV2"
) // 00c9c37484b85a42e8b3e7fbf806f2661b

let dataGroupedBy9 = try Base32CrockfordEncoding.encoding.decode(
    base32Encoded: "69RDT89E2-T8BMB7SZV-Z03F4SGV2"
) // 00c9c37484b85a42e8b3e7fbf806f2661b

assert(dataNoHyphens == dataGroupedBy3) // true
assert(dataNoHyphens == dataGroupedBy9) // true
assert(dataGroupedBy3 == dataGroupedBy9) // true
```

### Creating an Identifier

Lorem markdownum duas, qui data superare trisulcis rex haec unius! Rupe quo aut,
cum per, pius attactu. Repperit canenda deiectuque coepit vertitur violentus
quoque! Siccoque corpus. Illa intima Bacchum nativum.

Verque aves ab verba. Hoc auris sed formosissimus malorum virum: cum locoque
genuit, lumina velamina, huc. Materiam cetera, forte, deus tibi hiberna vates
revocamina. Tenebat validisne quod post longe parvis, sic superari!

- Atque et volvitur corpora
- Est ab protinus cornua renuente medii dum
- Modo suo convertit temporis Lapithas numenque coronat

#### UUID

Lorem markdownum adire sui erit suis, esse. Iuvenem merentem negare ingentia et
vitta, Oeagrius sic turpe colonos opertos quaerit aquas ira parsque parenti
pericula. Vestra omni amans illius tactuque de ille tuo ipso excipit meque
quoque hosti abstulit; aurum [nato corpora
velare](http://retexitur-notata.org/spretoret). Partem cincta.

    var oop_rj_rate = prompt(nui_web);
    website -= app.modifier(leopardWebmail.subnet_jpeg_native(print_mbr_boot,
            lun_oop), address_printer_boot);
    var superscalar = classFirewireHard;
    ipad_browser = widgetSecondary.standby_xp_sku(rosetta_igp + 79, 1,
            key_soap_network) - fullBittorrentMail;

Gratissime iunxit, neque *praebere*, cum et nec axes, vara otia. Nantemque est;
iterum quid mortemque dominae non baculum tincto. Fuit voce; **ab** cingentibus
feraxque summaque nomen suo, spemque minor: quae Ceyx omnis tinctam.

#### What is ULID?

Lorem markdownum tenebat. Quo et quis expellitur potes tenuitque impetus est
Achilles, et gelidas, acutae. Enim non ceu fluentia Actaeon Numidasque turbae
expugnare flebile pedes, vultus, danda. Thetis in medio est cornu comitante
fugio requievit corpora miseri primisque primo.

    if (bridge_keystroke_architecture.white(riscRipcording, jfs,
            optical_operation_soft) >= softwarePad(in_model, dynamic)) {
        ram(flatbed);
        isa(vpi.heat_disk_permalink(socket_nic_optical), 3);
    } else {
        hard = bar_ddr_modem + 4 + cybersquatter;
    }
    pack(nodeCgi);
    if (fileSoftwareInput(storageRawUp + restoreSyncNull, dot_secondary) !=
            click_windows_text) {
        flash(engineDocumentWins, cpaBounce.web.errorUat(34, 4));
        bps_graphics_syntax.dpi_truncate_panel(netbios_dv(-4, hostHttps,
                surgeRemote));
        ups_flowchart_plug.copy = seoTrashMatrix(unit_cache, 130102, 5);
    }
    matrixFile += tunneling_dram_graphic;
    var alertParse = -2;

Amnis per aede munus, colorem *semper*, non manu vera petita tamen. Lanigeris
alium victo, novantur faciem Thetidis **raptore prodere flumine** sanguisque ad
*claudit* cupidine, ut vitiorum coniungere quoque campo.

### References

* Crockford32
* ULID

### License 

This code is distributed under the MIT license. See the [LICENSE](https://github.com/brightdigit/ThirtyTo/LICENSE) file for more info.

## Topics

### Encoding and Decoding Data

- ``Base32CrockfordEncoding``
- ``Base32CrockfordEncodingOptions``
- ``Base32CrockfordDecodingOptions``
- ``Base32CrockfordDecodingError``
