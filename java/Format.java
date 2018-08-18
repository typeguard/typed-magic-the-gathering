package io.quicktype;

import java.util.Map;
import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Format {
    BRAWL, COMMANDER, LEGACY, MODERN, STANDARD, VINTAGE;

    @JsonValue
    public String toValue() {
        switch (this) {
        case BRAWL: return "Brawl";
        case COMMANDER: return "Commander";
        case LEGACY: return "Legacy";
        case MODERN: return "Modern";
        case STANDARD: return "Standard";
        case VINTAGE: return "Vintage";
        }
        return null;
    }

    @JsonCreator
    public static Format forValue(String value) throws IOException {
        if (value.equals("Brawl")) return BRAWL;
        if (value.equals("Commander")) return COMMANDER;
        if (value.equals("Legacy")) return LEGACY;
        if (value.equals("Modern")) return MODERN;
        if (value.equals("Standard")) return STANDARD;
        if (value.equals("Vintage")) return VINTAGE;
        throw new IOException("Cannot deserialize Format");
    }
}
