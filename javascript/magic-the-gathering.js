// To parse this data:
//
//   const Convert = require("./file");
//
//   const lEAExtras = Convert.toLEAExtras(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
function toLEAExtras(json) {
    return cast(JSON.parse(json), o("LEAExtras"));
}

function lEAExtrasToJson(value) {
    return JSON.stringify(value, null, 2);
}

function cast(obj, typ) {
    if (!isValid(typ, obj)) {
        throw `Invalid value`;
    }
    return obj;
}

function isValid(typ, val) {
    if (typ === undefined) return true;
    if (typ === null) return val === null || val === undefined;
    return typ.isUnion  ? isValidUnion(typ.typs, val)
            : typ.isArray  ? isValidArray(typ.typ, val)
            : typ.isMap    ? isValidMap(typ.typ, val)
            : typ.isEnum   ? isValidEnum(typ.name, val)
            : typ.isObject ? isValidObject(typ.cls, val)
            :                isValidPrimitive(typ, val);
}

function isValidPrimitive(typ, val) {
    return typeof typ === typeof val;
}

function isValidUnion(typs, val) {
    // val must validate against one typ in typs
    return typs.find(typ => isValid(typ, val)) !== undefined;
}

function isValidEnum(enumName, val) {
    const cases = typeMap[enumName];
    return cases.indexOf(val) !== -1;
}

function isValidArray(typ, val) {
    // val must be an array with no invalid elements
    return Array.isArray(val) && val.every(element => {
        return isValid(typ, element);
    });
}

function isValidMap(typ, val) {
    if (val === null || typeof val !== "object" || Array.isArray(val)) return false;
    // all values in the map must be typ
    return Object.keys(val).every(prop => {
        if (!Object.prototype.hasOwnProperty.call(val, prop)) return true;
        return isValid(typ, val[prop]);
    });
}

function isValidObject(className, val) {
    if (val === null || typeof val !== "object" || Array.isArray(val)) return false;
    let typeRep = typeMap[className];
    return Object.keys(typeRep).every(prop => {
        if (!Object.prototype.hasOwnProperty.call(typeRep, prop)) return true;
        return isValid(typeRep[prop], val[prop]);
    });
}

function a(typ) {
    return { typ, isArray: true };
}

function e(name) {
    return { name, isEnum: true };
}

function u(...typs) {
    return { typs, isUnion: true };
}

function m(typ) {
    return { typ, isMap: true };
}

function o(className) {
    return { cls: className, isObject: true };
}

const typeMap = {
    "LEAExtras": {
        name: "",
        code: "",
        gathererCode: "",
        magicCardsInfoCode: "",
        releaseDate: "",
        border: "",
        type: "",
        booster: a(e("Booster")),
        mkm_name: "",
        mkm_id: 0,
        cards: a(o("Card")),
    },
    "Card": {
        artist: "",
        cmc: 0,
        id: "",
        imageName: "",
        layout: e("Layout"),
        legalities: a(o("LegalityElement")),
        manaCost: u(null, ""),
        mciNumber: u(null, ""),
        multiverseid: 0,
        name: "",
        originalText: u(null, ""),
        originalType: "",
        printings: a(""),
        rarity: e("Rarity"),
        rulings: u(null, a(o("Ruling"))),
        text: u(null, ""),
        type: "",
        types: a(e("Type")),
        reserved: u(null, false),
        power: u(null, ""),
        subtypes: u(null, a("")),
        toughness: u(null, ""),
        colorIdentity: u(null, a(e("ColorIdentity"))),
        flavor: u(null, ""),
        colors: u(null, a(e("Color"))),
        supertypes: u(null, a(e("Supertype"))),
        variations: u(null, a(0)),
    },
    "LegalityElement": {
        format: e("Format"),
        legality: e("LegalityLegality"),
    },
    "Ruling": {
        date: "",
        text: "",
    },
    "Booster": [
        "common",
        "rare",
        "uncommon",
    ],
    "ColorIdentity": [
        "B",
        "G",
        "R",
        "U",
        "W",
    ],
    "Color": [
        "Black",
        "Blue",
        "Green",
        "Red",
        "White",
    ],
    "Layout": [
        "normal",
    ],
    "Format": [
        "Amonkhet Block",
        "Battle for Zendikar Block",
        "Commander",
        "Ice Age Block",
        "Innistrad Block",
        "Invasion Block",
        "Ixalan Block",
        "Kaladesh Block",
        "Kamigawa Block",
        "Khans of Tarkir Block",
        "Legacy",
        "Lorwyn-Shadowmoor Block",
        "Masques Block",
        "Mirage Block",
        "Mirrodin Block",
        "Modern",
        "Odyssey Block",
        "Onslaught Block",
        "Ravnica Block",
        "Return to Ravnica Block",
        "Scars of Mirrodin Block",
        "Shadows over Innistrad Block",
        "Shards of Alara Block",
        "Standard",
        "Tempest Block",
        "Theros Block",
        "Time Spiral Block",
        "Un-Sets",
        "Urza Block",
        "Vintage",
        "Zendikar Block",
    ],
    "LegalityLegality": [
        "Banned",
        "Legal",
        "Restricted",
    ],
    "Rarity": [
        "Basic Land",
        "Common",
        "Rare",
        "Uncommon",
    ],
    "Supertype": [
        "Basic",
    ],
    "Type": [
        "Artifact",
        "Creature",
        "Enchantment",
        "Instant",
        "Land",
        "Sorcery",
    ],
};

module.exports = {
    "lEAExtrasToJson": lEAExtrasToJson,
    "toLEAExtras": toLEAExtras,
};
