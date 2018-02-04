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
    legalities:     CardLegality[];
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

export interface CardLegality {
    format:   Format;
    legality: LegalityLegality;
}

export enum Format {
    AmonkhetBlock = "Amonkhet Block",
    BattleForZendikarBlock = "Battle for Zendikar Block",
    Commander = "Commander",
    IceAgeBlock = "Ice Age Block",
    InnistradBlock = "Innistrad Block",
    InvasionBlock = "Invasion Block",
    IxalanBlock = "Ixalan Block",
    KaladeshBlock = "Kaladesh Block",
    KamigawaBlock = "Kamigawa Block",
    KhansOfTarkirBlock = "Khans of Tarkir Block",
    Legacy = "Legacy",
    LorwynShadowmoorBlock = "Lorwyn-Shadowmoor Block",
    MasquesBlock = "Masques Block",
    MirageBlock = "Mirage Block",
    MirrodinBlock = "Mirrodin Block",
    Modern = "Modern",
    OdysseyBlock = "Odyssey Block",
    OnslaughtBlock = "Onslaught Block",
    RavnicaBlock = "Ravnica Block",
    ReturnToRavnicaBlock = "Return to Ravnica Block",
    ScarsOfMirrodinBlock = "Scars of Mirrodin Block",
    ShadowsOverInnistradBlock = "Shadows over Innistrad Block",
    ShardsOfAlaraBlock = "Shards of Alara Block",
    Standard = "Standard",
    TempestBlock = "Tempest Block",
    TherosBlock = "Theros Block",
    TimeSpiralBlock = "Time Spiral Block",
    UnSets = "Un-Sets",
    UrzaBlock = "Urza Block",
    Vintage = "Vintage",
    ZendikarBlock = "Zendikar Block",
}

export enum LegalityLegality {
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
export module Convert {
    export function toLEAExtras(json: string): LEAExtras {
        return cast(JSON.parse(json), O("LEAExtras"));
    }

    export function lEAExtrasToJson(value: LEAExtras): string {
        return JSON.stringify(value, null, 2);
    }
    
    function cast<T>(obj: any, typ: any): T {
        if (!isValid(typ, obj)) {
            throw `Invalid value`;
        }
        return obj;
    }

    function isValid(typ: any, val: any): boolean {
        if (typ === undefined) return true;
        if (typ === null) return val === null || val === undefined;
        return typ.isUnion  ? isValidUnion(typ.typs, val)
                : typ.isArray  ? isValidArray(typ.typ, val)
                : typ.isMap    ? isValidMap(typ.typ, val)
                : typ.isEnum   ? isValidEnum(typ.name, val)
                : typ.isObject ? isValidObject(typ.cls, val)
                :                isValidPrimitive(typ, val);
    }

    function isValidPrimitive(typ: string, val: any) {
        return typeof typ === typeof val;
    }

    function isValidUnion(typs: any[], val: any): boolean {
        // val must validate against one typ in typs
        return typs.find(typ => isValid(typ, val)) !== undefined;
    }

    function isValidEnum(enumName: string, val: any): boolean {
        const cases = typeMap[enumName];
        return cases.indexOf(val) !== -1;
    }

    function isValidArray(typ: any, val: any): boolean {
        // val must be an array with no invalid elements
        return Array.isArray(val) && val.every((element, i) => {
            return isValid(typ, element);
        });
    }

    function isValidMap(typ: any, val: any): boolean {
        if (val === null || typeof val !== "object" || Array.isArray(val)) return false;
        // all values in the map must be typ
        return Object.keys(val).every(prop => {
            if (!Object.prototype.hasOwnProperty.call(val, prop)) return true;
            return isValid(typ, val[prop]);
        });
    }

    function isValidObject(className: string, val: any): boolean {
        if (val === null || typeof val !== "object" || Array.isArray(val)) return false;
        let typeRep = typeMap[className];
        return Object.keys(typeRep).every(prop => {
            if (!Object.prototype.hasOwnProperty.call(typeRep, prop)) return true;
            return isValid(typeRep[prop], val[prop]);
        });
    }

    function A(typ: any) {
        return { typ, isArray: true };
    }

    function E(name: string) {
        return { name, isEnum: true };
    }

    function U(...typs: any[]) {
        return { typs, isUnion: true };
    }

    function M(typ: any) {
        return { typ, isMap: true };
    }

    function O(className: string) {
        return { cls: className, isObject: true };
    }

    const typeMap: any = {
        "LEAExtras": {
            name: "",
            code: "",
            gathererCode: "",
            magicCardsInfoCode: "",
            releaseDate: "",
            border: "",
            type: "",
            booster: A(E("Booster")),
            mkm_name: "",
            mkm_id: 0,
            cards: A(O("Card")),
        },
        "Card": {
            artist: "",
            cmc: 0,
            id: "",
            imageName: "",
            layout: E("Layout"),
            legalities: A(O("CardLegality")),
            manaCost: U(null, ""),
            mciNumber: U(null, ""),
            multiverseid: 0,
            name: "",
            originalText: U(null, ""),
            originalType: "",
            printings: A(""),
            rarity: E("Rarity"),
            rulings: U(null, A(O("Ruling"))),
            text: U(null, ""),
            type: "",
            types: A(E("Type")),
            reserved: U(null, false),
            power: U(null, ""),
            subtypes: U(null, A("")),
            toughness: U(null, ""),
            colorIdentity: U(null, A(E("ColorIdentity"))),
            flavor: U(null, ""),
            colors: U(null, A(E("Color"))),
            supertypes: U(null, A(E("Supertype"))),
            variations: U(null, A(0)),
        },
        "CardLegality": {
            format: E("Format"),
            legality: E("LegalityLegality"),
        },
        "Ruling": {
            date: "",
            text: "",
        },
        "Booster": [
            Booster.Common,
            Booster.Rare,
            Booster.Uncommon,
        ],
        "ColorIdentity": [
            ColorIdentity.B,
            ColorIdentity.G,
            ColorIdentity.R,
            ColorIdentity.U,
            ColorIdentity.W,
        ],
        "Color": [
            Color.Black,
            Color.Blue,
            Color.Green,
            Color.Red,
            Color.White,
        ],
        "Layout": [
            Layout.Normal,
        ],
        "Format": [
            Format.AmonkhetBlock,
            Format.BattleForZendikarBlock,
            Format.Commander,
            Format.IceAgeBlock,
            Format.InnistradBlock,
            Format.InvasionBlock,
            Format.IxalanBlock,
            Format.KaladeshBlock,
            Format.KamigawaBlock,
            Format.KhansOfTarkirBlock,
            Format.Legacy,
            Format.LorwynShadowmoorBlock,
            Format.MasquesBlock,
            Format.MirageBlock,
            Format.MirrodinBlock,
            Format.Modern,
            Format.OdysseyBlock,
            Format.OnslaughtBlock,
            Format.RavnicaBlock,
            Format.ReturnToRavnicaBlock,
            Format.ScarsOfMirrodinBlock,
            Format.ShadowsOverInnistradBlock,
            Format.ShardsOfAlaraBlock,
            Format.Standard,
            Format.TempestBlock,
            Format.TherosBlock,
            Format.TimeSpiralBlock,
            Format.UnSets,
            Format.UrzaBlock,
            Format.Vintage,
            Format.ZendikarBlock,
        ],
        "LegalityLegality": [
            LegalityLegality.Banned,
            LegalityLegality.Legal,
            LegalityLegality.Restricted,
        ],
        "Rarity": [
            Rarity.BasicLand,
            Rarity.Common,
            Rarity.Rare,
            Rarity.Uncommon,
        ],
        "Supertype": [
            Supertype.Basic,
        ],
        "Type": [
            Type.Artifact,
            Type.Creature,
            Type.Enchantment,
            Type.Instant,
            Type.Land,
            Type.Sorcery,
        ],
    };
}
