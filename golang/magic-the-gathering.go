// To parse and unparse this JSON data, add this code to your project and do:
//
//    lEAExtras, err := UnmarshalLEAExtras(bytes)
//    bytes, err = lEAExtras.Marshal()

package main

import "encoding/json"

func UnmarshalLEAExtras(data []byte) (LEAExtras, error) {
	var r LEAExtras
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *LEAExtras) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type LEAExtras struct {
	Name               string    `json:"name"`              
	Code               string    `json:"code"`              
	GathererCode       string    `json:"gathererCode"`      
	MagicCardsInfoCode string    `json:"magicCardsInfoCode"`
	ReleaseDate        string    `json:"releaseDate"`       
	Border             string    `json:"border"`            
	Type               string    `json:"type"`              
	Booster            []Booster `json:"booster"`           
	MkmName            string    `json:"mkm_name"`          
	MkmID              int64     `json:"mkm_id"`            
	Cards              []Card    `json:"cards"`             
}

type Card struct {
	Artist        string            `json:"artist"`                
	Cmc           int64             `json:"cmc"`                   
	ID            string            `json:"id"`                    
	ImageName     string            `json:"imageName"`             
	Layout        Layout            `json:"layout"`                
	Legalities    []LegalityElement `json:"legalities"`            
	ManaCost      *string           `json:"manaCost,omitempty"`    
	MciNumber     *string           `json:"mciNumber,omitempty"`   
	Multiverseid  int64             `json:"multiverseid"`          
	Name          string            `json:"name"`                  
	OriginalText  *string           `json:"originalText,omitempty"`
	OriginalType  string            `json:"originalType"`          
	Printings     []string          `json:"printings"`             
	Rarity        Rarity            `json:"rarity"`                
	Rulings       []Ruling          `json:"rulings"`               
	Text          *string           `json:"text,omitempty"`        
	Type          string            `json:"type"`                  
	Types         []Type            `json:"types"`                 
	Reserved      *bool             `json:"reserved,omitempty"`    
	Power         *string           `json:"power,omitempty"`       
	Subtypes      []string          `json:"subtypes"`              
	Toughness     *string           `json:"toughness,omitempty"`   
	ColorIdentity []ColorIdentity   `json:"colorIdentity"`         
	Flavor        *string           `json:"flavor,omitempty"`      
	Colors        []Color           `json:"colors"`                
	Supertypes    []Supertype       `json:"supertypes"`            
	Variations    []int64           `json:"variations"`            
}

type LegalityElement struct {
	Format   Format       `json:"format"`  
	Legality LegalityEnum `json:"legality"`
}

type Ruling struct {
	Date string `json:"date"`
	Text string `json:"text"`
}

type Booster string
const (
	Common Booster = "common"
	Rare Booster = "rare"
	Uncommon Booster = "uncommon"
)

type ColorIdentity string
const (
	B ColorIdentity = "B"
	G ColorIdentity = "G"
	R ColorIdentity = "R"
	U ColorIdentity = "U"
	W ColorIdentity = "W"
)

type Color string
const (
	Black Color = "Black"
	Blue Color = "Blue"
	Green Color = "Green"
	Red Color = "Red"
	White Color = "White"
)

type Layout string
const (
	Normal Layout = "normal"
)

type Format string
const (
	Brawl Format = "Brawl"
	Commander Format = "Commander"
	Legacy Format = "Legacy"
	Modern Format = "Modern"
	Standard Format = "Standard"
	Vintage Format = "Vintage"
)

type LegalityEnum string
const (
	Banned LegalityEnum = "Banned"
	Legal LegalityEnum = "Legal"
	Restricted LegalityEnum = "Restricted"
)

type Rarity string
const (
	BasicLand Rarity = "Basic Land"
	RarityCommon Rarity = "Common"
	RarityRare Rarity = "Rare"
	RarityUncommon Rarity = "Uncommon"
)

type Supertype string
const (
	Basic Supertype = "Basic"
)

type Type string
const (
	Artifact Type = "Artifact"
	Creature Type = "Creature"
	Enchantment Type = "Enchantment"
	Instant Type = "Instant"
	Land Type = "Land"
	Sorcery Type = "Sorcery"
)
