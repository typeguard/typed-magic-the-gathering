// To parse this data:
//
//   import { Convert, LEAExtras } from "./file";
//
//   const lEAExtras = Convert.toLEAExtras(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export interface LEAExtras {
    name:               string;
    code:               string;
    gathererCode:       string;
    magicCardsInfoCode: string;
    releaseDate:        string;
    border:             string;
    type:               string;
    booster:            Booster[];
    mkm_name:           string;
    mkm_id:             number;
    cards:              Card[];
}

export enum Booster {
    Common = "common",
    Rare = "rare",
    Uncommon = "uncommon",
}

export interface Card {
    artist:         string;
    cmc:            number;
    id:             string;
    imageName:      string;
    layout:         Layout;
    legalities:     LegalityElement[];
    manaCost?:      string;
    mciNumber?:     string;
    multiverseid:   number;
    name:           string;
    originalText?:  string;
    originalType:   string;
    printings:      string[];
    rarity:         Rarity;
    rulings?:       Ruling[];
    text?:          string;
    type:           string;
    types:          Type[];
    reserved?:      boolean;
    power?:         string;
    subtypes?:      string[];
    toughness?:     string;
    colorIdentity?: ColorIdentity[];
    flavor?:        string;
    colors?:        Color[];
    supertypes?:    Supertype[];
    variations?:    number[];
}

export enum ColorIdentity {
    B = "B",
    G = "G",
    R = "R",
    U = "U",
    W = "W",
}

export enum Color {
    Black = "Black",
    Blue = "Blue",
    Green = "Green",
    Red = "Red",
    White = "White",
}

export enum Layout {
    Normal = "normal",
}

export interface LegalityElement {
    format:   Format;
    legality: LegalityEnum;
}

export enum Format {
    Brawl = "Brawl",
    Commander = "Commander",
    Legacy = "Legacy",
    Modern = "Modern",
    Standard = "Standard",
    Vintage = "Vintage",
}

export enum LegalityEnum {
    Banned = "Banned",
    Legal = "Legal",
    Restricted = "Restricted",
}

export enum Rarity {
    BasicLand = "Basic Land",
    Common = "Common",
    Rare = "Rare",
    Uncommon = "Uncommon",
}

export interface Ruling {
    date: string;
    text: string;
}

export enum Supertype {
    Basic = "Basic",
}

export enum Type {
    Artifact = "Artifact",
    Creature = "Creature",
    Enchantment = "Enchantment",
    Instant = "Instant",
    Land = "Land",
    Sorcery = "Sorcery",
}

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
export namespace Convert {
    export function toLEAExtras(json: string): LEAExtras {
        return cast(JSON.parse(json), r("LEAExtras"));
    }

    export function lEAExtrasToJson(value: LEAExtras): string {
        return JSON.stringify(uncast(value, r("LEAExtras")), null, 2);
    }

    function invalidValue(typ: any, val: any): never {
        throw Error(`Invalid value ${JSON.stringify(val)} for type ${JSON.stringify(typ)}`);
    }

    function jsonToJSProps(typ: any): any {
        if (typ.jsonToJS === undefined) {
            var map: any = {};
            typ.props.forEach((p: any) => map[p.json] = { key: p.js, typ: p.typ });
            typ.jsonToJS = map;
        }
        return typ.jsonToJS;
    }

    function jsToJSONProps(typ: any): any {
        if (typ.jsToJSON === undefined) {
            var map: any = {};
            typ.props.forEach((p: any) => map[p.js] = { key: p.json, typ: p.typ });
            typ.jsToJSON = map;
        }
        return typ.jsToJSON;
    }

    function transform(val: any, typ: any, getProps: any): any {
        function transformPrimitive(typ: string, val: any): any {
            if (typeof typ === typeof val) return val;
            return invalidValue(typ, val);
        }

        function transformUnion(typs: any[], val: any): any {
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

        function transformEnum(cases: string[], val: any): any {
            if (cases.indexOf(val) !== -1) return val;
            return invalidValue(cases, val);
        }

        function transformArray(typ: any, val: any): any {
            // val must be an array with no invalid elements
            if (!Array.isArray(val)) return invalidValue("array", val);
            return val.map(el => transform(el, typ, getProps));
        }

        function transformObject(props: { [k: string]: any }, additional: any, val: any): any {
            if (val === null || typeof val !== "object" || Array.isArray(val)) {
                return invalidValue("object", val);
            }
            var result: any = {};
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

    function cast<T>(val: any, typ: any): T {
        return transform(val, typ, jsonToJSProps);
    }

    function uncast<T>(val: T, typ: any): any {
        return transform(val, typ, jsToJSONProps);
    }

    function a(typ: any) {
        return { arrayItems: typ };
    }

    function u(...typs: any[]) {
        return { unionMembers: typs };
    }

    function o(props: any[], additional: any) {
        return { props, additional };
    }

    function m(additional: any) {
        return { props: [], additional };
    }

    function r(name: string) {
        return { ref: name };
    }

    const typeMap: any = {
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
}
