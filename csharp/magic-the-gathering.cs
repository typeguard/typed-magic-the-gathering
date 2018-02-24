// To parse this JSON data, add NuGet 'Newtonsoft.Json' then do:
//
//    using QuickType;
//
//    var leaExtras = LeaExtras.FromJson(jsonString);

namespace QuickType
{
    using System;
    using System.Collections.Generic;
    using System.Net;

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
        public System.DateTimeOffset ReleaseDate { get; set; }

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

        [JsonProperty("manaCost")]
        public string ManaCost { get; set; }

        [JsonProperty("mciNumber")]
        public string MciNumber { get; set; }

        [JsonProperty("multiverseid")]
        public long Multiverseid { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("originalText")]
        public string OriginalText { get; set; }

        [JsonProperty("originalType")]
        public string OriginalType { get; set; }

        [JsonProperty("printings")]
        public string[] Printings { get; set; }

        [JsonProperty("rarity")]
        public Rarity Rarity { get; set; }

        [JsonProperty("rulings")]
        public Ruling[] Rulings { get; set; }

        [JsonProperty("text")]
        public string Text { get; set; }

        [JsonProperty("type")]
        public string Type { get; set; }

        [JsonProperty("types")]
        public TypeElement[] Types { get; set; }

        [JsonProperty("reserved")]
        public bool? Reserved { get; set; }

        [JsonProperty("power")]
        public string Power { get; set; }

        [JsonProperty("subtypes")]
        public string[] Subtypes { get; set; }

        [JsonProperty("toughness")]
        public string Toughness { get; set; }

        [JsonProperty("colorIdentity")]
        public ColorIdentity[] ColorIdentity { get; set; }

        [JsonProperty("flavor")]
        public string Flavor { get; set; }

        [JsonProperty("colors")]
        public Color[] Colors { get; set; }

        [JsonProperty("supertypes")]
        public Supertype[] Supertypes { get; set; }

        [JsonProperty("variations")]
        public long[] Variations { get; set; }
    }

    public partial class LegalityElement
    {
        [JsonProperty("format")]
        public Format Format { get; set; }

        [JsonProperty("legality")]
        public LegalityLegality Legality { get; set; }
    }

    public partial class Ruling
    {
        [JsonProperty("date")]
        public System.DateTimeOffset Date { get; set; }

        [JsonProperty("text")]
        public string Text { get; set; }
    }

    public enum Booster { Common, Rare, Uncommon };

    public enum ColorIdentity { B, G, R, U, W };

    public enum Color { Black, Blue, Green, Red, White };

    public enum Layout { Normal };

    public enum Format { AmonkhetBlock, BattleForZendikarBlock, Commander, IceAgeBlock, InnistradBlock, InvasionBlock, IxalanBlock, KaladeshBlock, KamigawaBlock, KhansOfTarkirBlock, Legacy, LorwynShadowmoorBlock, MasquesBlock, MirageBlock, MirrodinBlock, Modern, OdysseyBlock, OnslaughtBlock, RavnicaBlock, ReturnToRavnicaBlock, ScarsOfMirrodinBlock, ShadowsOverInnistradBlock, ShardsOfAlaraBlock, Standard, TempestBlock, TherosBlock, TimeSpiralBlock, UnSets, UrzaBlock, Vintage, ZendikarBlock };

    public enum LegalityLegality { Banned, Legal, Restricted };

    public enum Rarity { BasicLand, Common, Rare, Uncommon };

    public enum Supertype { Basic };

    public enum TypeElement { Artifact, Creature, Enchantment, Instant, Land, Sorcery };

    public partial class LeaExtras
    {
        public static LeaExtras FromJson(string json) => JsonConvert.DeserializeObject<LeaExtras>(json, QuickType.Converter.Settings);
    }

    static class BoosterExtensions
    {
        public static Booster? ValueForString(string str)
        {
            switch (str)
            {
                case "common": return Booster.Common;
                case "rare": return Booster.Rare;
                case "uncommon": return Booster.Uncommon;
                default: return null;
            }
        }

        public static Booster ReadJson(JsonReader reader, JsonSerializer serializer)
        {
            var str = serializer.Deserialize<string>(reader);
            var maybeValue = ValueForString(str);
            if (maybeValue.HasValue) return maybeValue.Value;
            throw new Exception("Unknown enum case " + str);
        }

        public static void WriteJson(this Booster value, JsonWriter writer, JsonSerializer serializer)
        {
            switch (value)
            {
                case Booster.Common: serializer.Serialize(writer, "common"); break;
                case Booster.Rare: serializer.Serialize(writer, "rare"); break;
                case Booster.Uncommon: serializer.Serialize(writer, "uncommon"); break;
            }
        }
    }

    static class ColorIdentityExtensions
    {
        public static ColorIdentity? ValueForString(string str)
        {
            switch (str)
            {
                case "B": return ColorIdentity.B;
                case "G": return ColorIdentity.G;
                case "R": return ColorIdentity.R;
                case "U": return ColorIdentity.U;
                case "W": return ColorIdentity.W;
                default: return null;
            }
        }

        public static ColorIdentity ReadJson(JsonReader reader, JsonSerializer serializer)
        {
            var str = serializer.Deserialize<string>(reader);
            var maybeValue = ValueForString(str);
            if (maybeValue.HasValue) return maybeValue.Value;
            throw new Exception("Unknown enum case " + str);
        }

        public static void WriteJson(this ColorIdentity value, JsonWriter writer, JsonSerializer serializer)
        {
            switch (value)
            {
                case ColorIdentity.B: serializer.Serialize(writer, "B"); break;
                case ColorIdentity.G: serializer.Serialize(writer, "G"); break;
                case ColorIdentity.R: serializer.Serialize(writer, "R"); break;
                case ColorIdentity.U: serializer.Serialize(writer, "U"); break;
                case ColorIdentity.W: serializer.Serialize(writer, "W"); break;
            }
        }
    }

    static class ColorExtensions
    {
        public static Color? ValueForString(string str)
        {
            switch (str)
            {
                case "Black": return Color.Black;
                case "Blue": return Color.Blue;
                case "Green": return Color.Green;
                case "Red": return Color.Red;
                case "White": return Color.White;
                default: return null;
            }
        }

        public static Color ReadJson(JsonReader reader, JsonSerializer serializer)
        {
            var str = serializer.Deserialize<string>(reader);
            var maybeValue = ValueForString(str);
            if (maybeValue.HasValue) return maybeValue.Value;
            throw new Exception("Unknown enum case " + str);
        }

        public static void WriteJson(this Color value, JsonWriter writer, JsonSerializer serializer)
        {
            switch (value)
            {
                case Color.Black: serializer.Serialize(writer, "Black"); break;
                case Color.Blue: serializer.Serialize(writer, "Blue"); break;
                case Color.Green: serializer.Serialize(writer, "Green"); break;
                case Color.Red: serializer.Serialize(writer, "Red"); break;
                case Color.White: serializer.Serialize(writer, "White"); break;
            }
        }
    }

    static class LayoutExtensions
    {
        public static Layout? ValueForString(string str)
        {
            switch (str)
            {
                case "normal": return Layout.Normal;
                default: return null;
            }
        }

        public static Layout ReadJson(JsonReader reader, JsonSerializer serializer)
        {
            var str = serializer.Deserialize<string>(reader);
            var maybeValue = ValueForString(str);
            if (maybeValue.HasValue) return maybeValue.Value;
            throw new Exception("Unknown enum case " + str);
        }

        public static void WriteJson(this Layout value, JsonWriter writer, JsonSerializer serializer)
        {
            switch (value)
            {
                case Layout.Normal: serializer.Serialize(writer, "normal"); break;
            }
        }
    }

    static class FormatExtensions
    {
        public static Format? ValueForString(string str)
        {
            switch (str)
            {
                case "Amonkhet Block": return Format.AmonkhetBlock;
                case "Battle for Zendikar Block": return Format.BattleForZendikarBlock;
                case "Commander": return Format.Commander;
                case "Ice Age Block": return Format.IceAgeBlock;
                case "Innistrad Block": return Format.InnistradBlock;
                case "Invasion Block": return Format.InvasionBlock;
                case "Ixalan Block": return Format.IxalanBlock;
                case "Kaladesh Block": return Format.KaladeshBlock;
                case "Kamigawa Block": return Format.KamigawaBlock;
                case "Khans of Tarkir Block": return Format.KhansOfTarkirBlock;
                case "Legacy": return Format.Legacy;
                case "Lorwyn-Shadowmoor Block": return Format.LorwynShadowmoorBlock;
                case "Masques Block": return Format.MasquesBlock;
                case "Mirage Block": return Format.MirageBlock;
                case "Mirrodin Block": return Format.MirrodinBlock;
                case "Modern": return Format.Modern;
                case "Odyssey Block": return Format.OdysseyBlock;
                case "Onslaught Block": return Format.OnslaughtBlock;
                case "Ravnica Block": return Format.RavnicaBlock;
                case "Return to Ravnica Block": return Format.ReturnToRavnicaBlock;
                case "Scars of Mirrodin Block": return Format.ScarsOfMirrodinBlock;
                case "Shadows over Innistrad Block": return Format.ShadowsOverInnistradBlock;
                case "Shards of Alara Block": return Format.ShardsOfAlaraBlock;
                case "Standard": return Format.Standard;
                case "Tempest Block": return Format.TempestBlock;
                case "Theros Block": return Format.TherosBlock;
                case "Time Spiral Block": return Format.TimeSpiralBlock;
                case "Un-Sets": return Format.UnSets;
                case "Urza Block": return Format.UrzaBlock;
                case "Vintage": return Format.Vintage;
                case "Zendikar Block": return Format.ZendikarBlock;
                default: return null;
            }
        }

        public static Format ReadJson(JsonReader reader, JsonSerializer serializer)
        {
            var str = serializer.Deserialize<string>(reader);
            var maybeValue = ValueForString(str);
            if (maybeValue.HasValue) return maybeValue.Value;
            throw new Exception("Unknown enum case " + str);
        }

        public static void WriteJson(this Format value, JsonWriter writer, JsonSerializer serializer)
        {
            switch (value)
            {
                case Format.AmonkhetBlock: serializer.Serialize(writer, "Amonkhet Block"); break;
                case Format.BattleForZendikarBlock: serializer.Serialize(writer, "Battle for Zendikar Block"); break;
                case Format.Commander: serializer.Serialize(writer, "Commander"); break;
                case Format.IceAgeBlock: serializer.Serialize(writer, "Ice Age Block"); break;
                case Format.InnistradBlock: serializer.Serialize(writer, "Innistrad Block"); break;
                case Format.InvasionBlock: serializer.Serialize(writer, "Invasion Block"); break;
                case Format.IxalanBlock: serializer.Serialize(writer, "Ixalan Block"); break;
                case Format.KaladeshBlock: serializer.Serialize(writer, "Kaladesh Block"); break;
                case Format.KamigawaBlock: serializer.Serialize(writer, "Kamigawa Block"); break;
                case Format.KhansOfTarkirBlock: serializer.Serialize(writer, "Khans of Tarkir Block"); break;
                case Format.Legacy: serializer.Serialize(writer, "Legacy"); break;
                case Format.LorwynShadowmoorBlock: serializer.Serialize(writer, "Lorwyn-Shadowmoor Block"); break;
                case Format.MasquesBlock: serializer.Serialize(writer, "Masques Block"); break;
                case Format.MirageBlock: serializer.Serialize(writer, "Mirage Block"); break;
                case Format.MirrodinBlock: serializer.Serialize(writer, "Mirrodin Block"); break;
                case Format.Modern: serializer.Serialize(writer, "Modern"); break;
                case Format.OdysseyBlock: serializer.Serialize(writer, "Odyssey Block"); break;
                case Format.OnslaughtBlock: serializer.Serialize(writer, "Onslaught Block"); break;
                case Format.RavnicaBlock: serializer.Serialize(writer, "Ravnica Block"); break;
                case Format.ReturnToRavnicaBlock: serializer.Serialize(writer, "Return to Ravnica Block"); break;
                case Format.ScarsOfMirrodinBlock: serializer.Serialize(writer, "Scars of Mirrodin Block"); break;
                case Format.ShadowsOverInnistradBlock: serializer.Serialize(writer, "Shadows over Innistrad Block"); break;
                case Format.ShardsOfAlaraBlock: serializer.Serialize(writer, "Shards of Alara Block"); break;
                case Format.Standard: serializer.Serialize(writer, "Standard"); break;
                case Format.TempestBlock: serializer.Serialize(writer, "Tempest Block"); break;
                case Format.TherosBlock: serializer.Serialize(writer, "Theros Block"); break;
                case Format.TimeSpiralBlock: serializer.Serialize(writer, "Time Spiral Block"); break;
                case Format.UnSets: serializer.Serialize(writer, "Un-Sets"); break;
                case Format.UrzaBlock: serializer.Serialize(writer, "Urza Block"); break;
                case Format.Vintage: serializer.Serialize(writer, "Vintage"); break;
                case Format.ZendikarBlock: serializer.Serialize(writer, "Zendikar Block"); break;
            }
        }
    }

    static class LegalityLegalityExtensions
    {
        public static LegalityLegality? ValueForString(string str)
        {
            switch (str)
            {
                case "Banned": return LegalityLegality.Banned;
                case "Legal": return LegalityLegality.Legal;
                case "Restricted": return LegalityLegality.Restricted;
                default: return null;
            }
        }

        public static LegalityLegality ReadJson(JsonReader reader, JsonSerializer serializer)
        {
            var str = serializer.Deserialize<string>(reader);
            var maybeValue = ValueForString(str);
            if (maybeValue.HasValue) return maybeValue.Value;
            throw new Exception("Unknown enum case " + str);
        }

        public static void WriteJson(this LegalityLegality value, JsonWriter writer, JsonSerializer serializer)
        {
            switch (value)
            {
                case LegalityLegality.Banned: serializer.Serialize(writer, "Banned"); break;
                case LegalityLegality.Legal: serializer.Serialize(writer, "Legal"); break;
                case LegalityLegality.Restricted: serializer.Serialize(writer, "Restricted"); break;
            }
        }
    }

    static class RarityExtensions
    {
        public static Rarity? ValueForString(string str)
        {
            switch (str)
            {
                case "Basic Land": return Rarity.BasicLand;
                case "Common": return Rarity.Common;
                case "Rare": return Rarity.Rare;
                case "Uncommon": return Rarity.Uncommon;
                default: return null;
            }
        }

        public static Rarity ReadJson(JsonReader reader, JsonSerializer serializer)
        {
            var str = serializer.Deserialize<string>(reader);
            var maybeValue = ValueForString(str);
            if (maybeValue.HasValue) return maybeValue.Value;
            throw new Exception("Unknown enum case " + str);
        }

        public static void WriteJson(this Rarity value, JsonWriter writer, JsonSerializer serializer)
        {
            switch (value)
            {
                case Rarity.BasicLand: serializer.Serialize(writer, "Basic Land"); break;
                case Rarity.Common: serializer.Serialize(writer, "Common"); break;
                case Rarity.Rare: serializer.Serialize(writer, "Rare"); break;
                case Rarity.Uncommon: serializer.Serialize(writer, "Uncommon"); break;
            }
        }
    }

    static class SupertypeExtensions
    {
        public static Supertype? ValueForString(string str)
        {
            switch (str)
            {
                case "Basic": return Supertype.Basic;
                default: return null;
            }
        }

        public static Supertype ReadJson(JsonReader reader, JsonSerializer serializer)
        {
            var str = serializer.Deserialize<string>(reader);
            var maybeValue = ValueForString(str);
            if (maybeValue.HasValue) return maybeValue.Value;
            throw new Exception("Unknown enum case " + str);
        }

        public static void WriteJson(this Supertype value, JsonWriter writer, JsonSerializer serializer)
        {
            switch (value)
            {
                case Supertype.Basic: serializer.Serialize(writer, "Basic"); break;
            }
        }
    }

    static class TypeElementExtensions
    {
        public static TypeElement? ValueForString(string str)
        {
            switch (str)
            {
                case "Artifact": return TypeElement.Artifact;
                case "Creature": return TypeElement.Creature;
                case "Enchantment": return TypeElement.Enchantment;
                case "Instant": return TypeElement.Instant;
                case "Land": return TypeElement.Land;
                case "Sorcery": return TypeElement.Sorcery;
                default: return null;
            }
        }

        public static TypeElement ReadJson(JsonReader reader, JsonSerializer serializer)
        {
            var str = serializer.Deserialize<string>(reader);
            var maybeValue = ValueForString(str);
            if (maybeValue.HasValue) return maybeValue.Value;
            throw new Exception("Unknown enum case " + str);
        }

        public static void WriteJson(this TypeElement value, JsonWriter writer, JsonSerializer serializer)
        {
            switch (value)
            {
                case TypeElement.Artifact: serializer.Serialize(writer, "Artifact"); break;
                case TypeElement.Creature: serializer.Serialize(writer, "Creature"); break;
                case TypeElement.Enchantment: serializer.Serialize(writer, "Enchantment"); break;
                case TypeElement.Instant: serializer.Serialize(writer, "Instant"); break;
                case TypeElement.Land: serializer.Serialize(writer, "Land"); break;
                case TypeElement.Sorcery: serializer.Serialize(writer, "Sorcery"); break;
            }
        }
    }

    public static class Serialize
    {
        public static string ToJson(this LeaExtras self) => JsonConvert.SerializeObject(self, QuickType.Converter.Settings);
    }

    internal class Converter: JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(Booster) || t == typeof(ColorIdentity) || t == typeof(Color) || t == typeof(Layout) || t == typeof(Format) || t == typeof(LegalityLegality) || t == typeof(Rarity) || t == typeof(Supertype) || t == typeof(TypeElement) || t == typeof(Booster?) || t == typeof(ColorIdentity?) || t == typeof(Color?) || t == typeof(Layout?) || t == typeof(Format?) || t == typeof(LegalityLegality?) || t == typeof(Rarity?) || t == typeof(Supertype?) || t == typeof(TypeElement?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (t == typeof(Booster))
                return BoosterExtensions.ReadJson(reader, serializer);
            if (t == typeof(ColorIdentity))
                return ColorIdentityExtensions.ReadJson(reader, serializer);
            if (t == typeof(Color))
                return ColorExtensions.ReadJson(reader, serializer);
            if (t == typeof(Layout))
                return LayoutExtensions.ReadJson(reader, serializer);
            if (t == typeof(Format))
                return FormatExtensions.ReadJson(reader, serializer);
            if (t == typeof(LegalityLegality))
                return LegalityLegalityExtensions.ReadJson(reader, serializer);
            if (t == typeof(Rarity))
                return RarityExtensions.ReadJson(reader, serializer);
            if (t == typeof(Supertype))
                return SupertypeExtensions.ReadJson(reader, serializer);
            if (t == typeof(TypeElement))
                return TypeElementExtensions.ReadJson(reader, serializer);
            if (t == typeof(Booster?))
            {
                if (reader.TokenType == JsonToken.Null) return null;
                return BoosterExtensions.ReadJson(reader, serializer);
            }
            if (t == typeof(ColorIdentity?))
            {
                if (reader.TokenType == JsonToken.Null) return null;
                return ColorIdentityExtensions.ReadJson(reader, serializer);
            }
            if (t == typeof(Color?))
            {
                if (reader.TokenType == JsonToken.Null) return null;
                return ColorExtensions.ReadJson(reader, serializer);
            }
            if (t == typeof(Layout?))
            {
                if (reader.TokenType == JsonToken.Null) return null;
                return LayoutExtensions.ReadJson(reader, serializer);
            }
            if (t == typeof(Format?))
            {
                if (reader.TokenType == JsonToken.Null) return null;
                return FormatExtensions.ReadJson(reader, serializer);
            }
            if (t == typeof(LegalityLegality?))
            {
                if (reader.TokenType == JsonToken.Null) return null;
                return LegalityLegalityExtensions.ReadJson(reader, serializer);
            }
            if (t == typeof(Rarity?))
            {
                if (reader.TokenType == JsonToken.Null) return null;
                return RarityExtensions.ReadJson(reader, serializer);
            }
            if (t == typeof(Supertype?))
            {
                if (reader.TokenType == JsonToken.Null) return null;
                return SupertypeExtensions.ReadJson(reader, serializer);
            }
            if (t == typeof(TypeElement?))
            {
                if (reader.TokenType == JsonToken.Null) return null;
                return TypeElementExtensions.ReadJson(reader, serializer);
            }
            throw new Exception("Unknown type");
        }

        public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
        {
            var t = value.GetType();
            if (t == typeof(Booster))
            {
                ((Booster)value).WriteJson(writer, serializer);
                return;
            }
            if (t == typeof(ColorIdentity))
            {
                ((ColorIdentity)value).WriteJson(writer, serializer);
                return;
            }
            if (t == typeof(Color))
            {
                ((Color)value).WriteJson(writer, serializer);
                return;
            }
            if (t == typeof(Layout))
            {
                ((Layout)value).WriteJson(writer, serializer);
                return;
            }
            if (t == typeof(Format))
            {
                ((Format)value).WriteJson(writer, serializer);
                return;
            }
            if (t == typeof(LegalityLegality))
            {
                ((LegalityLegality)value).WriteJson(writer, serializer);
                return;
            }
            if (t == typeof(Rarity))
            {
                ((Rarity)value).WriteJson(writer, serializer);
                return;
            }
            if (t == typeof(Supertype))
            {
                ((Supertype)value).WriteJson(writer, serializer);
                return;
            }
            if (t == typeof(TypeElement))
            {
                ((TypeElement)value).WriteJson(writer, serializer);
                return;
            }
            throw new Exception("Unknown type");
        }

        public static readonly JsonSerializerSettings Settings = new JsonSerializerSettings
        {
            MetadataPropertyHandling = MetadataPropertyHandling.Ignore,
            DateParseHandling = DateParseHandling.None,
            Converters = { 
                new Converter(),
                new IsoDateTimeConverter()
                {
                    DateTimeStyles = DateTimeStyles.AssumeUniversal,
                },
            },
        };
    }
}
