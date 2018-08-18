//  To parse this JSON data, first install
//
//      Boost     http://www.boost.org
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     LeaExtras data = nlohmann::json::parse(jsonString);

#pragma once

#include "json.hpp"

#include <boost/optional.hpp>
#include <stdexcept>
#include <regex>
namespace nlohmann {
    template <typename T>
    struct adl_serializer<std::shared_ptr<T>> {
        static void to_json(json& j, const std::shared_ptr<T>& opt) {
            if (!opt) j = nullptr; else j = *opt;
        }

        static std::shared_ptr<T> from_json(const json& j) {
            if (j.is_null()) return std::unique_ptr<T>(); else return std::unique_ptr<T>(new T(j.get<T>()));
        }
    };
}

namespace quicktype {
    using nlohmann::json;

    inline json get_untyped(const json &j, const char *property) {
        if (j.find(property) != j.end()) {
            return j.at(property).get<json>();
        }
        return json();
    }

    template <typename T>
    inline std::shared_ptr<T> get_optional(const json &j, const char *property) {
        if (j.find(property) != j.end()) {
            return j.at(property).get<std::shared_ptr<T>>();
        }
        return std::shared_ptr<T>();
    }

    enum class Booster : int { COMMON, RARE, UNCOMMON };

    enum class ColorIdentity : int { B, G, R, U, W };

    enum class Color : int { BLACK, BLUE, GREEN, RED, WHITE };

    enum class Layout : int { NORMAL };

    enum class Format : int { BRAWL, COMMANDER, LEGACY, MODERN, STANDARD, VINTAGE };

    enum class LegalityEnum : int { BANNED, LEGAL, RESTRICTED };

    class LegalityElement {
        public:
        LegalityElement() = default;
        virtual ~LegalityElement() = default;

        private:
        Format format;
        LegalityEnum legality;

        public:
        const Format & get_format() const { return format; }
        Format & get_mutable_format() { return format; }
        void set_format(const Format& value) { this->format = value; }

        const LegalityEnum & get_legality() const { return legality; }
        LegalityEnum & get_mutable_legality() { return legality; }
        void set_legality(const LegalityEnum& value) { this->legality = value; }
    };

    enum class Rarity : int { BASIC_LAND, COMMON, RARE, UNCOMMON };

    class Ruling {
        public:
        Ruling() = default;
        virtual ~Ruling() = default;

        private:
        std::string date;
        std::string text;

        public:
        const std::string & get_date() const { return date; }
        std::string & get_mutable_date() { return date; }
        void set_date(const std::string& value) { this->date = value; }

        const std::string & get_text() const { return text; }
        std::string & get_mutable_text() { return text; }
        void set_text(const std::string& value) { this->text = value; }
    };

    enum class Supertype : int { BASIC };

    enum class Type : int { ARTIFACT, CREATURE, ENCHANTMENT, INSTANT, LAND, SORCERY };

    class Card {
        public:
        Card() = default;
        virtual ~Card() = default;

        private:
        std::string artist;
        int64_t cmc;
        std::string id;
        std::string image_name;
        Layout layout;
        std::vector<LegalityElement> legalities;
        std::shared_ptr<std::string> mana_cost;
        std::shared_ptr<std::string> mci_number;
        int64_t multiverseid;
        std::string name;
        std::shared_ptr<std::string> original_text;
        std::string original_type;
        std::vector<std::string> printings;
        Rarity rarity;
        std::shared_ptr<std::vector<Ruling>> rulings;
        std::shared_ptr<std::string> text;
        std::string type;
        std::vector<Type> types;
        std::shared_ptr<bool> reserved;
        std::shared_ptr<std::string> power;
        std::shared_ptr<std::vector<std::string>> subtypes;
        std::shared_ptr<std::string> toughness;
        std::shared_ptr<std::vector<ColorIdentity>> color_identity;
        std::shared_ptr<std::string> flavor;
        std::shared_ptr<std::vector<Color>> colors;
        std::shared_ptr<std::vector<Supertype>> supertypes;
        std::shared_ptr<std::vector<int64_t>> variations;

        public:
        const std::string & get_artist() const { return artist; }
        std::string & get_mutable_artist() { return artist; }
        void set_artist(const std::string& value) { this->artist = value; }

        const int64_t & get_cmc() const { return cmc; }
        int64_t & get_mutable_cmc() { return cmc; }
        void set_cmc(const int64_t& value) { this->cmc = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string& value) { this->id = value; }

        const std::string & get_image_name() const { return image_name; }
        std::string & get_mutable_image_name() { return image_name; }
        void set_image_name(const std::string& value) { this->image_name = value; }

        const Layout & get_layout() const { return layout; }
        Layout & get_mutable_layout() { return layout; }
        void set_layout(const Layout& value) { this->layout = value; }

        const std::vector<LegalityElement> & get_legalities() const { return legalities; }
        std::vector<LegalityElement> & get_mutable_legalities() { return legalities; }
        void set_legalities(const std::vector<LegalityElement>& value) { this->legalities = value; }

        std::shared_ptr<std::string> get_mana_cost() const { return mana_cost; }
        void set_mana_cost(std::shared_ptr<std::string> value) { this->mana_cost = value; }

        std::shared_ptr<std::string> get_mci_number() const { return mci_number; }
        void set_mci_number(std::shared_ptr<std::string> value) { this->mci_number = value; }

        const int64_t & get_multiverseid() const { return multiverseid; }
        int64_t & get_mutable_multiverseid() { return multiverseid; }
        void set_multiverseid(const int64_t& value) { this->multiverseid = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string& value) { this->name = value; }

        std::shared_ptr<std::string> get_original_text() const { return original_text; }
        void set_original_text(std::shared_ptr<std::string> value) { this->original_text = value; }

        const std::string & get_original_type() const { return original_type; }
        std::string & get_mutable_original_type() { return original_type; }
        void set_original_type(const std::string& value) { this->original_type = value; }

        const std::vector<std::string> & get_printings() const { return printings; }
        std::vector<std::string> & get_mutable_printings() { return printings; }
        void set_printings(const std::vector<std::string>& value) { this->printings = value; }

        const Rarity & get_rarity() const { return rarity; }
        Rarity & get_mutable_rarity() { return rarity; }
        void set_rarity(const Rarity& value) { this->rarity = value; }

        std::shared_ptr<std::vector<Ruling>> get_rulings() const { return rulings; }
        void set_rulings(std::shared_ptr<std::vector<Ruling>> value) { this->rulings = value; }

        std::shared_ptr<std::string> get_text() const { return text; }
        void set_text(std::shared_ptr<std::string> value) { this->text = value; }

        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string& value) { this->type = value; }

        const std::vector<Type> & get_types() const { return types; }
        std::vector<Type> & get_mutable_types() { return types; }
        void set_types(const std::vector<Type>& value) { this->types = value; }

        std::shared_ptr<bool> get_reserved() const { return reserved; }
        void set_reserved(std::shared_ptr<bool> value) { this->reserved = value; }

        std::shared_ptr<std::string> get_power() const { return power; }
        void set_power(std::shared_ptr<std::string> value) { this->power = value; }

        std::shared_ptr<std::vector<std::string>> get_subtypes() const { return subtypes; }
        void set_subtypes(std::shared_ptr<std::vector<std::string>> value) { this->subtypes = value; }

        std::shared_ptr<std::string> get_toughness() const { return toughness; }
        void set_toughness(std::shared_ptr<std::string> value) { this->toughness = value; }

        std::shared_ptr<std::vector<ColorIdentity>> get_color_identity() const { return color_identity; }
        void set_color_identity(std::shared_ptr<std::vector<ColorIdentity>> value) { this->color_identity = value; }

        std::shared_ptr<std::string> get_flavor() const { return flavor; }
        void set_flavor(std::shared_ptr<std::string> value) { this->flavor = value; }

        std::shared_ptr<std::vector<Color>> get_colors() const { return colors; }
        void set_colors(std::shared_ptr<std::vector<Color>> value) { this->colors = value; }

        std::shared_ptr<std::vector<Supertype>> get_supertypes() const { return supertypes; }
        void set_supertypes(std::shared_ptr<std::vector<Supertype>> value) { this->supertypes = value; }

        std::shared_ptr<std::vector<int64_t>> get_variations() const { return variations; }
        void set_variations(std::shared_ptr<std::vector<int64_t>> value) { this->variations = value; }
    };

    class LeaExtras {
        public:
        LeaExtras() = default;
        virtual ~LeaExtras() = default;

        private:
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
        std::vector<Card> cards;

        public:
        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string& value) { this->name = value; }

        const std::string & get_code() const { return code; }
        std::string & get_mutable_code() { return code; }
        void set_code(const std::string& value) { this->code = value; }

        const std::string & get_gatherer_code() const { return gatherer_code; }
        std::string & get_mutable_gatherer_code() { return gatherer_code; }
        void set_gatherer_code(const std::string& value) { this->gatherer_code = value; }

        const std::string & get_magic_cards_info_code() const { return magic_cards_info_code; }
        std::string & get_mutable_magic_cards_info_code() { return magic_cards_info_code; }
        void set_magic_cards_info_code(const std::string& value) { this->magic_cards_info_code = value; }

        const std::string & get_release_date() const { return release_date; }
        std::string & get_mutable_release_date() { return release_date; }
        void set_release_date(const std::string& value) { this->release_date = value; }

        const std::string & get_border() const { return border; }
        std::string & get_mutable_border() { return border; }
        void set_border(const std::string& value) { this->border = value; }

        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string& value) { this->type = value; }

        const std::vector<Booster> & get_booster() const { return booster; }
        std::vector<Booster> & get_mutable_booster() { return booster; }
        void set_booster(const std::vector<Booster>& value) { this->booster = value; }

        const std::string & get_mkm_name() const { return mkm_name; }
        std::string & get_mutable_mkm_name() { return mkm_name; }
        void set_mkm_name(const std::string& value) { this->mkm_name = value; }

        const int64_t & get_mkm_id() const { return mkm_id; }
        int64_t & get_mutable_mkm_id() { return mkm_id; }
        void set_mkm_id(const int64_t& value) { this->mkm_id = value; }

        const std::vector<Card> & get_cards() const { return cards; }
        std::vector<Card> & get_mutable_cards() { return cards; }
        void set_cards(const std::vector<Card>& value) { this->cards = value; }
    };
}

namespace nlohmann {
    inline void from_json(const json& _j, quicktype::LegalityElement& _x) {
        _x.set_format( _j.at("format").get<quicktype::Format>() );
        _x.set_legality( _j.at("legality").get<quicktype::LegalityEnum>() );
    }

    inline void to_json(json& _j, const quicktype::LegalityElement& _x) {
        _j = json::object();
        _j["format"] = _x.get_format();
        _j["legality"] = _x.get_legality();
    }

    inline void from_json(const json& _j, quicktype::Ruling& _x) {
        _x.set_date( _j.at("date").get<std::string>() );
        _x.set_text( _j.at("text").get<std::string>() );
    }

    inline void to_json(json& _j, const quicktype::Ruling& _x) {
        _j = json::object();
        _j["date"] = _x.get_date();
        _j["text"] = _x.get_text();
    }

    inline void from_json(const json& _j, quicktype::Card& _x) {
        _x.set_artist( _j.at("artist").get<std::string>() );
        _x.set_cmc( _j.at("cmc").get<int64_t>() );
        _x.set_id( _j.at("id").get<std::string>() );
        _x.set_image_name( _j.at("imageName").get<std::string>() );
        _x.set_layout( _j.at("layout").get<quicktype::Layout>() );
        _x.set_legalities( _j.at("legalities").get<std::vector<quicktype::LegalityElement>>() );
        _x.set_mana_cost( quicktype::get_optional<std::string>(_j, "manaCost") );
        _x.set_mci_number( quicktype::get_optional<std::string>(_j, "mciNumber") );
        _x.set_multiverseid( _j.at("multiverseid").get<int64_t>() );
        _x.set_name( _j.at("name").get<std::string>() );
        _x.set_original_text( quicktype::get_optional<std::string>(_j, "originalText") );
        _x.set_original_type( _j.at("originalType").get<std::string>() );
        _x.set_printings( _j.at("printings").get<std::vector<std::string>>() );
        _x.set_rarity( _j.at("rarity").get<quicktype::Rarity>() );
        _x.set_rulings( quicktype::get_optional<std::vector<quicktype::Ruling>>(_j, "rulings") );
        _x.set_text( quicktype::get_optional<std::string>(_j, "text") );
        _x.set_type( _j.at("type").get<std::string>() );
        _x.set_types( _j.at("types").get<std::vector<quicktype::Type>>() );
        _x.set_reserved( quicktype::get_optional<bool>(_j, "reserved") );
        _x.set_power( quicktype::get_optional<std::string>(_j, "power") );
        _x.set_subtypes( quicktype::get_optional<std::vector<std::string>>(_j, "subtypes") );
        _x.set_toughness( quicktype::get_optional<std::string>(_j, "toughness") );
        _x.set_color_identity( quicktype::get_optional<std::vector<quicktype::ColorIdentity>>(_j, "colorIdentity") );
        _x.set_flavor( quicktype::get_optional<std::string>(_j, "flavor") );
        _x.set_colors( quicktype::get_optional<std::vector<quicktype::Color>>(_j, "colors") );
        _x.set_supertypes( quicktype::get_optional<std::vector<quicktype::Supertype>>(_j, "supertypes") );
        _x.set_variations( quicktype::get_optional<std::vector<int64_t>>(_j, "variations") );
    }

    inline void to_json(json& _j, const quicktype::Card& _x) {
        _j = json::object();
        _j["artist"] = _x.get_artist();
        _j["cmc"] = _x.get_cmc();
        _j["id"] = _x.get_id();
        _j["imageName"] = _x.get_image_name();
        _j["layout"] = _x.get_layout();
        _j["legalities"] = _x.get_legalities();
        _j["manaCost"] = _x.get_mana_cost();
        _j["mciNumber"] = _x.get_mci_number();
        _j["multiverseid"] = _x.get_multiverseid();
        _j["name"] = _x.get_name();
        _j["originalText"] = _x.get_original_text();
        _j["originalType"] = _x.get_original_type();
        _j["printings"] = _x.get_printings();
        _j["rarity"] = _x.get_rarity();
        _j["rulings"] = _x.get_rulings();
        _j["text"] = _x.get_text();
        _j["type"] = _x.get_type();
        _j["types"] = _x.get_types();
        _j["reserved"] = _x.get_reserved();
        _j["power"] = _x.get_power();
        _j["subtypes"] = _x.get_subtypes();
        _j["toughness"] = _x.get_toughness();
        _j["colorIdentity"] = _x.get_color_identity();
        _j["flavor"] = _x.get_flavor();
        _j["colors"] = _x.get_colors();
        _j["supertypes"] = _x.get_supertypes();
        _j["variations"] = _x.get_variations();
    }

    inline void from_json(const json& _j, quicktype::LeaExtras& _x) {
        _x.set_name( _j.at("name").get<std::string>() );
        _x.set_code( _j.at("code").get<std::string>() );
        _x.set_gatherer_code( _j.at("gathererCode").get<std::string>() );
        _x.set_magic_cards_info_code( _j.at("magicCardsInfoCode").get<std::string>() );
        _x.set_release_date( _j.at("releaseDate").get<std::string>() );
        _x.set_border( _j.at("border").get<std::string>() );
        _x.set_type( _j.at("type").get<std::string>() );
        _x.set_booster( _j.at("booster").get<std::vector<quicktype::Booster>>() );
        _x.set_mkm_name( _j.at("mkm_name").get<std::string>() );
        _x.set_mkm_id( _j.at("mkm_id").get<int64_t>() );
        _x.set_cards( _j.at("cards").get<std::vector<quicktype::Card>>() );
    }

    inline void to_json(json& _j, const quicktype::LeaExtras& _x) {
        _j = json::object();
        _j["name"] = _x.get_name();
        _j["code"] = _x.get_code();
        _j["gathererCode"] = _x.get_gatherer_code();
        _j["magicCardsInfoCode"] = _x.get_magic_cards_info_code();
        _j["releaseDate"] = _x.get_release_date();
        _j["border"] = _x.get_border();
        _j["type"] = _x.get_type();
        _j["booster"] = _x.get_booster();
        _j["mkm_name"] = _x.get_mkm_name();
        _j["mkm_id"] = _x.get_mkm_id();
        _j["cards"] = _x.get_cards();
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
        if (_j == "Brawl") _x = quicktype::Format::BRAWL;
        else if (_j == "Commander") _x = quicktype::Format::COMMANDER;
        else if (_j == "Legacy") _x = quicktype::Format::LEGACY;
        else if (_j == "Modern") _x = quicktype::Format::MODERN;
        else if (_j == "Standard") _x = quicktype::Format::STANDARD;
        else if (_j == "Vintage") _x = quicktype::Format::VINTAGE;
        else throw "Input JSON does not conform to schema";
    }

    inline void to_json(json& _j, const quicktype::Format& _x) {
        switch (_x) {
            case quicktype::Format::BRAWL: _j = "Brawl"; break;
            case quicktype::Format::COMMANDER: _j = "Commander"; break;
            case quicktype::Format::LEGACY: _j = "Legacy"; break;
            case quicktype::Format::MODERN: _j = "Modern"; break;
            case quicktype::Format::STANDARD: _j = "Standard"; break;
            case quicktype::Format::VINTAGE: _j = "Vintage"; break;
            default: throw "This should not happen";
        }
    }

    inline void from_json(const json& _j, quicktype::LegalityEnum& _x) {
        if (_j == "Banned") _x = quicktype::LegalityEnum::BANNED;
        else if (_j == "Legal") _x = quicktype::LegalityEnum::LEGAL;
        else if (_j == "Restricted") _x = quicktype::LegalityEnum::RESTRICTED;
        else throw "Input JSON does not conform to schema";
    }

    inline void to_json(json& _j, const quicktype::LegalityEnum& _x) {
        switch (_x) {
            case quicktype::LegalityEnum::BANNED: _j = "Banned"; break;
            case quicktype::LegalityEnum::LEGAL: _j = "Legal"; break;
            case quicktype::LegalityEnum::RESTRICTED: _j = "Restricted"; break;
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
