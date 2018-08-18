// To parse the JSON, add this file to your project and do:
//
//   let lEAExtras = try LEAExtras(json)

import Foundation

struct LEAExtras: Codable {
    let name, code, gathererCode, magicCardsInfoCode: String
    let releaseDate, border, type: String
    let booster: [Booster]
    let mkmName: String
    let mkmID: Int
    let cards: [Card]

    enum CodingKeys: String, CodingKey {
        case name, code, gathererCode, magicCardsInfoCode, releaseDate, border, type, booster
        case mkmName = "mkm_name"
        case mkmID = "mkm_id"
        case cards
    }
}

enum Booster: String, Codable {
    case common = "common"
    case rare = "rare"
    case uncommon = "uncommon"
}

struct Card: Codable {
    let artist: String
    let cmc: Int
    let id, imageName: String
    let layout: Layout
    let legalities: [LegalityElement]
    let manaCost, mciNumber: String?
    let multiverseid: Int
    let name: String
    let originalText: String?
    let originalType: String
    let printings: [String]
    let rarity: Rarity
    let rulings: [Ruling]?
    let text: String?
    let type: String
    let types: [TypeElement]
    let reserved: Bool?
    let power: String?
    let subtypes: [String]?
    let toughness: String?
    let colorIdentity: [ColorIdentity]?
    let flavor: String?
    let colors: [Color]?
    let supertypes: [Supertype]?
    let variations: [Int]?
}

enum ColorIdentity: String, Codable {
    case b = "B"
    case g = "G"
    case r = "R"
    case u = "U"
    case w = "W"
}

enum Color: String, Codable {
    case black = "Black"
    case blue = "Blue"
    case green = "Green"
    case red = "Red"
    case white = "White"
}

enum Layout: String, Codable {
    case normal = "normal"
}

struct LegalityElement: Codable {
    let format: Format
    let legality: LegalityEnum
}

enum Format: String, Codable {
    case brawl = "Brawl"
    case commander = "Commander"
    case legacy = "Legacy"
    case modern = "Modern"
    case standard = "Standard"
    case vintage = "Vintage"
}

enum LegalityEnum: String, Codable {
    case banned = "Banned"
    case legal = "Legal"
    case restricted = "Restricted"
}

enum Rarity: String, Codable {
    case basicLand = "Basic Land"
    case common = "Common"
    case rare = "Rare"
    case uncommon = "Uncommon"
}

struct Ruling: Codable {
    let date, text: String
}

enum Supertype: String, Codable {
    case basic = "Basic"
}

enum TypeElement: String, Codable {
    case artifact = "Artifact"
    case creature = "Creature"
    case enchantment = "Enchantment"
    case instant = "Instant"
    case land = "Land"
    case sorcery = "Sorcery"
}

// MARK: Convenience initializers and mutators

extension LEAExtras {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LEAExtras.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        name: String? = nil,
        code: String? = nil,
        gathererCode: String? = nil,
        magicCardsInfoCode: String? = nil,
        releaseDate: String? = nil,
        border: String? = nil,
        type: String? = nil,
        booster: [Booster]? = nil,
        mkmName: String? = nil,
        mkmID: Int? = nil,
        cards: [Card]? = nil
    ) -> LEAExtras {
        return LEAExtras(
            name: name ?? self.name,
            code: code ?? self.code,
            gathererCode: gathererCode ?? self.gathererCode,
            magicCardsInfoCode: magicCardsInfoCode ?? self.magicCardsInfoCode,
            releaseDate: releaseDate ?? self.releaseDate,
            border: border ?? self.border,
            type: type ?? self.type,
            booster: booster ?? self.booster,
            mkmName: mkmName ?? self.mkmName,
            mkmID: mkmID ?? self.mkmID,
            cards: cards ?? self.cards
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Card {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Card.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        artist: String? = nil,
        cmc: Int? = nil,
        id: String? = nil,
        imageName: String? = nil,
        layout: Layout? = nil,
        legalities: [LegalityElement]? = nil,
        manaCost: String?? = nil,
        mciNumber: String?? = nil,
        multiverseid: Int? = nil,
        name: String? = nil,
        originalText: String?? = nil,
        originalType: String? = nil,
        printings: [String]? = nil,
        rarity: Rarity? = nil,
        rulings: [Ruling]?? = nil,
        text: String?? = nil,
        type: String? = nil,
        types: [TypeElement]? = nil,
        reserved: Bool?? = nil,
        power: String?? = nil,
        subtypes: [String]?? = nil,
        toughness: String?? = nil,
        colorIdentity: [ColorIdentity]?? = nil,
        flavor: String?? = nil,
        colors: [Color]?? = nil,
        supertypes: [Supertype]?? = nil,
        variations: [Int]?? = nil
    ) -> Card {
        return Card(
            artist: artist ?? self.artist,
            cmc: cmc ?? self.cmc,
            id: id ?? self.id,
            imageName: imageName ?? self.imageName,
            layout: layout ?? self.layout,
            legalities: legalities ?? self.legalities,
            manaCost: manaCost ?? self.manaCost,
            mciNumber: mciNumber ?? self.mciNumber,
            multiverseid: multiverseid ?? self.multiverseid,
            name: name ?? self.name,
            originalText: originalText ?? self.originalText,
            originalType: originalType ?? self.originalType,
            printings: printings ?? self.printings,
            rarity: rarity ?? self.rarity,
            rulings: rulings ?? self.rulings,
            text: text ?? self.text,
            type: type ?? self.type,
            types: types ?? self.types,
            reserved: reserved ?? self.reserved,
            power: power ?? self.power,
            subtypes: subtypes ?? self.subtypes,
            toughness: toughness ?? self.toughness,
            colorIdentity: colorIdentity ?? self.colorIdentity,
            flavor: flavor ?? self.flavor,
            colors: colors ?? self.colors,
            supertypes: supertypes ?? self.supertypes,
            variations: variations ?? self.variations
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension LegalityElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LegalityElement.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        format: Format? = nil,
        legality: LegalityEnum? = nil
    ) -> LegalityElement {
        return LegalityElement(
            format: format ?? self.format,
            legality: legality ?? self.legality
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Ruling {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Ruling.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        date: String? = nil,
        text: String? = nil
    ) -> Ruling {
        return Ruling(
            date: date ?? self.date,
            text: text ?? self.text
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
