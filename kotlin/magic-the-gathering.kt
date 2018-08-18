// To parse the JSON, install Klaxon and do:
//
//   val lEAExtras = LEAExtras.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private fun <T> Klaxon.convert(k: kotlin.reflect.KClass<*>, fromJson: (JsonValue) -> T, toJson: (T) -> String, isUnion: Boolean = false) =
    this.converter(object: Converter {
        @Suppress("UNCHECKED_CAST")
        override fun toJson(value: Any)        = toJson(value as T)
        override fun fromJson(jv: JsonValue)   = fromJson(jv) as Any
        override fun canConvert(cls: Class<*>) = cls == k.java || (isUnion && cls.superclass == k.java)
    })

private val klaxon = Klaxon()
    .convert(Booster::class,       { Booster.fromValue(it.string!!) },       { "\"${it.value}\"" })
    .convert(ColorIdentity::class, { ColorIdentity.fromValue(it.string!!) }, { "\"${it.value}\"" })
    .convert(Color::class,         { Color.fromValue(it.string!!) },         { "\"${it.value}\"" })
    .convert(Layout::class,        { Layout.fromValue(it.string!!) },        { "\"${it.value}\"" })
    .convert(Format::class,        { Format.fromValue(it.string!!) },        { "\"${it.value}\"" })
    .convert(LegalityEnum::class,  { LegalityEnum.fromValue(it.string!!) },  { "\"${it.value}\"" })
    .convert(Rarity::class,        { Rarity.fromValue(it.string!!) },        { "\"${it.value}\"" })
    .convert(Supertype::class,     { Supertype.fromValue(it.string!!) },     { "\"${it.value}\"" })
    .convert(Type::class,          { Type.fromValue(it.string!!) },          { "\"${it.value}\"" })

data class LEAExtras (
    val name: String,
    val code: String,
    val gathererCode: String,
    val magicCardsInfoCode: String,
    val releaseDate: String,
    val border: String,
    val type: String,
    val booster: List<Booster>,

    @Json(name = "mkm_name")
    val mkmName: String,

    @Json(name = "mkm_id")
    val mkmID: Long,

    val cards: List<Card>
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<LEAExtras>(json)
    }
}

enum class Booster(val value: String) {
    Common("common"),
    Rare("rare"),
    Uncommon("uncommon");

    companion object {
        public fun fromValue(value: String): Booster = when (value) {
            "common"   -> Common
            "rare"     -> Rare
            "uncommon" -> Uncommon
            else       -> throw IllegalArgumentException()
        }
    }
}

data class Card (
    val artist: String,
    val cmc: Long,
    val id: String,
    val imageName: String,
    val layout: Layout,
    val legalities: List<LegalityElement>,
    val manaCost: String? = null,
    val mciNumber: String? = null,
    val multiverseid: Long,
    val name: String,
    val originalText: String? = null,
    val originalType: String,
    val printings: List<String>,
    val rarity: Rarity,
    val rulings: List<Ruling>? = null,
    val text: String? = null,
    val type: String,
    val types: List<Type>,
    val reserved: Boolean? = null,
    val power: String? = null,
    val subtypes: List<String>? = null,
    val toughness: String? = null,
    val colorIdentity: List<ColorIdentity>? = null,
    val flavor: String? = null,
    val colors: List<Color>? = null,
    val supertypes: List<Supertype>? = null,
    val variations: List<Long>? = null
)

enum class ColorIdentity(val value: String) {
    B("B"),
    G("G"),
    R("R"),
    U("U"),
    W("W");

    companion object {
        public fun fromValue(value: String): ColorIdentity = when (value) {
            "B"  -> B
            "G"  -> G
            "R"  -> R
            "U"  -> U
            "W"  -> W
            else -> throw IllegalArgumentException()
        }
    }
}

enum class Color(val value: String) {
    Black("Black"),
    Blue("Blue"),
    Green("Green"),
    Red("Red"),
    White("White");

    companion object {
        public fun fromValue(value: String): Color = when (value) {
            "Black" -> Black
            "Blue"  -> Blue
            "Green" -> Green
            "Red"   -> Red
            "White" -> White
            else    -> throw IllegalArgumentException()
        }
    }
}

enum class Layout(val value: String) {
    Normal("normal");

    companion object {
        public fun fromValue(value: String): Layout = when (value) {
            "normal" -> Normal
            else     -> throw IllegalArgumentException()
        }
    }
}

data class LegalityElement (
    val format: Format,
    val legality: LegalityEnum
)

enum class Format(val value: String) {
    Brawl("Brawl"),
    Commander("Commander"),
    Legacy("Legacy"),
    Modern("Modern"),
    Standard("Standard"),
    Vintage("Vintage");

    companion object {
        public fun fromValue(value: String): Format = when (value) {
            "Brawl"     -> Brawl
            "Commander" -> Commander
            "Legacy"    -> Legacy
            "Modern"    -> Modern
            "Standard"  -> Standard
            "Vintage"   -> Vintage
            else        -> throw IllegalArgumentException()
        }
    }
}

enum class LegalityEnum(val value: String) {
    Banned("Banned"),
    Legal("Legal"),
    Restricted("Restricted");

    companion object {
        public fun fromValue(value: String): LegalityEnum = when (value) {
            "Banned"     -> Banned
            "Legal"      -> Legal
            "Restricted" -> Restricted
            else         -> throw IllegalArgumentException()
        }
    }
}

enum class Rarity(val value: String) {
    BasicLand("Basic Land"),
    Common("Common"),
    Rare("Rare"),
    Uncommon("Uncommon");

    companion object {
        public fun fromValue(value: String): Rarity = when (value) {
            "Basic Land" -> BasicLand
            "Common"     -> Common
            "Rare"       -> Rare
            "Uncommon"   -> Uncommon
            else         -> throw IllegalArgumentException()
        }
    }
}

data class Ruling (
    val date: String,
    val text: String
)

enum class Supertype(val value: String) {
    Basic("Basic");

    companion object {
        public fun fromValue(value: String): Supertype = when (value) {
            "Basic" -> Basic
            else    -> throw IllegalArgumentException()
        }
    }
}

enum class Type(val value: String) {
    Artifact("Artifact"),
    Creature("Creature"),
    Enchantment("Enchantment"),
    Instant("Instant"),
    Land("Land"),
    Sorcery("Sorcery");

    companion object {
        public fun fromValue(value: String): Type = when (value) {
            "Artifact"    -> Artifact
            "Creature"    -> Creature
            "Enchantment" -> Enchantment
            "Instant"     -> Instant
            "Land"        -> Land
            "Sorcery"     -> Sorcery
            else          -> throw IllegalArgumentException()
        }
    }
}
