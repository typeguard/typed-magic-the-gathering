// To parse this JSON data, add NuGet 'Newtonsoft.Json' then do:
//
//    using QuickType;
//
//    var leaExtras = LeaExtras.FromJson(jsonString);

namespace QuickType
{
    using System;
    using System.Collections.Generic;

    using System.Globalization;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Converters;

    public partial class LeaExtras
    {
        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("code")]
        public string Code { get; set; }

        [JsonProperty("gathererCode")]
        public string GathererCode { get; set; }

        [JsonProperty("magicCardsInfoCode")]
        public string MagicCardsInfoCode { get; set; }

        [JsonProperty("releaseDate")]
        public DateTimeOffset ReleaseDate { get; set; }

        [JsonProperty("border")]
        public string Border { get; set; }

        [JsonProperty("type")]
        public string Type { get; set; }

        [JsonProperty("booster")]
        public Booster[] Booster { get; set; }

        [JsonProperty("mkm_name")]
        public string MkmName { get; set; }

        [JsonProperty("mkm_id")]
        public long MkmId { get; set; }

        [JsonProperty("cards")]
        public Card[] Cards { get; set; }
    }

    public partial class Card
    {
        [JsonProperty("artist")]
        public string Artist { get; set; }

        [JsonProperty("cmc")]
        public long Cmc { get; set; }

        [JsonProperty("id")]
        public string Id { get; set; }

        [JsonProperty("imageName")]
        public string ImageName { get; set; }

        [JsonProperty("layout")]
        public Layout Layout { get; set; }

        [JsonProperty("legalities")]
        public LegalityElement[] Legalities { get; set; }

        [JsonProperty("manaCost", NullValueHandling = NullValueHandling.Ignore)]
        public string ManaCost { get; set; }

        [JsonProperty("mciNumber", NullValueHandling = NullValueHandling.Ignore)]
        [JsonConverter(typeof(ParseStringConverter))]
        public long? MciNumber { get; set; }

        [JsonProperty("multiverseid")]
        public long Multiverseid { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("originalText", NullValueHandling = NullValueHandling.Ignore)]
        public string OriginalText { get; set; }

        [JsonProperty("originalType")]
        public string OriginalType { get; set; }

        [JsonProperty("printings")]
        public string[] Printings { get; set; }

        [JsonProperty("rarity")]
        public Rarity Rarity { get; set; }

        [JsonProperty("rulings", NullValueHandling = NullValueHandling.Ignore)]
        public Ruling[] Rulings { get; set; }

        [JsonProperty("text", NullValueHandling = NullValueHandling.Ignore)]
        public string Text { get; set; }

        [JsonProperty("type")]
        public string Type { get; set; }

        [JsonProperty("types")]
        public TypeElement[] Types { get; set; }

        [JsonProperty("reserved", NullValueHandling = NullValueHandling.Ignore)]
        public bool? Reserved { get; set; }

        [JsonProperty("power", NullValueHandling = NullValueHandling.Ignore)]
        public string Power { get; set; }

        [JsonProperty("subtypes", NullValueHandling = NullValueHandling.Ignore)]
        public string[] Subtypes { get; set; }

        [JsonProperty("toughness", NullValueHandling = NullValueHandling.Ignore)]
        public string Toughness { get; set; }

        [JsonProperty("colorIdentity", NullValueHandling = NullValueHandling.Ignore)]
        public ColorIdentity[] ColorIdentity { get; set; }

        [JsonProperty("flavor", NullValueHandling = NullValueHandling.Ignore)]
        public string Flavor { get; set; }

        [JsonProperty("colors", NullValueHandling = NullValueHandling.Ignore)]
        public Color[] Colors { get; set; }

        [JsonProperty("supertypes", NullValueHandling = NullValueHandling.Ignore)]
        public Supertype[] Supertypes { get; set; }

        [JsonProperty("variations", NullValueHandling = NullValueHandling.Ignore)]
        public long[] Variations { get; set; }
    }

    public partial class LegalityElement
    {
        [JsonProperty("format")]
        public Format Format { get; set; }

        [JsonProperty("legality")]
        public LegalityEnum Legality { get; set; }
    }

    public partial class Ruling
    {
        [JsonProperty("date")]
        public DateTimeOffset Date { get; set; }

        [JsonProperty("text")]
        public string Text { get; set; }
    }

    public enum Booster { Common, Rare, Uncommon };

    public enum ColorIdentity { B, G, R, U, W };

    public enum Color { Black, Blue, Green, Red, White };

    public enum Layout { Normal };

    public enum Format { Brawl, Commander, Legacy, Modern, Standard, Vintage };

    public enum LegalityEnum { Banned, Legal, Restricted };

    public enum Rarity { BasicLand, Common, Rare, Uncommon };

    public enum Supertype { Basic };

    public enum TypeElement { Artifact, Creature, Enchantment, Instant, Land, Sorcery };

    public partial class LeaExtras
    {
        public static LeaExtras FromJson(string json) => JsonConvert.DeserializeObject<LeaExtras>(json, QuickType.Converter.Settings);
    }

    public static class Serialize
    {
        public static string ToJson(this LeaExtras self) => JsonConvert.SerializeObject(self, QuickType.Converter.Settings);
    }

    internal static class Converter
    {
        public static readonly JsonSerializerSettings Settings = new JsonSerializerSettings
        {
            MetadataPropertyHandling = MetadataPropertyHandling.Ignore,
            DateParseHandling = DateParseHandling.None,
            Converters = {
                BoosterConverter.Singleton,
                ColorIdentityConverter.Singleton,
                ColorConverter.Singleton,
                LayoutConverter.Singleton,
                FormatConverter.Singleton,
                LegalityEnumConverter.Singleton,
                RarityConverter.Singleton,
                SupertypeConverter.Singleton,
                TypeElementConverter.Singleton,
                new IsoDateTimeConverter { DateTimeStyles = DateTimeStyles.AssumeUniversal }
            },
        };
    }

    internal class BoosterConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(Booster) || t == typeof(Booster?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "common":
                    return Booster.Common;
                case "rare":
                    return Booster.Rare;
                case "uncommon":
                    return Booster.Uncommon;
            }
            throw new Exception("Cannot unmarshal type Booster");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (Booster)untypedValue;
            switch (value)
            {
                case Booster.Common:
                    serializer.Serialize(writer, "common");
                    return;
                case Booster.Rare:
                    serializer.Serialize(writer, "rare");
                    return;
                case Booster.Uncommon:
                    serializer.Serialize(writer, "uncommon");
                    return;
            }
            throw new Exception("Cannot marshal type Booster");
        }

        public static readonly BoosterConverter Singleton = new BoosterConverter();
    }

    internal class ColorIdentityConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(ColorIdentity) || t == typeof(ColorIdentity?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "B":
                    return ColorIdentity.B;
                case "G":
                    return ColorIdentity.G;
                case "R":
                    return ColorIdentity.R;
                case "U":
                    return ColorIdentity.U;
                case "W":
                    return ColorIdentity.W;
            }
            throw new Exception("Cannot unmarshal type ColorIdentity");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (ColorIdentity)untypedValue;
            switch (value)
            {
                case ColorIdentity.B:
                    serializer.Serialize(writer, "B");
                    return;
                case ColorIdentity.G:
                    serializer.Serialize(writer, "G");
                    return;
                case ColorIdentity.R:
                    serializer.Serialize(writer, "R");
                    return;
                case ColorIdentity.U:
                    serializer.Serialize(writer, "U");
                    return;
                case ColorIdentity.W:
                    serializer.Serialize(writer, "W");
                    return;
            }
            throw new Exception("Cannot marshal type ColorIdentity");
        }

        public static readonly ColorIdentityConverter Singleton = new ColorIdentityConverter();
    }

    internal class ColorConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(Color) || t == typeof(Color?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "Black":
                    return Color.Black;
                case "Blue":
                    return Color.Blue;
                case "Green":
                    return Color.Green;
                case "Red":
                    return Color.Red;
                case "White":
                    return Color.White;
            }
            throw new Exception("Cannot unmarshal type Color");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (Color)untypedValue;
            switch (value)
            {
                case Color.Black:
                    serializer.Serialize(writer, "Black");
                    return;
                case Color.Blue:
                    serializer.Serialize(writer, "Blue");
                    return;
                case Color.Green:
                    serializer.Serialize(writer, "Green");
                    return;
                case Color.Red:
                    serializer.Serialize(writer, "Red");
                    return;
                case Color.White:
                    serializer.Serialize(writer, "White");
                    return;
            }
            throw new Exception("Cannot marshal type Color");
        }

        public static readonly ColorConverter Singleton = new ColorConverter();
    }

    internal class LayoutConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(Layout) || t == typeof(Layout?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "normal")
            {
                return Layout.Normal;
            }
            throw new Exception("Cannot unmarshal type Layout");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (Layout)untypedValue;
            if (value == Layout.Normal)
            {
                serializer.Serialize(writer, "normal");
                return;
            }
            throw new Exception("Cannot marshal type Layout");
        }

        public static readonly LayoutConverter Singleton = new LayoutConverter();
    }

    internal class FormatConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(Format) || t == typeof(Format?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "Brawl":
                    return Format.Brawl;
                case "Commander":
                    return Format.Commander;
                case "Legacy":
                    return Format.Legacy;
                case "Modern":
                    return Format.Modern;
                case "Standard":
                    return Format.Standard;
                case "Vintage":
                    return Format.Vintage;
            }
            throw new Exception("Cannot unmarshal type Format");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (Format)untypedValue;
            switch (value)
            {
                case Format.Brawl:
                    serializer.Serialize(writer, "Brawl");
                    return;
                case Format.Commander:
                    serializer.Serialize(writer, "Commander");
                    return;
                case Format.Legacy:
                    serializer.Serialize(writer, "Legacy");
                    return;
                case Format.Modern:
                    serializer.Serialize(writer, "Modern");
                    return;
                case Format.Standard:
                    serializer.Serialize(writer, "Standard");
                    return;
                case Format.Vintage:
                    serializer.Serialize(writer, "Vintage");
                    return;
            }
            throw new Exception("Cannot marshal type Format");
        }

        public static readonly FormatConverter Singleton = new FormatConverter();
    }

    internal class LegalityEnumConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(LegalityEnum) || t == typeof(LegalityEnum?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "Banned":
                    return LegalityEnum.Banned;
                case "Legal":
                    return LegalityEnum.Legal;
                case "Restricted":
                    return LegalityEnum.Restricted;
            }
            throw new Exception("Cannot unmarshal type LegalityEnum");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (LegalityEnum)untypedValue;
            switch (value)
            {
                case LegalityEnum.Banned:
                    serializer.Serialize(writer, "Banned");
                    return;
                case LegalityEnum.Legal:
                    serializer.Serialize(writer, "Legal");
                    return;
                case LegalityEnum.Restricted:
                    serializer.Serialize(writer, "Restricted");
                    return;
            }
            throw new Exception("Cannot marshal type LegalityEnum");
        }

        public static readonly LegalityEnumConverter Singleton = new LegalityEnumConverter();
    }

    internal class ParseStringConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(long) || t == typeof(long?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            long l;
            if (Int64.TryParse(value, out l))
            {
                return l;
            }
            throw new Exception("Cannot unmarshal type long");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (long)untypedValue;
            serializer.Serialize(writer, value.ToString());
            return;
        }

        public static readonly ParseStringConverter Singleton = new ParseStringConverter();
    }

    internal class RarityConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(Rarity) || t == typeof(Rarity?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "Basic Land":
                    return Rarity.BasicLand;
                case "Common":
                    return Rarity.Common;
                case "Rare":
                    return Rarity.Rare;
                case "Uncommon":
                    return Rarity.Uncommon;
            }
            throw new Exception("Cannot unmarshal type Rarity");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (Rarity)untypedValue;
            switch (value)
            {
                case Rarity.BasicLand:
                    serializer.Serialize(writer, "Basic Land");
                    return;
                case Rarity.Common:
                    serializer.Serialize(writer, "Common");
                    return;
                case Rarity.Rare:
                    serializer.Serialize(writer, "Rare");
                    return;
                case Rarity.Uncommon:
                    serializer.Serialize(writer, "Uncommon");
                    return;
            }
            throw new Exception("Cannot marshal type Rarity");
        }

        public static readonly RarityConverter Singleton = new RarityConverter();
    }

    internal class SupertypeConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(Supertype) || t == typeof(Supertype?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            if (value == "Basic")
            {
                return Supertype.Basic;
            }
            throw new Exception("Cannot unmarshal type Supertype");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (Supertype)untypedValue;
            if (value == Supertype.Basic)
            {
                serializer.Serialize(writer, "Basic");
                return;
            }
            throw new Exception("Cannot marshal type Supertype");
        }

        public static readonly SupertypeConverter Singleton = new SupertypeConverter();
    }

    internal class TypeElementConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(TypeElement) || t == typeof(TypeElement?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "Artifact":
                    return TypeElement.Artifact;
                case "Creature":
                    return TypeElement.Creature;
                case "Enchantment":
                    return TypeElement.Enchantment;
                case "Instant":
                    return TypeElement.Instant;
                case "Land":
                    return TypeElement.Land;
                case "Sorcery":
                    return TypeElement.Sorcery;
            }
            throw new Exception("Cannot unmarshal type TypeElement");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (TypeElement)untypedValue;
            switch (value)
            {
                case TypeElement.Artifact:
                    serializer.Serialize(writer, "Artifact");
                    return;
                case TypeElement.Creature:
                    serializer.Serialize(writer, "Creature");
                    return;
                case TypeElement.Enchantment:
                    serializer.Serialize(writer, "Enchantment");
                    return;
                case TypeElement.Instant:
                    serializer.Serialize(writer, "Instant");
                    return;
                case TypeElement.Land:
                    serializer.Serialize(writer, "Land");
                    return;
                case TypeElement.Sorcery:
                    serializer.Serialize(writer, "Sorcery");
                    return;
            }
            throw new Exception("Cannot marshal type TypeElement");
        }

        public static readonly TypeElementConverter Singleton = new TypeElementConverter();
    }
}
