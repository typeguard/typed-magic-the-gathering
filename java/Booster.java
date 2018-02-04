package io.quicktype;

import java.util.Map;
import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Booster {
    COMMON, RARE, UNCOMMON;

    @JsonValue
    public String toValue() {
        switch (this) {
        case COMMON: return "common";
        case RARE: return "rare";
        case UNCOMMON: return "uncommon";
        }
        return null;
    }

    @JsonCreator
    public static Booster forValue(String value) throws IOException {
        if (value.equals("common")) return COMMON;
        if (value.equals("rare")) return RARE;
        if (value.equals("uncommon")) return UNCOMMON;
        throw new IOException("Cannot deserialize Booster");
    }
}
