package io.quicktype;

import java.util.Map;
import com.fasterxml.jackson.annotation.*;

public class LegalityElement {
    private Format format;
    private LegalityEnum legality;

    @JsonProperty("format")
    public Format getFormat() { return format; }
    @JsonProperty("format")
    public void setFormat(Format value) { this.format = value; }

    @JsonProperty("legality")
    public LegalityEnum getLegality() { return legality; }
    @JsonProperty("legality")
    public void setLegality(LegalityEnum value) { this.legality = value; }
}
