package com.github.cbinns.yegnightout.models;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;

/**
 * Created by Abinsi on 1/27/2018.
 */

public class Restaurant implements Serializable {
    @SerializedName("id")
    private Integer id;
    @SerializedName("name")
    private String name;
    @SerializedName("address")
    private String address;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
