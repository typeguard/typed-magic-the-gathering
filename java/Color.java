package io.quicktype;

import java.util.Map;
import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Color {
    BLACK, BLUE, GREEN, RED, WHITE;

    @JsonValue
    public String toValue() {
        switch (this) {
        case BLACK: return "Black";
        case BLUE: return "Blue";
        case GREEN: return "Green";
        case RED: return "Red";
        case WHITE: return "White";
        }
        return null;
    }

    @JsonCreator
    public static Color forValue(String value) throws IOException {
        if (value.equals("Black")) return BLACK;
        if (value.equals("Blue")) return BLUE;
        if (value.equals("Green")) return GREEN;
        if (value.equals("Red")) return RED;
        if (value.equals("White")) return WHITE;
        throw new IOException("Cannot deserialize Color");
    }
}
