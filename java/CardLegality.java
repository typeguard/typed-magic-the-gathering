package io.quicktype;

import java.util.Map;
import com.fasterxml.jackson.annotation.*;

public class CardLegality {
    private Format format;
    private LegalityLegality legality;

    @JsonProperty("format")
    public Format getFormat() { return format; }
    @JsonProperty("format")
    public void setFormat(Format value) { this.format = value; }

    @JsonProperty("legality")
    public LegalityLegality getLegality() { return legality; }
    @JsonProperty("legality")
    public void setLegality(LegalityLegality value) { this.legality = value; }
}
