# This code parses date/times, so please
#
#     pip install python-dateutil
#
# To use this code, make sure you
#
#     import json
#
# and then, to convert JSON from a string, do
#
#     result = lea_extras_from_dict(json.loads(json_string))

from enum import Enum
from typing import Any, List, Optional, TypeVar, Type, Callable, cast
from datetime import datetime
import dateutil.parser


T = TypeVar("T")
EnumT = TypeVar("EnumT", bound=Enum)


def to_enum(c: Type[EnumT], x: Any) -> EnumT:
    assert isinstance(x, c)
    return x.value


def from_datetime(x: Any) -> datetime:
    return dateutil.parser.parse(x)


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> List[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def is_type(t: Type[T], x: Any) -> T:
    assert isinstance(x, t)
    return x


class Booster(Enum):
    COMMON = "common"
    RARE = "rare"
    UNCOMMON = "uncommon"


class ColorIdentity(Enum):
    B = "B"
    G = "G"
    R = "R"
    U = "U"
    W = "W"


class Color(Enum):
    BLACK = "Black"
    BLUE = "Blue"
    GREEN = "Green"
    RED = "Red"
    WHITE = "White"


class Layout(Enum):
    NORMAL = "normal"


class Format(Enum):
    BRAWL = "Brawl"
    COMMANDER = "Commander"
    LEGACY = "Legacy"
    MODERN = "Modern"
    STANDARD = "Standard"
    VINTAGE = "Vintage"


class LegalityEnum(Enum):
    BANNED = "Banned"
    LEGAL = "Legal"
    RESTRICTED = "Restricted"


class LegalityElement:
    format: Format
    legality: LegalityEnum

    def __init__(self, format: Format, legality: LegalityEnum) -> None:
        self.format = format
        self.legality = legality

    @staticmethod
    def from_dict(obj: Any) -> 'LegalityElement':
        assert isinstance(obj, dict)
        format = Format(obj.get("format"))
        legality = LegalityEnum(obj.get("legality"))
        return LegalityElement(format, legality)

    def to_dict(self) -> dict:
        result: dict = {}
        result["format"] = to_enum(Format, self.format)
        result["legality"] = to_enum(LegalityEnum, self.legality)
        return result


class Rarity(Enum):
    BASIC_LAND = "Basic Land"
    COMMON = "Common"
    RARE = "Rare"
    UNCOMMON = "Uncommon"


class Ruling:
    date: datetime
    text: str

    def __init__(self, date: datetime, text: str) -> None:
        self.date = date
        self.text = text

    @staticmethod
    def from_dict(obj: Any) -> 'Ruling':
        assert isinstance(obj, dict)
        date = from_datetime(obj.get("date"))
        text = from_str(obj.get("text"))
        return Ruling(date, text)

    def to_dict(self) -> dict:
        result: dict = {}
        result["date"] = self.date.isoformat()
        result["text"] = from_str(self.text)
        return result


class Supertype(Enum):
    BASIC = "Basic"


class TypeElement(Enum):
    ARTIFACT = "Artifact"
    CREATURE = "Creature"
    ENCHANTMENT = "Enchantment"
    INSTANT = "Instant"
    LAND = "Land"
    SORCERY = "Sorcery"


class Card:
    artist: str
    cmc: int
    id: str
    image_name: str
    layout: Layout
    legalities: List[LegalityElement]
    mana_cost: Optional[str]
    mci_number: Optional[int]
    multiverseid: int
    name: str
    original_text: Optional[str]
    original_type: str
    printings: List[str]
    rarity: Rarity
    rulings: Optional[List[Ruling]]
    text: Optional[str]
    type: str
    types: List[TypeElement]
    reserved: Optional[bool]
    power: Optional[str]
    subtypes: Optional[List[str]]
    toughness: Optional[str]
    color_identity: Optional[List[ColorIdentity]]
    flavor: Optional[str]
    colors: Optional[List[Color]]
    supertypes: Optional[List[Supertype]]
    variations: Optional[List[int]]

    def __init__(self, artist: str, cmc: int, id: str, image_name: str, layout: Layout, legalities: List[LegalityElement], mana_cost: Optional[str], mci_number: Optional[int], multiverseid: int, name: str, original_text: Optional[str], original_type: str, printings: List[str], rarity: Rarity, rulings: Optional[List[Ruling]], text: Optional[str], type: str, types: List[TypeElement], reserved: Optional[bool], power: Optional[str], subtypes: Optional[List[str]], toughness: Optional[str], color_identity: Optional[List[ColorIdentity]], flavor: Optional[str], colors: Optional[List[Color]], supertypes: Optional[List[Supertype]], variations: Optional[List[int]]) -> None:
        self.artist = artist
        self.cmc = cmc
        self.id = id
        self.image_name = image_name
        self.layout = layout
        self.legalities = legalities
        self.mana_cost = mana_cost
        self.mci_number = mci_number
        self.multiverseid = multiverseid
        self.name = name
        self.original_text = original_text
        self.original_type = original_type
        self.printings = printings
        self.rarity = rarity
        self.rulings = rulings
        self.text = text
        self.type = type
        self.types = types
        self.reserved = reserved
        self.power = power
        self.subtypes = subtypes
        self.toughness = toughness
        self.color_identity = color_identity
        self.flavor = flavor
        self.colors = colors
        self.supertypes = supertypes
        self.variations = variations

    @staticmethod
    def from_dict(obj: Any) -> 'Card':
        assert isinstance(obj, dict)
        artist = from_str(obj.get("artist"))
        cmc = from_int(obj.get("cmc"))
        id = from_str(obj.get("id"))
        image_name = from_str(obj.get("imageName"))
        layout = Layout(obj.get("layout"))
        legalities = from_list(LegalityElement.from_dict, obj.get("legalities"))
        mana_cost = from_union([from_str, from_none], obj.get("manaCost"))
        mci_number = from_union([from_none, lambda x: int(from_str(x))], obj.get("mciNumber"))
        multiverseid = from_int(obj.get("multiverseid"))
        name = from_str(obj.get("name"))
        original_text = from_union([from_str, from_none], obj.get("originalText"))
        original_type = from_str(obj.get("originalType"))
        printings = from_list(from_str, obj.get("printings"))
        rarity = Rarity(obj.get("rarity"))
        rulings = from_union([lambda x: from_list(Ruling.from_dict, x), from_none], obj.get("rulings"))
        text = from_union([from_str, from_none], obj.get("text"))
        type = from_str(obj.get("type"))
        types = from_list(TypeElement, obj.get("types"))
        reserved = from_union([from_bool, from_none], obj.get("reserved"))
        power = from_union([from_str, from_none], obj.get("power"))
        subtypes = from_union([lambda x: from_list(from_str, x), from_none], obj.get("subtypes"))
        toughness = from_union([from_str, from_none], obj.get("toughness"))
        color_identity = from_union([lambda x: from_list(ColorIdentity, x), from_none], obj.get("colorIdentity"))
        flavor = from_union([from_str, from_none], obj.get("flavor"))
        colors = from_union([lambda x: from_list(Color, x), from_none], obj.get("colors"))
        supertypes = from_union([lambda x: from_list(Supertype, x), from_none], obj.get("supertypes"))
        variations = from_union([lambda x: from_list(from_int, x), from_none], obj.get("variations"))
        return Card(artist, cmc, id, image_name, layout, legalities, mana_cost, mci_number, multiverseid, name, original_text, original_type, printings, rarity, rulings, text, type, types, reserved, power, subtypes, toughness, color_identity, flavor, colors, supertypes, variations)

    def to_dict(self) -> dict:
        result: dict = {}
        result["artist"] = from_str(self.artist)
        result["cmc"] = from_int(self.cmc)
        result["id"] = from_str(self.id)
        result["imageName"] = from_str(self.image_name)
        result["layout"] = to_enum(Layout, self.layout)
        result["legalities"] = from_list(lambda x: to_class(LegalityElement, x), self.legalities)
        result["manaCost"] = from_union([from_str, from_none], self.mana_cost)
        result["mciNumber"] = from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_str((lambda x: str((lambda x: is_type(int, x))(x)))(x))], self.mci_number)
        result["multiverseid"] = from_int(self.multiverseid)
        result["name"] = from_str(self.name)
        result["originalText"] = from_union([from_str, from_none], self.original_text)
        result["originalType"] = from_str(self.original_type)
        result["printings"] = from_list(from_str, self.printings)
        result["rarity"] = to_enum(Rarity, self.rarity)
        result["rulings"] = from_union([lambda x: from_list(lambda x: to_class(Ruling, x), x), from_none], self.rulings)
        result["text"] = from_union([from_str, from_none], self.text)
        result["type"] = from_str(self.type)
        result["types"] = from_list(lambda x: to_enum(TypeElement, x), self.types)
        result["reserved"] = from_union([from_bool, from_none], self.reserved)
        result["power"] = from_union([from_str, from_none], self.power)
        result["subtypes"] = from_union([lambda x: from_list(from_str, x), from_none], self.subtypes)
        result["toughness"] = from_union([from_str, from_none], self.toughness)
        result["colorIdentity"] = from_union([lambda x: from_list(lambda x: to_enum(ColorIdentity, x), x), from_none], self.color_identity)
        result["flavor"] = from_union([from_str, from_none], self.flavor)
        result["colors"] = from_union([lambda x: from_list(lambda x: to_enum(Color, x), x), from_none], self.colors)
        result["supertypes"] = from_union([lambda x: from_list(lambda x: to_enum(Supertype, x), x), from_none], self.supertypes)
        result["variations"] = from_union([lambda x: from_list(from_int, x), from_none], self.variations)
        return result


class LEAExtras:
    name: str
    code: str
    gatherer_code: str
    magic_cards_info_code: str
    release_date: datetime
    border: str
    type: str
    booster: List[Booster]
    mkm_name: str
    mkm_id: int
    cards: List[Card]

    def __init__(self, name: str, code: str, gatherer_code: str, magic_cards_info_code: str, release_date: datetime, border: str, type: str, booster: List[Booster], mkm_name: str, mkm_id: int, cards: List[Card]) -> None:
        self.name = name
        self.code = code
        self.gatherer_code = gatherer_code
        self.magic_cards_info_code = magic_cards_info_code
        self.release_date = release_date
        self.border = border
        self.type = type
        self.booster = booster
        self.mkm_name = mkm_name
        self.mkm_id = mkm_id
        self.cards = cards

    @staticmethod
    def from_dict(obj: Any) -> 'LEAExtras':
        assert isinstance(obj, dict)
        name = from_str(obj.get("name"))
        code = from_str(obj.get("code"))
        gatherer_code = from_str(obj.get("gathererCode"))
        magic_cards_info_code = from_str(obj.get("magicCardsInfoCode"))
        release_date = from_datetime(obj.get("releaseDate"))
        border = from_str(obj.get("border"))
        type = from_str(obj.get("type"))
        booster = from_list(Booster, obj.get("booster"))
        mkm_name = from_str(obj.get("mkm_name"))
        mkm_id = from_int(obj.get("mkm_id"))
        cards = from_list(Card.from_dict, obj.get("cards"))
        return LEAExtras(name, code, gatherer_code, magic_cards_info_code, release_date, border, type, booster, mkm_name, mkm_id, cards)

    def to_dict(self) -> dict:
        result: dict = {}
        result["name"] = from_str(self.name)
        result["code"] = from_str(self.code)
        result["gathererCode"] = from_str(self.gatherer_code)
        result["magicCardsInfoCode"] = from_str(self.magic_cards_info_code)
        result["releaseDate"] = self.release_date.isoformat()
        result["border"] = from_str(self.border)
        result["type"] = from_str(self.type)
        result["booster"] = from_list(lambda x: to_enum(Booster, x), self.booster)
        result["mkm_name"] = from_str(self.mkm_name)
        result["mkm_id"] = from_int(self.mkm_id)
        result["cards"] = from_list(lambda x: to_class(Card, x), self.cards)
        return result


def lea_extras_from_dict(s: Any) -> LEAExtras:
    return LEAExtras.from_dict(s)


def lea_extras_to_dict(x: LEAExtras) -> Any:
    return to_class(LEAExtras, x)
