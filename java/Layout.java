package io.quicktype;

import java.util.Map;
import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Layout {
    NORMAL;

    @JsonValue
    public String toValue() {
        switch (this) {
        case NORMAL: return "normal";
        }
        return null;
    }

    @JsonCreator
    public static Layout forValue(String value) throws IOException {
        if (value.equals("normal")) return NORMAL;
        throw new IOException("Cannot deserialize Layout");
    }
}
