package io.quicktype;

import java.util.Map;
import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Supertype {
    BASIC;

    @JsonValue
    public String toValue() {
        switch (this) {
        case BASIC: return "Basic";
        }
        return null;
    }

    @JsonCreator
    public static Supertype forValue(String value) throws IOException {
        if (value.equals("Basic")) return BASIC;
        throw new IOException("Cannot deserialize Supertype");
    }
}
