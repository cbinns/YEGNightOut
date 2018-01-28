package com.github.cbinns.yegnightout.models;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;

/**
 * Created by Abinsi on 1/27/2018.
 */

public class Special implements Serializable {
    @SerializedName("day")
    private String day;
    @SerializedName("description")
    private String description;

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
