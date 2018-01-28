package com.github.cbinns.yegnightout.models;

/**
 * Created by Abinsi on 1/27/2018.
 */

public class Special {
    private String day;
    private String deal;

    public Special(){
        // tada; default values
        this.day="No day";
        this.deal="No Deal 4 u";
    }

    public Special(String day, String deal){
        this.day=day;
        this.deal=deal;
    }

    public String getDay() {
        return day;
    }

    public String getDeal() {
        return deal;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public void setDeal(String deal) {
        this.deal = deal;
    }
}
