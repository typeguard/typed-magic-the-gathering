package io.quicktype;

import java.util.Map;
import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum ColorIdentity {
    B, G, R, U, W;

    @JsonValue
    public String toValue() {
        switch (this) {
        case B: return "B";
        case G: return "G";
        case R: return "R";
        case U: return "U";
        case W: return "W";
        }
        return null;
    }

    @JsonCreator
    public static ColorIdentity forValue(String value) throws IOException {
        if (value.equals("B")) return B;
        if (value.equals("G")) return G;
        if (value.equals("R")) return R;
        if (value.equals("U")) return U;
        if (value.equals("W")) return W;
        throw new IOException("Cannot deserialize ColorIdentity");
    }
}
