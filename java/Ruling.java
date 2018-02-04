package io.quicktype;

import java.util.Map;
import com.fasterxml.jackson.annotation.*;

public class Ruling {
    private String date;
    private String text;

    @JsonProperty("date")
    public String getDate() { return date; }
    @JsonProperty("date")
    public void setDate(String value) { this.date = value; }

    @JsonProperty("text")
    public String getText() { return text; }
    @JsonProperty("text")
    public void setText(String value) { this.text = value; }
}
