package io.quicktype;

import java.util.Map;
import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Type {
    ARTIFACT, CREATURE, ENCHANTMENT, INSTANT, LAND, SORCERY;

    @JsonValue
    public String toValue() {
        switch (this) {
        case ARTIFACT: return "Artifact";
        case CREATURE: return "Creature";
        case ENCHANTMENT: return "Enchantment";
        case INSTANT: return "Instant";
        case LAND: return "Land";
        case SORCERY: return "Sorcery";
        }
        return null;
    }

    @JsonCreator
    public static Type forValue(String value) throws IOException {
        if (value.equals("Artifact")) return ARTIFACT;
        if (value.equals("Creature")) return CREATURE;
        if (value.equals("Enchantment")) return ENCHANTMENT;
        if (value.equals("Instant")) return INSTANT;
        if (value.equals("Land")) return LAND;
        if (value.equals("Sorcery")) return SORCERY;
        throw new IOException("Cannot deserialize Type");
    }
}
