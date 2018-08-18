// To parse this JSON data, do
//
//     final leaExtras = leaExtrasFromJson(jsonString);

import 'dart:convert';

LeaExtras leaExtrasFromJson(String str) {
    final jsonData = json.decode(str);
    return LeaExtras.fromJson(jsonData);
}

String leaExtrasToJson(LeaExtras data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class LeaExtras {
    String name;
    String code;
    String gathererCode;
    String magicCardsInfoCode;
    String releaseDate;
    String border;
    String type;
    List<Booster> booster;
    String mkmName;
    int mkmId;
    List<Card> cards;

    LeaExtras({
        this.name,
        this.code,
        this.gathererCode,
        this.magicCardsInfoCode,
        this.releaseDate,
        this.border,
        this.type,
        this.booster,
        this.mkmName,
        this.mkmId,
        this.cards,
    });

    factory LeaExtras.fromJson(Map<String, dynamic> json) => new LeaExtras(
        name: json["name"],
        code: json["code"],
        gathererCode: json["gathererCode"],
        magicCardsInfoCode: json["magicCardsInfoCode"],
        releaseDate: json["releaseDate"],
        border: json["border"],
        type: json["type"],
        booster: new List<Booster>.from(json["booster"].map((x) => boosterValues.map[x])),
        mkmName: json["mkm_name"],
        mkmId: json["mkm_id"],
        cards: new List<Card>.from(json["cards"].map((x) => Card.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "gathererCode": gathererCode,
        "magicCardsInfoCode": magicCardsInfoCode,
        "releaseDate": releaseDate,
        "border": border,
        "type": type,
        "booster": new List<dynamic>.from(booster.map((x) => boosterValues.reverse[x])),
        "mkm_name": mkmName,
        "mkm_id": mkmId,
        "cards": new List<dynamic>.from(cards.map((x) => x.toJson())),
    };
}

enum Booster { RARE, UNCOMMON, COMMON }

final boosterValues = new EnumValues({
    "common": Booster.COMMON,
    "rare": Booster.RARE,
    "uncommon": Booster.UNCOMMON
});

class Card {
    String artist;
    int cmc;
    String id;
    String imageName;
    Layout layout;
    List<LegalityElement> legalities;
    String manaCost;
    String mciNumber;
    int multiverseid;
    String name;
    String originalText;
    String originalType;
    List<String> printings;
    Rarity rarity;
    List<Ruling> rulings;
    String text;
    String type;
    List<Type> types;
    bool reserved;
    String power;
    List<String> subtypes;
    String toughness;
    List<ColorIdentity> colorIdentity;
    String flavor;
    List<Color> colors;
    List<Supertype> supertypes;
    List<int> variations;

    Card({
        this.artist,
        this.cmc,
        this.id,
        this.imageName,
        this.layout,
        this.legalities,
        this.manaCost,
        this.mciNumber,
        this.multiverseid,
        this.name,
        this.originalText,
        this.originalType,
        this.printings,
        this.rarity,
        this.rulings,
        this.text,
        this.type,
        this.types,
        this.reserved,
        this.power,
        this.subtypes,
        this.toughness,
        this.colorIdentity,
        this.flavor,
        this.colors,
        this.supertypes,
        this.variations,
    });

    factory Card.fromJson(Map<String, dynamic> json) => new Card(
        artist: json["artist"],
        cmc: json["cmc"],
        id: json["id"],
        imageName: json["imageName"],
        layout: layoutValues.map[json["layout"]],
        legalities: new List<LegalityElement>.from(json["legalities"].map((x) => LegalityElement.fromJson(x))),
        manaCost: json["manaCost"] == null ? null : json["manaCost"],
        mciNumber: json["mciNumber"] == null ? null : json["mciNumber"],
        multiverseid: json["multiverseid"],
        name: json["name"],
        originalText: json["originalText"] == null ? null : json["originalText"],
        originalType: json["originalType"],
        printings: new List<String>.from(json["printings"].map((x) => x)),
        rarity: rarityValues.map[json["rarity"]],
        rulings: json["rulings"] == null ? null : new List<Ruling>.from(json["rulings"].map((x) => Ruling.fromJson(x))),
        text: json["text"] == null ? null : json["text"],
        type: json["type"],
        types: new List<Type>.from(json["types"].map((x) => typeValues.map[x])),
        reserved: json["reserved"] == null ? null : json["reserved"],
        power: json["power"] == null ? null : json["power"],
        subtypes: json["subtypes"] == null ? null : new List<String>.from(json["subtypes"].map((x) => x)),
        toughness: json["toughness"] == null ? null : json["toughness"],
        colorIdentity: json["colorIdentity"] == null ? null : new List<ColorIdentity>.from(json["colorIdentity"].map((x) => colorIdentityValues.map[x])),
        flavor: json["flavor"] == null ? null : json["flavor"],
        colors: json["colors"] == null ? null : new List<Color>.from(json["colors"].map((x) => colorValues.map[x])),
        supertypes: json["supertypes"] == null ? null : new List<Supertype>.from(json["supertypes"].map((x) => supertypeValues.map[x])),
        variations: json["variations"] == null ? null : new List<int>.from(json["variations"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "artist": artist,
        "cmc": cmc,
        "id": id,
        "imageName": imageName,
        "layout": layoutValues.reverse[layout],
        "legalities": new List<dynamic>.from(legalities.map((x) => x.toJson())),
        "manaCost": manaCost == null ? null : manaCost,
        "mciNumber": mciNumber == null ? null : mciNumber,
        "multiverseid": multiverseid,
        "name": name,
        "originalText": originalText == null ? null : originalText,
        "originalType": originalType,
        "printings": new List<dynamic>.from(printings.map((x) => x)),
        "rarity": rarityValues.reverse[rarity],
        "rulings": rulings == null ? null : new List<dynamic>.from(rulings.map((x) => x.toJson())),
        "text": text == null ? null : text,
        "type": type,
        "types": new List<dynamic>.from(types.map((x) => typeValues.reverse[x])),
        "reserved": reserved == null ? null : reserved,
        "power": power == null ? null : power,
        "subtypes": subtypes == null ? null : new List<dynamic>.from(subtypes.map((x) => x)),
        "toughness": toughness == null ? null : toughness,
        "colorIdentity": colorIdentity == null ? null : new List<dynamic>.from(colorIdentity.map((x) => colorIdentityValues.reverse[x])),
        "flavor": flavor == null ? null : flavor,
        "colors": colors == null ? null : new List<dynamic>.from(colors.map((x) => colorValues.reverse[x])),
        "supertypes": supertypes == null ? null : new List<dynamic>.from(supertypes.map((x) => supertypeValues.reverse[x])),
        "variations": variations == null ? null : new List<dynamic>.from(variations.map((x) => x)),
    };
}

enum ColorIdentity { R, G, B, W, U }

final colorIdentityValues = new EnumValues({
    "B": ColorIdentity.B,
    "G": ColorIdentity.G,
    "R": ColorIdentity.R,
    "U": ColorIdentity.U,
    "W": ColorIdentity.W
});

enum Color { BLACK, BLUE, GREEN, RED, WHITE }

final colorValues = new EnumValues({
    "Black": Color.BLACK,
    "Blue": Color.BLUE,
    "Green": Color.GREEN,
    "Red": Color.RED,
    "White": Color.WHITE
});

enum Layout { NORMAL }

final layoutValues = new EnumValues({
    "normal": Layout.NORMAL
});

class LegalityElement {
    Format format;
    LegalityEnum legality;

    LegalityElement({
        this.format,
        this.legality,
    });

    factory LegalityElement.fromJson(Map<String, dynamic> json) => new LegalityElement(
        format: formatValues.map[json["format"]],
        legality: legalityEnumValues.map[json["legality"]],
    );

    Map<String, dynamic> toJson() => {
        "format": formatValues.reverse[format],
        "legality": legalityEnumValues.reverse[legality],
    };
}

enum Format { COMMANDER, LEGACY, VINTAGE, MODERN, BRAWL, STANDARD }

final formatValues = new EnumValues({
    "Brawl": Format.BRAWL,
    "Commander": Format.COMMANDER,
    "Legacy": Format.LEGACY,
    "Modern": Format.MODERN,
    "Standard": Format.STANDARD,
    "Vintage": Format.VINTAGE
});

enum LegalityEnum { LEGAL, BANNED, RESTRICTED }

final legalityEnumValues = new EnumValues({
    "Banned": LegalityEnum.BANNED,
    "Legal": LegalityEnum.LEGAL,
    "Restricted": LegalityEnum.RESTRICTED
});

enum Rarity { RARE, UNCOMMON, COMMON, BASIC_LAND }

final rarityValues = new EnumValues({
    "Basic Land": Rarity.BASIC_LAND,
    "Common": Rarity.COMMON,
    "Rare": Rarity.RARE,
    "Uncommon": Rarity.UNCOMMON
});

class Ruling {
    String date;
    String text;

    Ruling({
        this.date,
        this.text,
    });

    factory Ruling.fromJson(Map<String, dynamic> json) => new Ruling(
        date: json["date"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "text": text,
    };
}

enum Supertype { BASIC }

final supertypeValues = new EnumValues({
    "Basic": Supertype.BASIC
});

enum Type { ARTIFACT, CREATURE, ENCHANTMENT, SORCERY, INSTANT, LAND }

final typeValues = new EnumValues({
    "Artifact": Type.ARTIFACT,
    "Creature": Type.CREATURE,
    "Enchantment": Type.ENCHANTMENT,
    "Instant": Type.INSTANT,
    "Land": Type.LAND,
    "Sorcery": Type.SORCERY
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
