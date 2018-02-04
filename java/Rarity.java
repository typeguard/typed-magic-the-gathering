package io.quicktype;

import java.util.Map;
import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Rarity {
    BASIC_LAND, COMMON, RARE, UNCOMMON;

    @JsonValue
    public String toValue() {
        switch (this) {
        case BASIC_LAND: return "Basic Land";
        case COMMON: return "Common";
        case RARE: return "Rare";
        case UNCOMMON: return "Uncommon";
        }
        return null;
    }

    @JsonCreator
    public static Rarity forValue(String value) throws IOException {
        if (value.equals("Basic Land")) return BASIC_LAND;
        if (value.equals("Common")) return COMMON;
        if (value.equals("Rare")) return RARE;
        if (value.equals("Uncommon")) return UNCOMMON;
        throw new IOException("Cannot deserialize Rarity");
    }
}
