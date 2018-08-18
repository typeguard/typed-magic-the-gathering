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
    return cast(JSON.parse(json), r("LEAExtras"));
}

function lEAExtrasToJson(value) {
    return JSON.stringify(uncast(value, r("LEAExtras")), null, 2);
}

function invalidValue(typ, val) {
    throw Error(`Invalid value ${JSON.stringify(val)} for type ${JSON.stringify(typ)}`);
}

function jsonToJSProps(typ) {
    if (typ.jsonToJS === undefined) {
        var map = {};
        typ.props.forEach((p) => map[p.json] = { key: p.js, typ: p.typ });
        typ.jsonToJS = map;
    }
    return typ.jsonToJS;
}

function jsToJSONProps(typ) {
    if (typ.jsToJSON === undefined) {
        var map = {};
        typ.props.forEach((p) => map[p.js] = { key: p.json, typ: p.typ });
        typ.jsToJSON = map;
    }
    return typ.jsToJSON;
}

function transform(val, typ, getProps) {
    function transformPrimitive(typ, val) {
        if (typeof typ === typeof val) return val;
        return invalidValue(typ, val);
    }

    function transformUnion(typs, val) {
        // val must validate against one typ in typs
        var l = typs.length;
        for (var i = 0; i < l; i++) {
            var typ = typs[i];
            try {
                return transform(val, typ, getProps);
            } catch (_) {}
        }
        return invalidValue(typs, val);
    }

    function transformEnum(cases, val) {
        if (cases.indexOf(val) !== -1) return val;
        return invalidValue(cases, val);
    }

    function transformArray(typ, val) {
        // val must be an array with no invalid elements
        if (!Array.isArray(val)) return invalidValue("array", val);
        return val.map(el => transform(el, typ, getProps));
    }

    function transformObject(props, additional, val) {
        if (val === null || typeof val !== "object" || Array.isArray(val)) {
            return invalidValue("object", val);
        }
        var result = {};
        Object.getOwnPropertyNames(props).forEach(key => {
            const prop = props[key];
            const v = Object.prototype.hasOwnProperty.call(val, key) ? val[key] : undefined;
            result[prop.key] = transform(v, prop.typ, getProps);
        });
        Object.getOwnPropertyNames(val).forEach(key => {
            if (!Object.prototype.hasOwnProperty.call(props, key)) {
                result[key] = transform(val[key], additional, getProps);
            }
        });
        return result;
    }

    if (typ === "any") return val;
    if (typ === null) {
        if (val === null) return val;
        return invalidValue(typ, val);
    }
    if (typ === false) return invalidValue(typ, val);
    while (typeof typ === "object" && typ.ref !== undefined) {
        typ = typeMap[typ.ref];
    }
    if (Array.isArray(typ)) return transformEnum(typ, val);
    if (typeof typ === "object") {
        return typ.hasOwnProperty("unionMembers") ? transformUnion(typ.unionMembers, val)
            : typ.hasOwnProperty("arrayItems")    ? transformArray(typ.arrayItems, val)
            : typ.hasOwnProperty("props")         ? transformObject(getProps(typ), typ.additional, val)
            : invalidValue(typ, val);
    }
    return transformPrimitive(typ, val);
}

function cast(val, typ) {
    return transform(val, typ, jsonToJSProps);
}

function uncast(val, typ) {
    return transform(val, typ, jsToJSONProps);
}

function a(typ) {
    return { arrayItems: typ };
}

function u(...typs) {
    return { unionMembers: typs };
}

function o(props, additional) {
    return { props, additional };
}

function m(additional) {
    return { props: [], additional };
}

function r(name) {
    return { ref: name };
}

const typeMap = {
    "LEAExtras": o([
        { json: "name", js: "name", typ: "" },
        { json: "code", js: "code", typ: "" },
        { json: "gathererCode", js: "gathererCode", typ: "" },
        { json: "magicCardsInfoCode", js: "magicCardsInfoCode", typ: "" },
        { json: "releaseDate", js: "releaseDate", typ: "" },
        { json: "border", js: "border", typ: "" },
        { json: "type", js: "type", typ: "" },
        { json: "booster", js: "booster", typ: a(r("Booster")) },
        { json: "mkm_name", js: "mkm_name", typ: "" },
        { json: "mkm_id", js: "mkm_id", typ: 0 },
        { json: "cards", js: "cards", typ: a(r("Card")) },
    ], false),
    "Card": o([
        { json: "artist", js: "artist", typ: "" },
        { json: "cmc", js: "cmc", typ: 0 },
        { json: "id", js: "id", typ: "" },
        { json: "imageName", js: "imageName", typ: "" },
        { json: "layout", js: "layout", typ: r("Layout") },
        { json: "legalities", js: "legalities", typ: a(r("LegalityElement")) },
        { json: "manaCost", js: "manaCost", typ: u(undefined, "") },
        { json: "mciNumber", js: "mciNumber", typ: u(undefined, "") },
        { json: "multiverseid", js: "multiverseid", typ: 0 },
        { json: "name", js: "name", typ: "" },
        { json: "originalText", js: "originalText", typ: u(undefined, "") },
        { json: "originalType", js: "originalType", typ: "" },
        { json: "printings", js: "printings", typ: a("") },
        { json: "rarity", js: "rarity", typ: r("Rarity") },
        { json: "rulings", js: "rulings", typ: u(undefined, a(r("Ruling"))) },
        { json: "text", js: "text", typ: u(undefined, "") },
        { json: "type", js: "type", typ: "" },
        { json: "types", js: "types", typ: a(r("Type")) },
        { json: "reserved", js: "reserved", typ: u(undefined, true) },
        { json: "power", js: "power", typ: u(undefined, "") },
        { json: "subtypes", js: "subtypes", typ: u(undefined, a("")) },
        { json: "toughness", js: "toughness", typ: u(undefined, "") },
        { json: "colorIdentity", js: "colorIdentity", typ: u(undefined, a(r("ColorIdentity"))) },
        { json: "flavor", js: "flavor", typ: u(undefined, "") },
        { json: "colors", js: "colors", typ: u(undefined, a(r("Color"))) },
        { json: "supertypes", js: "supertypes", typ: u(undefined, a(r("Supertype"))) },
        { json: "variations", js: "variations", typ: u(undefined, a(0)) },
    ], false),
    "LegalityElement": o([
        { json: "format", js: "format", typ: r("Format") },
        { json: "legality", js: "legality", typ: r("LegalityEnum") },
    ], false),
    "Ruling": o([
        { json: "date", js: "date", typ: "" },
        { json: "text", js: "text", typ: "" },
    ], false),
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
        "Brawl",
        "Commander",
        "Legacy",
        "Modern",
        "Standard",
        "Vintage",
    ],
    "LegalityEnum": [
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
