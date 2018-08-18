# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   lea_extras = LEAExtras.from_json! "{…}"
#   puts lea_extras.cards.first.variations&.first.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry::Types.module

  Int           = Strict::Int
  Bool          = Strict::Bool
  Hash          = Strict::Hash
  String        = Strict::String
  Booster       = Strict::String.enum("common", "rare", "uncommon")
  ColorIdentity = Strict::String.enum("B", "G", "R", "U", "W")
  Color         = Strict::String.enum("Black", "Blue", "Green", "Red", "White")
  Layout        = Strict::String.enum("normal")
  LegalityEnum  = Strict::String.enum("Banned", "Legal", "Restricted")
  Format        = Strict::String.enum("Brawl", "Commander", "Legacy", "Modern", "Standard", "Vintage")
  Rarity        = Strict::String.enum("Basic Land", "Common", "Rare", "Uncommon")
  Supertype     = Strict::String.enum("Basic")
  Type          = Strict::String.enum("Artifact", "Creature", "Enchantment", "Instant", "Land", "Sorcery")
end

module Booster
  Common   = "common"
  Rare     = "rare"
  Uncommon = "uncommon"
end

module ColorIdentity
  B = "B"
  G = "G"
  R = "R"
  U = "U"
  W = "W"
end

module Color
  Black = "Black"
  Blue  = "Blue"
  Green = "Green"
  Red   = "Red"
  White = "White"
end

module Layout
  Normal = "normal"
end

module LegalityEnum
  Banned     = "Banned"
  Legal      = "Legal"
  Restricted = "Restricted"
end

module Format
  Brawl     = "Brawl"
  Commander = "Commander"
  Legacy    = "Legacy"
  Modern    = "Modern"
  Standard  = "Standard"
  Vintage   = "Vintage"
end

class LegalityElement < Dry::Struct
  attribute :legality_format, Types::Format
  attribute :legality,        Types::LegalityEnum

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      legality_format: d.fetch("format"),
      legality:        d.fetch("legality"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "format"   => @legality_format,
      "legality" => @legality,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Rarity
  BasicLand = "Basic Land"
  Common    = "Common"
  Rare      = "Rare"
  Uncommon  = "Uncommon"
end

class Ruling < Dry::Struct
  attribute :date, Types::String
  attribute :text, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      date: d.fetch("date"),
      text: d.fetch("text"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "date" => @date,
      "text" => @text,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Supertype
  Basic = "Basic"
end

module Type
  Artifact    = "Artifact"
  Creature    = "Creature"
  Enchantment = "Enchantment"
  Instant     = "Instant"
  Land        = "Land"
  Sorcery     = "Sorcery"
end

class Card < Dry::Struct
  attribute :artist,         Types::String
  attribute :cmc,            Types::Int
  attribute :id,             Types::String
  attribute :image_name,     Types::String
  attribute :layout,         Types::Layout
  attribute :legalities,     Types.Array(LegalityElement)
  attribute :mana_cost,      Types::String.optional
  attribute :mci_number,     Types::String.optional
  attribute :multiverseid,   Types::Int
  attribute :card_name,      Types::String
  attribute :original_text,  Types::String.optional
  attribute :original_type,  Types::String
  attribute :printings,      Types.Array(Types::String)
  attribute :rarity,         Types::Rarity
  attribute :rulings,        Types.Array(Ruling).optional
  attribute :text,           Types::String.optional
  attribute :card_type,      Types::String
  attribute :types,          Types.Array(Types::Type)
  attribute :reserved,       Types::Bool.optional
  attribute :power,          Types::String.optional
  attribute :subtypes,       Types.Array(Types::String).optional
  attribute :toughness,      Types::String.optional
  attribute :color_identity, Types.Array(Types::ColorIdentity).optional
  attribute :flavor,         Types::String.optional
  attribute :colors,         Types.Array(Types::Color).optional
  attribute :supertypes,     Types.Array(Types::Supertype).optional
  attribute :variations,     Types.Array(Types::Int).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      artist:         d.fetch("artist"),
      cmc:            d.fetch("cmc"),
      id:             d.fetch("id"),
      image_name:     d.fetch("imageName"),
      layout:         d.fetch("layout"),
      legalities:     d.fetch("legalities").map { |x| LegalityElement.from_dynamic!(x) },
      mana_cost:      d["manaCost"],
      mci_number:     d["mciNumber"],
      multiverseid:   d.fetch("multiverseid"),
      card_name:      d.fetch("name"),
      original_text:  d["originalText"],
      original_type:  d.fetch("originalType"),
      printings:      d.fetch("printings"),
      rarity:         d.fetch("rarity"),
      rulings:        d["rulings"]&.map { |x| Ruling.from_dynamic!(x) },
      text:           d["text"],
      card_type:      d.fetch("type"),
      types:          d.fetch("types"),
      reserved:       d["reserved"],
      power:          d["power"],
      subtypes:       d["subtypes"],
      toughness:      d["toughness"],
      color_identity: d["colorIdentity"],
      flavor:         d["flavor"],
      colors:         d["colors"],
      supertypes:     d["supertypes"],
      variations:     d["variations"],
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "artist"        => @artist,
      "cmc"           => @cmc,
      "id"            => @id,
      "imageName"     => @image_name,
      "layout"        => @layout,
      "legalities"    => @legalities.map { |x| x.to_dynamic },
      "manaCost"      => @mana_cost,
      "mciNumber"     => @mci_number,
      "multiverseid"  => @multiverseid,
      "name"          => @card_name,
      "originalText"  => @original_text,
      "originalType"  => @original_type,
      "printings"     => @printings,
      "rarity"        => @rarity,
      "rulings"       => @rulings&.map { |x| x.to_dynamic },
      "text"          => @text,
      "type"          => @card_type,
      "types"         => @types,
      "reserved"      => @reserved,
      "power"         => @power,
      "subtypes"      => @subtypes,
      "toughness"     => @toughness,
      "colorIdentity" => @color_identity,
      "flavor"        => @flavor,
      "colors"        => @colors,
      "supertypes"    => @supertypes,
      "variations"    => @variations,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class LEAExtras < Dry::Struct
  attribute :lea_extras_name,       Types::String
  attribute :code,                  Types::String
  attribute :gatherer_code,         Types::String
  attribute :magic_cards_info_code, Types::String
  attribute :release_date,          Types::String
  attribute :border,                Types::String
  attribute :lea_extras_type,       Types::String
  attribute :booster,               Types.Array(Types::Booster)
  attribute :mkm_name,              Types::String
  attribute :mkm_id,                Types::Int
  attribute :cards,                 Types.Array(Card)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      lea_extras_name:       d.fetch("name"),
      code:                  d.fetch("code"),
      gatherer_code:         d.fetch("gathererCode"),
      magic_cards_info_code: d.fetch("magicCardsInfoCode"),
      release_date:          d.fetch("releaseDate"),
      border:                d.fetch("border"),
      lea_extras_type:       d.fetch("type"),
      booster:               d.fetch("booster"),
      mkm_name:              d.fetch("mkm_name"),
      mkm_id:                d.fetch("mkm_id"),
      cards:                 d.fetch("cards").map { |x| Card.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"               => @lea_extras_name,
      "code"               => @code,
      "gathererCode"       => @gatherer_code,
      "magicCardsInfoCode" => @magic_cards_info_code,
      "releaseDate"        => @release_date,
      "border"             => @border,
      "type"               => @lea_extras_type,
      "booster"            => @booster,
      "mkm_name"           => @mkm_name,
      "mkm_id"             => @mkm_id,
      "cards"              => @cards.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
