//  To parse this JSON data, first install
// 
//      Boost     http://www.boost.org
//      json.hpp  https://github.com/nlohmann/json
// 
//  Then include this file, and then do
// 
//     LeaExtras data = nlohmann::json::parse(jsonString);

#include "json.hpp"

namespace quicktype {
    using nlohmann::json;

    enum class Booster { COMMON, RARE, UNCOMMON };

    enum class ColorIdentity { B, G, R, U, W };

    enum class Color { BLACK, BLUE, GREEN, RED, WHITE };

    enum class Layout { NORMAL };

    enum class Format { AMONKHET_BLOCK, BATTLE_FOR_ZENDIKAR_BLOCK, COMMANDER, ICE_AGE_BLOCK, INNISTRAD_BLOCK, INVASION_BLOCK, IXALAN_BLOCK, KALADESH_BLOCK, KAMIGAWA_BLOCK, KHANS_OF_TARKIR_BLOCK, LEGACY, LORWYN_SHADOWMOOR_BLOCK, MASQUES_BLOCK, MIRAGE_BLOCK, MIRRODIN_BLOCK, MODERN, ODYSSEY_BLOCK, ONSLAUGHT_BLOCK, RAVNICA_BLOCK, RETURN_TO_RAVNICA_BLOCK, SCARS_OF_MIRRODIN_BLOCK, SHADOWS_OVER_INNISTRAD_BLOCK, SHARDS_OF_ALARA_BLOCK, STANDARD, TEMPEST_BLOCK, THEROS_BLOCK, TIME_SPIRAL_BLOCK, UN_SETS, URZA_BLOCK, VINTAGE, ZENDIKAR_BLOCK };

    enum class LegalityLegality { BANNED, LEGAL, RESTRICTED };

    struct LegalityElement {
        Format format;
        LegalityLegality legality;
    };

    enum class Rarity { BASIC_LAND, COMMON, RARE, UNCOMMON };

    struct Ruling {
        std::string date;
        std::string text;
    };

    enum class Supertype { BASIC };

    enum class Type { ARTIFACT, CREATURE, ENCHANTMENT, INSTANT, LAND, SORCERY };

    struct Card {
        std::string artist;
        int64_t cmc;
        std::string id;
        std::string image_name;
        Layout layout;
        std::vector<struct LegalityElement> legalities;
        std::unique_ptr<std::string> mana_cost;
        std::unique_ptr<std::string> mci_number;
        int64_t multiverseid;
        std::string name;
        std::unique_ptr<std::string> original_text;
        std::string original_type;
        std::vector<std::string> printings;
        Rarity rarity;
        std::unique_ptr<std::vector<struct Ruling>> rulings;
        std::unique_ptr<std::string> text;
        std::string type;
        std::vector<Type> types;
        std::unique_ptr<bool> reserved;
        std::unique_ptr<std::string> power;
        std::unique_ptr<std::vector<std::string>> subtypes;
        std::unique_ptr<std::string> toughness;
        std::unique_ptr<std::vector<ColorIdentity>> color_identity;
        std::unique_ptr<std::string> flavor;
        std::unique_ptr<std::vector<Color>> colors;
        std::unique_ptr<std::vector<Supertype>> supertypes;
        std::unique_ptr<std::vector<int64_t>> variations;
    };

    struct LeaExtras {
        std::string name;
        std::string code;
        std::string gatherer_code;
        std::string magic_cards_info_code;
        std::string release_date;
        std::string border;
        std::string type;
        std::vector<Booster> booster;
        std::string mkm_name;
        int64_t mkm_id;
        std::vector<struct Card> cards;
    };
    
    inline json get_untyped(const json &j, const char *property) {
        if (j.find(property) != j.end()) {
            return j.at(property).get<json>();
        }
        return json();
    }
    
    template <typename T>
    inline std::unique_ptr<T> get_optional(const json &j, const char *property) {
        if (j.find(property) != j.end())
            return j.at(property).get<std::unique_ptr<T>>();
        return std::unique_ptr<T>();
    }
}

namespace nlohmann {
    template <typename T>
    struct adl_serializer<std::unique_ptr<T>> {
        static void to_json(json& j, const std::unique_ptr<T>& opt) {
            if (!opt)
                j = nullptr;
            else
                j = *opt;
        }

        static std::unique_ptr<T> from_json(const json& j) {
            if (j.is_null())
                return std::unique_ptr<T>();
            else
                return std::unique_ptr<T>(new T(j.get<T>()));
        }
    };

    inline void from_json(const json& _j, struct quicktype::LegalityElement& _x) {
        _x.format = _j.at("format").get<quicktype::Format>();
        _x.legality = _j.at("legality").get<quicktype::LegalityLegality>();
    }

    inline void to_json(json& _j, const struct quicktype::LegalityElement& _x) {
        _j = json::object();
        _j["format"] = _x.format;
        _j["legality"] = _x.legality;
    }

    inline void from_json(const json& _j, struct quicktype::Ruling& _x) {
        _x.date = _j.at("date").get<std::string>();
        _x.text = _j.at("text").get<std::string>();
    }

    inline void to_json(json& _j, const struct quicktype::Ruling& _x) {
        _j = json::object();
        _j["date"] = _x.date;
        _j["text"] = _x.text;
    }

    inline void from_json(const json& _j, struct quicktype::Card& _x) {
        _x.artist = _j.at("artist").get<std::string>();
        _x.cmc = _j.at("cmc").get<int64_t>();
        _x.id = _j.at("id").get<std::string>();
        _x.image_name = _j.at("imageName").get<std::string>();
        _x.layout = _j.at("layout").get<quicktype::Layout>();
        _x.legalities = _j.at("legalities").get<std::vector<struct quicktype::LegalityElement>>();
        _x.mana_cost = quicktype::get_optional<std::string>(_j, "manaCost");
        _x.mci_number = quicktype::get_optional<std::string>(_j, "mciNumber");
        _x.multiverseid = _j.at("multiverseid").get<int64_t>();
        _x.name = _j.at("name").get<std::string>();
        _x.original_text = quicktype::get_optional<std::string>(_j, "originalText");
        _x.original_type = _j.at("originalType").get<std::string>();
        _x.printings = _j.at("printings").get<std::vector<std::string>>();
        _x.rarity = _j.at("rarity").get<quicktype::Rarity>();
        _x.rulings = quicktype::get_optional<std::vector<struct quicktype::Ruling>>(_j, "rulings");
        _x.text = quicktype::get_optional<std::string>(_j, "text");
        _x.type = _j.at("type").get<std::string>();
        _x.types = _j.at("types").get<std::vector<quicktype::Type>>();
        _x.reserved = quicktype::get_optional<bool>(_j, "reserved");
        _x.power = quicktype::get_optional<std::string>(_j, "power");
        _x.subtypes = quicktype::get_optional<std::vector<std::string>>(_j, "subtypes");
        _x.toughness = quicktype::get_optional<std::string>(_j, "toughness");
        _x.color_identity = quicktype::get_optional<std::vector<quicktype::ColorIdentity>>(_j, "colorIdentity");
        _x.flavor = quicktype::get_optional<std::string>(_j, "flavor");
        _x.colors = quicktype::get_optional<std::vector<quicktype::Color>>(_j, "colors");
        _x.supertypes = quicktype::get_optional<std::vector<quicktype::Supertype>>(_j, "supertypes");
        _x.variations = quicktype::get_optional<std::vector<int64_t>>(_j, "variations");
    }

    inline void to_json(json& _j, const struct quicktype::Card& _x) {
        _j = json::object();
        _j["artist"] = _x.artist;
        _j["cmc"] = _x.cmc;
        _j["id"] = _x.id;
        _j["imageName"] = _x.image_name;
        _j["layout"] = _x.layout;
        _j["legalities"] = _x.legalities;
        _j["manaCost"] = _x.mana_cost;
        _j["mciNumber"] = _x.mci_number;
        _j["multiverseid"] = _x.multiverseid;
        _j["name"] = _x.name;
        _j["originalText"] = _x.original_text;
        _j["originalType"] = _x.original_type;
        _j["printings"] = _x.printings;
        _j["rarity"] = _x.rarity;
        _j["rulings"] = _x.rulings;
        _j["text"] = _x.text;
        _j["type"] = _x.type;
        _j["types"] = _x.types;
        _j["reserved"] = _x.reserved;
        _j["power"] = _x.power;
        _j["subtypes"] = _x.subtypes;
        _j["toughness"] = _x.toughness;
        _j["colorIdentity"] = _x.color_identity;
        _j["flavor"] = _x.flavor;
        _j["colors"] = _x.colors;
        _j["supertypes"] = _x.supertypes;
        _j["variations"] = _x.variations;
    }

    inline void from_json(const json& _j, struct quicktype::LeaExtras& _x) {
        _x.name = _j.at("name").get<std::string>();
        _x.code = _j.at("code").get<std::string>();
        _x.gatherer_code = _j.at("gathererCode").get<std::string>();
        _x.magic_cards_info_code = _j.at("magicCardsInfoCode").get<std::string>();
        _x.release_date = _j.at("releaseDate").get<std::string>();
        _x.border = _j.at("border").get<std::string>();
        _x.type = _j.at("type").get<std::string>();
        _x.booster = _j.at("booster").get<std::vector<quicktype::Booster>>();
        _x.mkm_name = _j.at("mkm_name").get<std::string>();
        _x.mkm_id = _j.at("mkm_id").get<int64_t>();
        _x.cards = _j.at("cards").get<std::vector<struct quicktype::Card>>();
    }

    inline void to_json(json& _j, const struct quicktype::LeaExtras& _x) {
        _j = json::object();
        _j["name"] = _x.name;
        _j["code"] = _x.code;
        _j["gathererCode"] = _x.gatherer_code;
        _j["magicCardsInfoCode"] = _x.magic_cards_info_code;
        _j["releaseDate"] = _x.release_date;
        _j["border"] = _x.border;
        _j["type"] = _x.type;
        _j["booster"] = _x.booster;
        _j["mkm_name"] = _x.mkm_name;
        _j["mkm_id"] = _x.mkm_id;
        _j["cards"] = _x.cards;
    }

    inline void from_json(const json& _j, quicktype::Booster& _x) {
        if (_j == "common") _x = quicktype::Booster::COMMON;
        else if (_j == "rare") _x = quicktype::Booster::RARE;
        else if (_j == "uncommon") _x = quicktype::Booster::UNCOMMON;
        else throw "Input JSON does not conform to schema";
    }

    inline void to_json(json& _j, const quicktype::Booster& _x) {
        switch (_x) {
            case quicktype::Booster::COMMON: _j = "common"; break;
            case quicktype::Booster::RARE: _j = "rare"; break;
            case quicktype::Booster::UNCOMMON: _j = "uncommon"; break;
            default: throw "This should not happen";
        }
    }

    inline void from_json(const json& _j, quicktype::ColorIdentity& _x) {
        if (_j == "B") _x = quicktype::ColorIdentity::B;
        else if (_j == "G") _x = quicktype::ColorIdentity::G;
        else if (_j == "R") _x = quicktype::ColorIdentity::R;
        else if (_j == "U") _x = quicktype::ColorIdentity::U;
        else if (_j == "W") _x = quicktype::ColorIdentity::W;
        else throw "Input JSON does not conform to schema";
    }

    inline void to_json(json& _j, const quicktype::ColorIdentity& _x) {
        switch (_x) {
            case quicktype::ColorIdentity::B: _j = "B"; break;
            case quicktype::ColorIdentity::G: _j = "G"; break;
            case quicktype::ColorIdentity::R: _j = "R"; break;
            case quicktype::ColorIdentity::U: _j = "U"; break;
            case quicktype::ColorIdentity::W: _j = "W"; break;
            default: throw "This should not happen";
        }
    }

    inline void from_json(const json& _j, quicktype::Color& _x) {
        if (_j == "Black") _x = quicktype::Color::BLACK;
        else if (_j == "Blue") _x = quicktype::Color::BLUE;
        else if (_j == "Green") _x = quicktype::Color::GREEN;
        else if (_j == "Red") _x = quicktype::Color::RED;
        else if (_j == "White") _x = quicktype::Color::WHITE;
        else throw "Input JSON does not conform to schema";
    }

    inline void to_json(json& _j, const quicktype::Color& _x) {
        switch (_x) {
            case quicktype::Color::BLACK: _j = "Black"; break;
            case quicktype::Color::BLUE: _j = "Blue"; break;
            case quicktype::Color::GREEN: _j = "Green"; break;
            case quicktype::Color::RED: _j = "Red"; break;
            case quicktype::Color::WHITE: _j = "White"; break;
            default: throw "This should not happen";
        }
    }

    inline void from_json(const json& _j, quicktype::Layout& _x) {
        if (_j == "normal") _x = quicktype::Layout::NORMAL;
        else throw "Input JSON does not conform to schema";
    }

    inline void to_json(json& _j, const quicktype::Layout& _x) {
        switch (_x) {
            case quicktype::Layout::NORMAL: _j = "normal"; break;
            default: throw "This should not happen";
        }
    }

    inline void from_json(const json& _j, quicktype::Format& _x) {
        if (_j == "Amonkhet Block") _x = quicktype::Format::AMONKHET_BLOCK;
        else if (_j == "Battle for Zendikar Block") _x = quicktype::Format::BATTLE_FOR_ZENDIKAR_BLOCK;
        else if (_j == "Commander") _x = quicktype::Format::COMMANDER;
        else if (_j == "Ice Age Block") _x = quicktype::Format::ICE_AGE_BLOCK;
        else if (_j == "Innistrad Block") _x = quicktype::Format::INNISTRAD_BLOCK;
        else if (_j == "Invasion Block") _x = quicktype::Format::INVASION_BLOCK;
        else if (_j == "Ixalan Block") _x = quicktype::Format::IXALAN_BLOCK;
        else if (_j == "Kaladesh Block") _x = quicktype::Format::KALADESH_BLOCK;
        else if (_j == "Kamigawa Block") _x = quicktype::Format::KAMIGAWA_BLOCK;
        else if (_j == "Khans of Tarkir Block") _x = quicktype::Format::KHANS_OF_TARKIR_BLOCK;
        else if (_j == "Legacy") _x = quicktype::Format::LEGACY;
        else if (_j == "Lorwyn-Shadowmoor Block") _x = quicktype::Format::LORWYN_SHADOWMOOR_BLOCK;
        else if (_j == "Masques Block") _x = quicktype::Format::MASQUES_BLOCK;
        else if (_j == "Mirage Block") _x = quicktype::Format::MIRAGE_BLOCK;
        else if (_j == "Mirrodin Block") _x = quicktype::Format::MIRRODIN_BLOCK;
        else if (_j == "Modern") _x = quicktype::Format::MODERN;
        else if (_j == "Odyssey Block") _x = quicktype::Format::ODYSSEY_BLOCK;
        else if (_j == "Onslaught Block") _x = quicktype::Format::ONSLAUGHT_BLOCK;
        else if (_j == "Ravnica Block") _x = quicktype::Format::RAVNICA_BLOCK;
        else if (_j == "Return to Ravnica Block") _x = quicktype::Format::RETURN_TO_RAVNICA_BLOCK;
        else if (_j == "Scars of Mirrodin Block") _x = quicktype::Format::SCARS_OF_MIRRODIN_BLOCK;
        else if (_j == "Shadows over Innistrad Block") _x = quicktype::Format::SHADOWS_OVER_INNISTRAD_BLOCK;
        else if (_j == "Shards of Alara Block") _x = quicktype::Format::SHARDS_OF_ALARA_BLOCK;
        else if (_j == "Standard") _x = quicktype::Format::STANDARD;
        else if (_j == "Tempest Block") _x = quicktype::Format::TEMPEST_BLOCK;
        else if (_j == "Theros Block") _x = quicktype::Format::THEROS_BLOCK;
        else if (_j == "Time Spiral Block") _x = quicktype::Format::TIME_SPIRAL_BLOCK;
        else if (_j == "Un-Sets") _x = quicktype::Format::UN_SETS;
        else if (_j == "Urza Block") _x = quicktype::Format::URZA_BLOCK;
        else if (_j == "Vintage") _x = quicktype::Format::VINTAGE;
        else if (_j == "Zendikar Block") _x = quicktype::Format::ZENDIKAR_BLOCK;
        else throw "Input JSON does not conform to schema";
    }

    inline void to_json(json& _j, const quicktype::Format& _x) {
        switch (_x) {
            case quicktype::Format::AMONKHET_BLOCK: _j = "Amonkhet Block"; break;
            case quicktype::Format::BATTLE_FOR_ZENDIKAR_BLOCK: _j = "Battle for Zendikar Block"; break;
            case quicktype::Format::COMMANDER: _j = "Commander"; break;
            case quicktype::Format::ICE_AGE_BLOCK: _j = "Ice Age Block"; break;
            case quicktype::Format::INNISTRAD_BLOCK: _j = "Innistrad Block"; break;
            case quicktype::Format::INVASION_BLOCK: _j = "Invasion Block"; break;
            case quicktype::Format::IXALAN_BLOCK: _j = "Ixalan Block"; break;
            case quicktype::Format::KALADESH_BLOCK: _j = "Kaladesh Block"; break;
            case quicktype::Format::KAMIGAWA_BLOCK: _j = "Kamigawa Block"; break;
            case quicktype::Format::KHANS_OF_TARKIR_BLOCK: _j = "Khans of Tarkir Block"; break;
            case quicktype::Format::LEGACY: _j = "Legacy"; break;
            case quicktype::Format::LORWYN_SHADOWMOOR_BLOCK: _j = "Lorwyn-Shadowmoor Block"; break;
            case quicktype::Format::MASQUES_BLOCK: _j = "Masques Block"; break;
            case quicktype::Format::MIRAGE_BLOCK: _j = "Mirage Block"; break;
            case quicktype::Format::MIRRODIN_BLOCK: _j = "Mirrodin Block"; break;
            case quicktype::Format::MODERN: _j = "Modern"; break;
            case quicktype::Format::ODYSSEY_BLOCK: _j = "Odyssey Block"; break;
            case quicktype::Format::ONSLAUGHT_BLOCK: _j = "Onslaught Block"; break;
            case quicktype::Format::RAVNICA_BLOCK: _j = "Ravnica Block"; break;
            case quicktype::Format::RETURN_TO_RAVNICA_BLOCK: _j = "Return to Ravnica Block"; break;
            case quicktype::Format::SCARS_OF_MIRRODIN_BLOCK: _j = "Scars of Mirrodin Block"; break;
            case quicktype::Format::SHADOWS_OVER_INNISTRAD_BLOCK: _j = "Shadows over Innistrad Block"; break;
            case quicktype::Format::SHARDS_OF_ALARA_BLOCK: _j = "Shards of Alara Block"; break;
            case quicktype::Format::STANDARD: _j = "Standard"; break;
            case quicktype::Format::TEMPEST_BLOCK: _j = "Tempest Block"; break;
            case quicktype::Format::THEROS_BLOCK: _j = "Theros Block"; break;
            case quicktype::Format::TIME_SPIRAL_BLOCK: _j = "Time Spiral Block"; break;
            case quicktype::Format::UN_SETS: _j = "Un-Sets"; break;
            case quicktype::Format::URZA_BLOCK: _j = "Urza Block"; break;
            case quicktype::Format::VINTAGE: _j = "Vintage"; break;
            case quicktype::Format::ZENDIKAR_BLOCK: _j = "Zendikar Block"; break;
            default: throw "This should not happen";
        }
    }

    inline void from_json(const json& _j, quicktype::LegalityLegality& _x) {
        if (_j == "Banned") _x = quicktype::LegalityLegality::BANNED;
        else if (_j == "Legal") _x = quicktype::LegalityLegality::LEGAL;
        else if (_j == "Restricted") _x = quicktype::LegalityLegality::RESTRICTED;
        else throw "Input JSON does not conform to schema";
    }

    inline void to_json(json& _j, const quicktype::LegalityLegality& _x) {
        switch (_x) {
            case quicktype::LegalityLegality::BANNED: _j = "Banned"; break;
            case quicktype::LegalityLegality::LEGAL: _j = "Legal"; break;
            case quicktype::LegalityLegality::RESTRICTED: _j = "Restricted"; break;
            default: throw "This should not happen";
        }
    }

    inline void from_json(const json& _j, quicktype::Rarity& _x) {
        if (_j == "Basic Land") _x = quicktype::Rarity::BASIC_LAND;
        else if (_j == "Common") _x = quicktype::Rarity::COMMON;
        else if (_j == "Rare") _x = quicktype::Rarity::RARE;
        else if (_j == "Uncommon") _x = quicktype::Rarity::UNCOMMON;
        else throw "Input JSON does not conform to schema";
    }

    inline void to_json(json& _j, const quicktype::Rarity& _x) {
        switch (_x) {
            case quicktype::Rarity::BASIC_LAND: _j = "Basic Land"; break;
            case quicktype::Rarity::COMMON: _j = "Common"; break;
            case quicktype::Rarity::RARE: _j = "Rare"; break;
            case quicktype::Rarity::UNCOMMON: _j = "Uncommon"; break;
            default: throw "This should not happen";
        }
    }

    inline void from_json(const json& _j, quicktype::Supertype& _x) {
        if (_j == "Basic") _x = quicktype::Supertype::BASIC;
        else throw "Input JSON does not conform to schema";
    }

    inline void to_json(json& _j, const quicktype::Supertype& _x) {
        switch (_x) {
            case quicktype::Supertype::BASIC: _j = "Basic"; break;
            default: throw "This should not happen";
        }
    }

    inline void from_json(const json& _j, quicktype::Type& _x) {
        if (_j == "Artifact") _x = quicktype::Type::ARTIFACT;
        else if (_j == "Creature") _x = quicktype::Type::CREATURE;
        else if (_j == "Enchantment") _x = quicktype::Type::ENCHANTMENT;
        else if (_j == "Instant") _x = quicktype::Type::INSTANT;
        else if (_j == "Land") _x = quicktype::Type::LAND;
        else if (_j == "Sorcery") _x = quicktype::Type::SORCERY;
        else throw "Input JSON does not conform to schema";
    }

    inline void to_json(json& _j, const quicktype::Type& _x) {
        switch (_x) {
            case quicktype::Type::ARTIFACT: _j = "Artifact"; break;
            case quicktype::Type::CREATURE: _j = "Creature"; break;
            case quicktype::Type::ENCHANTMENT: _j = "Enchantment"; break;
            case quicktype::Type::INSTANT: _j = "Instant"; break;
            case quicktype::Type::LAND: _j = "Land"; break;
            case quicktype::Type::SORCERY: _j = "Sorcery"; break;
            default: throw "This should not happen";
        }
    }
}
