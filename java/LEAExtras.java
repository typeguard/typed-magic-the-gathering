package io.quicktype;

import java.util.Map;
import com.fasterxml.jackson.annotation.*;

public class LEAExtras {
    private String name;
    private String code;
    private String gathererCode;
    private String magicCardsInfoCode;
    private String releaseDate;
    private String border;
    private String type;
    private Booster[] booster;
    private String mkmName;
    private long mkmID;
    private Card[] cards;

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("code")
    public String getCode() { return code; }
    @JsonProperty("code")
    public void setCode(String value) { this.code = value; }

    @JsonProperty("gathererCode")
    public String getGathererCode() { return gathererCode; }
    @JsonProperty("gathererCode")
    public void setGathererCode(String value) { this.gathererCode = value; }

    @JsonProperty("magicCardsInfoCode")
    public String getMagicCardsInfoCode() { return magicCardsInfoCode; }
    @JsonProperty("magicCardsInfoCode")
    public void setMagicCardsInfoCode(String value) { this.magicCardsInfoCode = value; }

    @JsonProperty("releaseDate")
    public String getReleaseDate() { return releaseDate; }
    @JsonProperty("releaseDate")
    public void setReleaseDate(String value) { this.releaseDate = value; }

    @JsonProperty("border")
    public String getBorder() { return border; }
    @JsonProperty("border")
    public void setBorder(String value) { this.border = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }

    @JsonProperty("booster")
    public Booster[] getBooster() { return booster; }
    @JsonProperty("booster")
    public void setBooster(Booster[] value) { this.booster = value; }

    @JsonProperty("mkm_name")
    public String getMkmName() { return mkmName; }
    @JsonProperty("mkm_name")
    public void setMkmName(String value) { this.mkmName = value; }

    @JsonProperty("mkm_id")
    public long getMkmID() { return mkmID; }
    @JsonProperty("mkm_id")
    public void setMkmID(long value) { this.mkmID = value; }

    @JsonProperty("cards")
    public Card[] getCards() { return cards; }
    @JsonProperty("cards")
    public void setCards(Card[] value) { this.cards = value; }
}
