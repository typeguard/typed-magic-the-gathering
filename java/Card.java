package io.quicktype;

import java.util.Map;
import com.fasterxml.jackson.annotation.*;

public class Card {
    private String artist;
    private long cmc;
    private String id;
    private String imageName;
    private Layout layout;
    private LegalityElement[] legalities;
    private String manaCost;
    private String mciNumber;
    private long multiverseid;
    private String name;
    private String originalText;
    private String originalType;
    private String[] printings;
    private Rarity rarity;
    private Ruling[] rulings;
    private String text;
    private String type;
    private Type[] types;
    private Boolean reserved;
    private String power;
    private String[] subtypes;
    private String toughness;
    private ColorIdentity[] colorIdentity;
    private String flavor;
    private Color[] colors;
    private Supertype[] supertypes;
    private long[] variations;

    @JsonProperty("artist")
    public String getArtist() { return artist; }
    @JsonProperty("artist")
    public void setArtist(String value) { this.artist = value; }

    @JsonProperty("cmc")
    public long getCmc() { return cmc; }
    @JsonProperty("cmc")
    public void setCmc(long value) { this.cmc = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("imageName")
    public String getImageName() { return imageName; }
    @JsonProperty("imageName")
    public void setImageName(String value) { this.imageName = value; }

    @JsonProperty("layout")
    public Layout getLayout() { return layout; }
    @JsonProperty("layout")
    public void setLayout(Layout value) { this.layout = value; }

    @JsonProperty("legalities")
    public LegalityElement[] getLegalities() { return legalities; }
    @JsonProperty("legalities")
    public void setLegalities(LegalityElement[] value) { this.legalities = value; }

    @JsonProperty("manaCost")
    public String getManaCost() { return manaCost; }
    @JsonProperty("manaCost")
    public void setManaCost(String value) { this.manaCost = value; }

    @JsonProperty("mciNumber")
    public String getMciNumber() { return mciNumber; }
    @JsonProperty("mciNumber")
    public void setMciNumber(String value) { this.mciNumber = value; }

    @JsonProperty("multiverseid")
    public long getMultiverseid() { return multiverseid; }
    @JsonProperty("multiverseid")
    public void setMultiverseid(long value) { this.multiverseid = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("originalText")
    public String getOriginalText() { return originalText; }
    @JsonProperty("originalText")
    public void setOriginalText(String value) { this.originalText = value; }

    @JsonProperty("originalType")
    public String getOriginalType() { return originalType; }
    @JsonProperty("originalType")
    public void setOriginalType(String value) { this.originalType = value; }

    @JsonProperty("printings")
    public String[] getPrintings() { return printings; }
    @JsonProperty("printings")
    public void setPrintings(String[] value) { this.printings = value; }

    @JsonProperty("rarity")
    public Rarity getRarity() { return rarity; }
    @JsonProperty("rarity")
    public void setRarity(Rarity value) { this.rarity = value; }

    @JsonProperty("rulings")
    public Ruling[] getRulings() { return rulings; }
    @JsonProperty("rulings")
    public void setRulings(Ruling[] value) { this.rulings = value; }

    @JsonProperty("text")
    public String getText() { return text; }
    @JsonProperty("text")
    public void setText(String value) { this.text = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }

    @JsonProperty("types")
    public Type[] getTypes() { return types; }
    @JsonProperty("types")
    public void setTypes(Type[] value) { this.types = value; }

    @JsonProperty("reserved")
    public Boolean getReserved() { return reserved; }
    @JsonProperty("reserved")
    public void setReserved(Boolean value) { this.reserved = value; }

    @JsonProperty("power")
    public String getPower() { return power; }
    @JsonProperty("power")
    public void setPower(String value) { this.power = value; }

    @JsonProperty("subtypes")
    public String[] getSubtypes() { return subtypes; }
    @JsonProperty("subtypes")
    public void setSubtypes(String[] value) { this.subtypes = value; }

    @JsonProperty("toughness")
    public String getToughness() { return toughness; }
    @JsonProperty("toughness")
    public void setToughness(String value) { this.toughness = value; }

    @JsonProperty("colorIdentity")
    public ColorIdentity[] getColorIdentity() { return colorIdentity; }
    @JsonProperty("colorIdentity")
    public void setColorIdentity(ColorIdentity[] value) { this.colorIdentity = value; }

    @JsonProperty("flavor")
    public String getFlavor() { return flavor; }
    @JsonProperty("flavor")
    public void setFlavor(String value) { this.flavor = value; }

    @JsonProperty("colors")
    public Color[] getColors() { return colors; }
    @JsonProperty("colors")
    public void setColors(Color[] value) { this.colors = value; }

    @JsonProperty("supertypes")
    public Supertype[] getSupertypes() { return supertypes; }
    @JsonProperty("supertypes")
    public void setSupertypes(Supertype[] value) { this.supertypes = value; }

    @JsonProperty("variations")
    public long[] getVariations() { return variations; }
    @JsonProperty("variations")
    public void setVariations(long[] value) { this.variations = value; }
}
