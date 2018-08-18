package io.quicktype;

import java.util.Map;
import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum LegalityEnum {
    BANNED, LEGAL, RESTRICTED;

    @JsonValue
    public String toValue() {
        switch (this) {
        case BANNED: return "Banned";
        case LEGAL: return "Legal";
        case RESTRICTED: return "Restricted";
        }
        return null;
    }

    @JsonCreator
    public static LegalityEnum forValue(String value) throws IOException {
        if (value.equals("Banned")) return BANNED;
        if (value.equals("Legal")) return LEGAL;
        if (value.equals("Restricted")) return RESTRICTED;
        throw new IOException("Cannot deserialize LegalityEnum");
    }
}
