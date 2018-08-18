// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
//
// use generated_module::[object Object];
//
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: [object Object] = serde_json::from_str(&json).unwrap();
// }

extern crate serde_json;

#[derive(Serialize, Deserialize)]
pub struct LeaExtras {
    #[serde(rename = "name")]
    name: String,

    #[serde(rename = "code")]
    code: String,

    #[serde(rename = "gathererCode")]
    gatherer_code: String,

    #[serde(rename = "magicCardsInfoCode")]
    magic_cards_info_code: String,

    #[serde(rename = "releaseDate")]
    release_date: String,

    #[serde(rename = "border")]
    border: String,

    #[serde(rename = "type")]
    lea_extras_type: String,

    #[serde(rename = "booster")]
    booster: Vec<Booster>,

    #[serde(rename = "mkm_name")]
    mkm_name: String,

    #[serde(rename = "mkm_id")]
    mkm_id: i64,

    #[serde(rename = "cards")]
    cards: Vec<Card>,
}

#[derive(Serialize, Deserialize)]
pub struct Card {
    #[serde(rename = "artist")]
    artist: String,

    #[serde(rename = "cmc")]
    cmc: i64,

    #[serde(rename = "id")]
    id: String,

    #[serde(rename = "imageName")]
    image_name: String,

    #[serde(rename = "layout")]
    layout: Layout,

    #[serde(rename = "legalities")]
    legalities: Vec<LegalityElement>,

    #[serde(rename = "manaCost")]
    mana_cost: Option<String>,

    #[serde(rename = "mciNumber")]
    mci_number: Option<String>,

    #[serde(rename = "multiverseid")]
    multiverseid: i64,

    #[serde(rename = "name")]
    name: String,

    #[serde(rename = "originalText")]
    original_text: Option<String>,

    #[serde(rename = "originalType")]
    original_type: String,

    #[serde(rename = "printings")]
    printings: Vec<String>,

    #[serde(rename = "rarity")]
    rarity: Rarity,

    #[serde(rename = "rulings")]
    rulings: Option<Vec<Ruling>>,

    #[serde(rename = "text")]
    text: Option<String>,

    #[serde(rename = "type")]
    card_type: String,

    #[serde(rename = "types")]
    types: Vec<Type>,

    #[serde(rename = "reserved")]
    reserved: Option<bool>,

    #[serde(rename = "power")]
    power: Option<String>,

    #[serde(rename = "subtypes")]
    subtypes: Option<Vec<String>>,

    #[serde(rename = "toughness")]
    toughness: Option<String>,

    #[serde(rename = "colorIdentity")]
    color_identity: Option<Vec<ColorIdentity>>,

    #[serde(rename = "flavor")]
    flavor: Option<String>,

    #[serde(rename = "colors")]
    colors: Option<Vec<Color>>,

    #[serde(rename = "supertypes")]
    supertypes: Option<Vec<Supertype>>,

    #[serde(rename = "variations")]
    variations: Option<Vec<i64>>,
}

#[derive(Serialize, Deserialize)]
pub struct LegalityElement {
    #[serde(rename = "format")]
    format: Format,

    #[serde(rename = "legality")]
    legality: LegalityEnum,
}

#[derive(Serialize, Deserialize)]
pub struct Ruling {
    #[serde(rename = "date")]
    date: String,

    #[serde(rename = "text")]
    text: String,
}

#[derive(Serialize, Deserialize)]
pub enum Booster {
    #[serde(rename = "common")]
    Common,

    #[serde(rename = "rare")]
    Rare,

    #[serde(rename = "uncommon")]
    Uncommon,
}

#[derive(Serialize, Deserialize)]
pub enum ColorIdentity {
    #[serde(rename = "B")]
    B,

    #[serde(rename = "G")]
    G,

    #[serde(rename = "R")]
    R,

    #[serde(rename = "U")]
    U,

    #[serde(rename = "W")]
    W,
}

#[derive(Serialize, Deserialize)]
pub enum Color {
    #[serde(rename = "Black")]
    Black,

    #[serde(rename = "Blue")]
    Blue,

    #[serde(rename = "Green")]
    Green,

    #[serde(rename = "Red")]
    Red,

    #[serde(rename = "White")]
    White,
}

#[derive(Serialize, Deserialize)]
pub enum Layout {
    #[serde(rename = "normal")]
    Normal,
}

#[derive(Serialize, Deserialize)]
pub enum Format {
    #[serde(rename = "Brawl")]
    Brawl,

    #[serde(rename = "Commander")]
    Commander,

    #[serde(rename = "Legacy")]
    Legacy,

    #[serde(rename = "Modern")]
    Modern,

    #[serde(rename = "Standard")]
    Standard,

    #[serde(rename = "Vintage")]
    Vintage,
}

#[derive(Serialize, Deserialize)]
pub enum LegalityEnum {
    #[serde(rename = "Banned")]
    Banned,

    #[serde(rename = "Legal")]
    Legal,

    #[serde(rename = "Restricted")]
    Restricted,
}

#[derive(Serialize, Deserialize)]
pub enum Rarity {
    #[serde(rename = "Basic Land")]
    BasicLand,

    #[serde(rename = "Common")]
    Common,

    #[serde(rename = "Rare")]
    Rare,

    #[serde(rename = "Uncommon")]
    Uncommon,
}

#[derive(Serialize, Deserialize)]
pub enum Supertype {
    #[serde(rename = "Basic")]
    Basic,
}

#[derive(Serialize, Deserialize)]
pub enum Type {
    #[serde(rename = "Artifact")]
    Artifact,

    #[serde(rename = "Creature")]
    Creature,

    #[serde(rename = "Enchantment")]
    Enchantment,

    #[serde(rename = "Instant")]
    Instant,

    #[serde(rename = "Land")]
    Land,

    #[serde(rename = "Sorcery")]
    Sorcery,
}
