// To parse the JSON, add this file to your project and do:
//
//   guard let lEAExtras = try LEAExtras(json) else { ... }

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
    let legalities: [CardLegality]
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
    let types: [PurpleType]
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

struct CardLegality: Codable {
    let format: Format
    let legality: LegalityLegality
}

enum Format: String, Codable {
    case amonkhetBlock = "Amonkhet Block"
    case battleForZendikarBlock = "Battle for Zendikar Block"
    case commander = "Commander"
    case iceAgeBlock = "Ice Age Block"
    case innistradBlock = "Innistrad Block"
    case invasionBlock = "Invasion Block"
    case ixalanBlock = "Ixalan Block"
    case kaladeshBlock = "Kaladesh Block"
    case kamigawaBlock = "Kamigawa Block"
    case khansOfTarkirBlock = "Khans of Tarkir Block"
    case legacy = "Legacy"
    case lorwynShadowmoorBlock = "Lorwyn-Shadowmoor Block"
    case masquesBlock = "Masques Block"
    case mirageBlock = "Mirage Block"
    case mirrodinBlock = "Mirrodin Block"
    case modern = "Modern"
    case odysseyBlock = "Odyssey Block"
    case onslaughtBlock = "Onslaught Block"
    case ravnicaBlock = "Ravnica Block"
    case returnToRavnicaBlock = "Return to Ravnica Block"
    case scarsOfMirrodinBlock = "Scars of Mirrodin Block"
    case shadowsOverInnistradBlock = "Shadows over Innistrad Block"
    case shardsOfAlaraBlock = "Shards of Alara Block"
    case standard = "Standard"
    case tempestBlock = "Tempest Block"
    case therosBlock = "Theros Block"
    case timeSpiralBlock = "Time Spiral Block"
    case unSets = "Un-Sets"
    case urzaBlock = "Urza Block"
    case vintage = "Vintage"
    case zendikarBlock = "Zendikar Block"
}

enum LegalityLegality: String, Codable {
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

enum PurpleType: String, Codable {
    case artifact = "Artifact"
    case creature = "Creature"
    case enchantment = "Enchantment"
    case instant = "Instant"
    case land = "Land"
    case sorcery = "Sorcery"
}

// MARK: Convenience initializers

extension LEAExtras {
    init(data: Data) throws {
        self = try JSONDecoder().decode(LEAExtras.self, from: data)
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else { return nil }
        try self.init(data: data)
    }

    init?(fromURL url: String) throws {
        guard let url = URL(string: url) else { return nil }
        let data = try Data(contentsOf: url)
        try self.init(data: data)
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString() throws -> String? {
        return String(data: try self.jsonData(), encoding: .utf8)
    }
}

extension Card {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Card.self, from: data)
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else { return nil }
        try self.init(data: data)
    }

    init?(fromURL url: String) throws {
        guard let url = URL(string: url) else { return nil }
        let data = try Data(contentsOf: url)
        try self.init(data: data)
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString() throws -> String? {
        return String(data: try self.jsonData(), encoding: .utf8)
    }
}

extension CardLegality {
    init(data: Data) throws {
        self = try JSONDecoder().decode(CardLegality.self, from: data)
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else { return nil }
        try self.init(data: data)
    }

    init?(fromURL url: String) throws {
        guard let url = URL(string: url) else { return nil }
        let data = try Data(contentsOf: url)
        try self.init(data: data)
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString() throws -> String? {
        return String(data: try self.jsonData(), encoding: .utf8)
    }
}

extension Ruling {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Ruling.self, from: data)
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else { return nil }
        try self.init(data: data)
    }

    init?(fromURL url: String) throws {
        guard let url = URL(string: url) else { return nil }
        let data = try Data(contentsOf: url)
        try self.init(data: data)
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString() throws -> String? {
        return String(data: try self.jsonData(), encoding: .utf8)
    }
}
