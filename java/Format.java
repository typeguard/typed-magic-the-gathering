package io.quicktype;

import java.util.Map;
import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Format {
    AMONKHET_BLOCK, BATTLE_FOR_ZENDIKAR_BLOCK, COMMANDER, ICE_AGE_BLOCK, INNISTRAD_BLOCK, INVASION_BLOCK, IXALAN_BLOCK, KALADESH_BLOCK, KAMIGAWA_BLOCK, KHANS_OF_TARKIR_BLOCK, LEGACY, LORWYN_SHADOWMOOR_BLOCK, MASQUES_BLOCK, MIRAGE_BLOCK, MIRRODIN_BLOCK, MODERN, ODYSSEY_BLOCK, ONSLAUGHT_BLOCK, RAVNICA_BLOCK, RETURN_TO_RAVNICA_BLOCK, SCARS_OF_MIRRODIN_BLOCK, SHADOWS_OVER_INNISTRAD_BLOCK, SHARDS_OF_ALARA_BLOCK, STANDARD, TEMPEST_BLOCK, THEROS_BLOCK, TIME_SPIRAL_BLOCK, UN_SETS, URZA_BLOCK, VINTAGE, ZENDIKAR_BLOCK;

    @JsonValue
    public String toValue() {
        switch (this) {
        case AMONKHET_BLOCK: return "Amonkhet Block";
        case BATTLE_FOR_ZENDIKAR_BLOCK: return "Battle for Zendikar Block";
        case COMMANDER: return "Commander";
        case ICE_AGE_BLOCK: return "Ice Age Block";
        case INNISTRAD_BLOCK: return "Innistrad Block";
        case INVASION_BLOCK: return "Invasion Block";
        case IXALAN_BLOCK: return "Ixalan Block";
        case KALADESH_BLOCK: return "Kaladesh Block";
        case KAMIGAWA_BLOCK: return "Kamigawa Block";
        case KHANS_OF_TARKIR_BLOCK: return "Khans of Tarkir Block";
        case LEGACY: return "Legacy";
        case LORWYN_SHADOWMOOR_BLOCK: return "Lorwyn-Shadowmoor Block";
        case MASQUES_BLOCK: return "Masques Block";
        case MIRAGE_BLOCK: return "Mirage Block";
        case MIRRODIN_BLOCK: return "Mirrodin Block";
        case MODERN: return "Modern";
        case ODYSSEY_BLOCK: return "Odyssey Block";
        case ONSLAUGHT_BLOCK: return "Onslaught Block";
        case RAVNICA_BLOCK: return "Ravnica Block";
        case RETURN_TO_RAVNICA_BLOCK: return "Return to Ravnica Block";
        case SCARS_OF_MIRRODIN_BLOCK: return "Scars of Mirrodin Block";
        case SHADOWS_OVER_INNISTRAD_BLOCK: return "Shadows over Innistrad Block";
        case SHARDS_OF_ALARA_BLOCK: return "Shards of Alara Block";
        case STANDARD: return "Standard";
        case TEMPEST_BLOCK: return "Tempest Block";
        case THEROS_BLOCK: return "Theros Block";
        case TIME_SPIRAL_BLOCK: return "Time Spiral Block";
        case UN_SETS: return "Un-Sets";
        case URZA_BLOCK: return "Urza Block";
        case VINTAGE: return "Vintage";
        case ZENDIKAR_BLOCK: return "Zendikar Block";
        }
        return null;
    }

    @JsonCreator
    public static Format forValue(String value) throws IOException {
        if (value.equals("Amonkhet Block")) return AMONKHET_BLOCK;
        if (value.equals("Battle for Zendikar Block")) return BATTLE_FOR_ZENDIKAR_BLOCK;
        if (value.equals("Commander")) return COMMANDER;
        if (value.equals("Ice Age Block")) return ICE_AGE_BLOCK;
        if (value.equals("Innistrad Block")) return INNISTRAD_BLOCK;
        if (value.equals("Invasion Block")) return INVASION_BLOCK;
        if (value.equals("Ixalan Block")) return IXALAN_BLOCK;
        if (value.equals("Kaladesh Block")) return KALADESH_BLOCK;
        if (value.equals("Kamigawa Block")) return KAMIGAWA_BLOCK;
        if (value.equals("Khans of Tarkir Block")) return KHANS_OF_TARKIR_BLOCK;
        if (value.equals("Legacy")) return LEGACY;
        if (value.equals("Lorwyn-Shadowmoor Block")) return LORWYN_SHADOWMOOR_BLOCK;
        if (value.equals("Masques Block")) return MASQUES_BLOCK;
        if (value.equals("Mirage Block")) return MIRAGE_BLOCK;
        if (value.equals("Mirrodin Block")) return MIRRODIN_BLOCK;
        if (value.equals("Modern")) return MODERN;
        if (value.equals("Odyssey Block")) return ODYSSEY_BLOCK;
        if (value.equals("Onslaught Block")) return ONSLAUGHT_BLOCK;
        if (value.equals("Ravnica Block")) return RAVNICA_BLOCK;
        if (value.equals("Return to Ravnica Block")) return RETURN_TO_RAVNICA_BLOCK;
        if (value.equals("Scars of Mirrodin Block")) return SCARS_OF_MIRRODIN_BLOCK;
        if (value.equals("Shadows over Innistrad Block")) return SHADOWS_OVER_INNISTRAD_BLOCK;
        if (value.equals("Shards of Alara Block")) return SHARDS_OF_ALARA_BLOCK;
        if (value.equals("Standard")) return STANDARD;
        if (value.equals("Tempest Block")) return TEMPEST_BLOCK;
        if (value.equals("Theros Block")) return THEROS_BLOCK;
        if (value.equals("Time Spiral Block")) return TIME_SPIRAL_BLOCK;
        if (value.equals("Un-Sets")) return UN_SETS;
        if (value.equals("Urza Block")) return URZA_BLOCK;
        if (value.equals("Vintage")) return VINTAGE;
        if (value.equals("Zendikar Block")) return ZENDIKAR_BLOCK;
        throw new IOException("Cannot deserialize Format");
    }
}
