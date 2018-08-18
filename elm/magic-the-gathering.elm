-- To decode the JSON data, add this file to your project, run
--
--     elm-package install NoRedInk/elm-decode-pipeline
--
-- add these imports
--
--     import Json.Decode exposing (decodeString)`);
--     import QuickType exposing (leaExtras)
--
-- and you're off to the races with
--
--     decodeString leaExtras myJsonString

module QuickType exposing
    ( LEAExtras
    , leaExtrasToString
    , leaExtras
    , Card
    , LegalityElement
    , Ruling
    , Booster(..)
    , ColorIdentity(..)
    , Color(..)
    , Layout(..)
    , Format(..)
    , LegalityEnum(..)
    , Rarity(..)
    , Supertype(..)
    , Type(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict, map, toList)
import Array exposing (Array, map)

type alias LEAExtras =
    { name : String
    , code : String
    , gathererCode : String
    , magicCardsInfoCode : String
    , releaseDate : String
    , border : String
    , leaExtrasType : String
    , booster : Array Booster
    , mkmName : String
    , mkmID : Int
    , cards : Array Card
    }

type Booster
    = Common
    | Rare
    | Uncommon

type alias Card =
    { artist : String
    , cmc : Int
    , id : String
    , imageName : String
    , layout : Layout
    , legalities : Array LegalityElement
    , manaCost : Maybe String
    , mciNumber : Maybe String
    , multiverseid : Int
    , name : String
    , originalText : Maybe String
    , originalType : String
    , printings : Array String
    , rarity : Rarity
    , rulings : Maybe (Array Ruling)
    , text : Maybe String
    , cardType : String
    , types : Array Type
    , reserved : Maybe Bool
    , power : Maybe String
    , subtypes : Maybe (Array String)
    , toughness : Maybe String
    , colorIdentity : Maybe (Array ColorIdentity)
    , flavor : Maybe String
    , colors : Maybe (Array Color)
    , supertypes : Maybe (Array Supertype)
    , variations : Maybe (Array Int)
    }

type ColorIdentity
    = B
    | G
    | R
    | U
    | W

type Color
    = Black
    | Blue
    | Green
    | Red
    | White

type Layout
    = Normal

type alias LegalityElement =
    { format : Format
    , legality : LegalityEnum
    }

type Format
    = Brawl
    | Commander
    | Legacy
    | Modern
    | Standard
    | Vintage

type LegalityEnum
    = Banned
    | Legal
    | Restricted

type Rarity
    = BasicLand
    | RarityCommon
    | RarityRare
    | RarityUncommon

type alias Ruling =
    { date : String
    , text : String
    }

type Supertype
    = Basic

type Type
    = Artifact
    | Creature
    | Enchantment
    | Instant
    | Land
    | Sorcery

-- decoders and encoders

leaExtrasToString : LEAExtras -> String
leaExtrasToString r = Jenc.encode 0 (encodeLEAExtras r)

leaExtras : Jdec.Decoder LEAExtras
leaExtras =
    Jpipe.decode LEAExtras
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "code" Jdec.string
        |> Jpipe.required "gathererCode" Jdec.string
        |> Jpipe.required "magicCardsInfoCode" Jdec.string
        |> Jpipe.required "releaseDate" Jdec.string
        |> Jpipe.required "border" Jdec.string
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "booster" (Jdec.array booster)
        |> Jpipe.required "mkm_name" Jdec.string
        |> Jpipe.required "mkm_id" Jdec.int
        |> Jpipe.required "cards" (Jdec.array card)

encodeLEAExtras : LEAExtras -> Jenc.Value
encodeLEAExtras x =
    Jenc.object
        [ ("name", Jenc.string x.name)
        , ("code", Jenc.string x.code)
        , ("gathererCode", Jenc.string x.gathererCode)
        , ("magicCardsInfoCode", Jenc.string x.magicCardsInfoCode)
        , ("releaseDate", Jenc.string x.releaseDate)
        , ("border", Jenc.string x.border)
        , ("type", Jenc.string x.leaExtrasType)
        , ("booster", makeArrayEncoder encodeBooster x.booster)
        , ("mkm_name", Jenc.string x.mkmName)
        , ("mkm_id", Jenc.int x.mkmID)
        , ("cards", makeArrayEncoder encodeCard x.cards)
        ]

booster : Jdec.Decoder Booster
booster =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "common" -> Jdec.succeed Common
                "rare" -> Jdec.succeed Rare
                "uncommon" -> Jdec.succeed Uncommon
                somethingElse -> Jdec.fail <| "Invalid Booster: " ++ somethingElse
        )

encodeBooster : Booster -> Jenc.Value
encodeBooster x = case x of
    Common -> Jenc.string "common"
    Rare -> Jenc.string "rare"
    Uncommon -> Jenc.string "uncommon"

card : Jdec.Decoder Card
card =
    Jpipe.decode Card
        |> Jpipe.required "artist" Jdec.string
        |> Jpipe.required "cmc" Jdec.int
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "imageName" Jdec.string
        |> Jpipe.required "layout" layout
        |> Jpipe.required "legalities" (Jdec.array legalityElement)
        |> Jpipe.optional "manaCost" (Jdec.nullable Jdec.string) Nothing
        |> Jpipe.optional "mciNumber" (Jdec.nullable Jdec.string) Nothing
        |> Jpipe.required "multiverseid" Jdec.int
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.optional "originalText" (Jdec.nullable Jdec.string) Nothing
        |> Jpipe.required "originalType" Jdec.string
        |> Jpipe.required "printings" (Jdec.array Jdec.string)
        |> Jpipe.required "rarity" rarity
        |> Jpipe.optional "rulings" (Jdec.nullable (Jdec.array ruling)) Nothing
        |> Jpipe.optional "text" (Jdec.nullable Jdec.string) Nothing
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "types" (Jdec.array purpleType)
        |> Jpipe.optional "reserved" (Jdec.nullable Jdec.bool) Nothing
        |> Jpipe.optional "power" (Jdec.nullable Jdec.string) Nothing
        |> Jpipe.optional "subtypes" (Jdec.nullable (Jdec.array Jdec.string)) Nothing
        |> Jpipe.optional "toughness" (Jdec.nullable Jdec.string) Nothing
        |> Jpipe.optional "colorIdentity" (Jdec.nullable (Jdec.array colorIdentity)) Nothing
        |> Jpipe.optional "flavor" (Jdec.nullable Jdec.string) Nothing
        |> Jpipe.optional "colors" (Jdec.nullable (Jdec.array color)) Nothing
        |> Jpipe.optional "supertypes" (Jdec.nullable (Jdec.array supertype)) Nothing
        |> Jpipe.optional "variations" (Jdec.nullable (Jdec.array Jdec.int)) Nothing

encodeCard : Card -> Jenc.Value
encodeCard x =
    Jenc.object
        [ ("artist", Jenc.string x.artist)
        , ("cmc", Jenc.int x.cmc)
        , ("id", Jenc.string x.id)
        , ("imageName", Jenc.string x.imageName)
        , ("layout", encodeLayout x.layout)
        , ("legalities", makeArrayEncoder encodeLegalityElement x.legalities)
        , ("manaCost", makeNullableEncoder Jenc.string x.manaCost)
        , ("mciNumber", makeNullableEncoder Jenc.string x.mciNumber)
        , ("multiverseid", Jenc.int x.multiverseid)
        , ("name", Jenc.string x.name)
        , ("originalText", makeNullableEncoder Jenc.string x.originalText)
        , ("originalType", Jenc.string x.originalType)
        , ("printings", makeArrayEncoder Jenc.string x.printings)
        , ("rarity", encodeRarity x.rarity)
        , ("rulings", makeNullableEncoder (makeArrayEncoder encodeRuling) x.rulings)
        , ("text", makeNullableEncoder Jenc.string x.text)
        , ("type", Jenc.string x.cardType)
        , ("types", makeArrayEncoder encodeType x.types)
        , ("reserved", makeNullableEncoder Jenc.bool x.reserved)
        , ("power", makeNullableEncoder Jenc.string x.power)
        , ("subtypes", makeNullableEncoder (makeArrayEncoder Jenc.string) x.subtypes)
        , ("toughness", makeNullableEncoder Jenc.string x.toughness)
        , ("colorIdentity", makeNullableEncoder (makeArrayEncoder encodeColorIdentity) x.colorIdentity)
        , ("flavor", makeNullableEncoder Jenc.string x.flavor)
        , ("colors", makeNullableEncoder (makeArrayEncoder encodeColor) x.colors)
        , ("supertypes", makeNullableEncoder (makeArrayEncoder encodeSupertype) x.supertypes)
        , ("variations", makeNullableEncoder (makeArrayEncoder Jenc.int) x.variations)
        ]

colorIdentity : Jdec.Decoder ColorIdentity
colorIdentity =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "B" -> Jdec.succeed B
                "G" -> Jdec.succeed G
                "R" -> Jdec.succeed R
                "U" -> Jdec.succeed U
                "W" -> Jdec.succeed W
                somethingElse -> Jdec.fail <| "Invalid ColorIdentity: " ++ somethingElse
        )

encodeColorIdentity : ColorIdentity -> Jenc.Value
encodeColorIdentity x = case x of
    B -> Jenc.string "B"
    G -> Jenc.string "G"
    R -> Jenc.string "R"
    U -> Jenc.string "U"
    W -> Jenc.string "W"

color : Jdec.Decoder Color
color =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Black" -> Jdec.succeed Black
                "Blue" -> Jdec.succeed Blue
                "Green" -> Jdec.succeed Green
                "Red" -> Jdec.succeed Red
                "White" -> Jdec.succeed White
                somethingElse -> Jdec.fail <| "Invalid Color: " ++ somethingElse
        )

encodeColor : Color -> Jenc.Value
encodeColor x = case x of
    Black -> Jenc.string "Black"
    Blue -> Jenc.string "Blue"
    Green -> Jenc.string "Green"
    Red -> Jenc.string "Red"
    White -> Jenc.string "White"

layout : Jdec.Decoder Layout
layout =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "normal" -> Jdec.succeed Normal
                somethingElse -> Jdec.fail <| "Invalid Layout: " ++ somethingElse
        )

encodeLayout : Layout -> Jenc.Value
encodeLayout x = case x of
    Normal -> Jenc.string "normal"

legalityElement : Jdec.Decoder LegalityElement
legalityElement =
    Jpipe.decode LegalityElement
        |> Jpipe.required "format" format
        |> Jpipe.required "legality" legalityEnum

encodeLegalityElement : LegalityElement -> Jenc.Value
encodeLegalityElement x =
    Jenc.object
        [ ("format", encodeFormat x.format)
        , ("legality", encodeLegalityEnum x.legality)
        ]

format : Jdec.Decoder Format
format =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Brawl" -> Jdec.succeed Brawl
                "Commander" -> Jdec.succeed Commander
                "Legacy" -> Jdec.succeed Legacy
                "Modern" -> Jdec.succeed Modern
                "Standard" -> Jdec.succeed Standard
                "Vintage" -> Jdec.succeed Vintage
                somethingElse -> Jdec.fail <| "Invalid Format: " ++ somethingElse
        )

encodeFormat : Format -> Jenc.Value
encodeFormat x = case x of
    Brawl -> Jenc.string "Brawl"
    Commander -> Jenc.string "Commander"
    Legacy -> Jenc.string "Legacy"
    Modern -> Jenc.string "Modern"
    Standard -> Jenc.string "Standard"
    Vintage -> Jenc.string "Vintage"

legalityEnum : Jdec.Decoder LegalityEnum
legalityEnum =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Banned" -> Jdec.succeed Banned
                "Legal" -> Jdec.succeed Legal
                "Restricted" -> Jdec.succeed Restricted
                somethingElse -> Jdec.fail <| "Invalid LegalityEnum: " ++ somethingElse
        )

encodeLegalityEnum : LegalityEnum -> Jenc.Value
encodeLegalityEnum x = case x of
    Banned -> Jenc.string "Banned"
    Legal -> Jenc.string "Legal"
    Restricted -> Jenc.string "Restricted"

rarity : Jdec.Decoder Rarity
rarity =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Basic Land" -> Jdec.succeed BasicLand
                "Common" -> Jdec.succeed RarityCommon
                "Rare" -> Jdec.succeed RarityRare
                "Uncommon" -> Jdec.succeed RarityUncommon
                somethingElse -> Jdec.fail <| "Invalid Rarity: " ++ somethingElse
        )

encodeRarity : Rarity -> Jenc.Value
encodeRarity x = case x of
    BasicLand -> Jenc.string "Basic Land"
    RarityCommon -> Jenc.string "Common"
    RarityRare -> Jenc.string "Rare"
    RarityUncommon -> Jenc.string "Uncommon"

ruling : Jdec.Decoder Ruling
ruling =
    Jpipe.decode Ruling
        |> Jpipe.required "date" Jdec.string
        |> Jpipe.required "text" Jdec.string

encodeRuling : Ruling -> Jenc.Value
encodeRuling x =
    Jenc.object
        [ ("date", Jenc.string x.date)
        , ("text", Jenc.string x.text)
        ]

supertype : Jdec.Decoder Supertype
supertype =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Basic" -> Jdec.succeed Basic
                somethingElse -> Jdec.fail <| "Invalid Supertype: " ++ somethingElse
        )

encodeSupertype : Supertype -> Jenc.Value
encodeSupertype x = case x of
    Basic -> Jenc.string "Basic"

purpleType : Jdec.Decoder Type
purpleType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Artifact" -> Jdec.succeed Artifact
                "Creature" -> Jdec.succeed Creature
                "Enchantment" -> Jdec.succeed Enchantment
                "Instant" -> Jdec.succeed Instant
                "Land" -> Jdec.succeed Land
                "Sorcery" -> Jdec.succeed Sorcery
                somethingElse -> Jdec.fail <| "Invalid Type: " ++ somethingElse
        )

encodeType : Type -> Jenc.Value
encodeType x = case x of
    Artifact -> Jenc.string "Artifact"
    Creature -> Jenc.string "Creature"
    Enchantment -> Jenc.string "Enchantment"
    Instant -> Jenc.string "Instant"
    Land -> Jenc.string "Land"
    Sorcery -> Jenc.string "Sorcery"

--- encoder helpers

makeArrayEncoder : (a -> Jenc.Value) -> Array a -> Jenc.Value
makeArrayEncoder f arr =
    Jenc.array (Array.map f arr)

makeDictEncoder : (a -> Jenc.Value) -> Dict String a -> Jenc.Value
makeDictEncoder f dict =
    Jenc.object (toList (Dict.map (\k -> f) dict))

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
