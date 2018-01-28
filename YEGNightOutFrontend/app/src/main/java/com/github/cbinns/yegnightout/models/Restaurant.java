package com.github.cbinns.yegnightout.models;

import java.util.ArrayList;

/**
 * Created by Abinsi on 1/27/2018.
 */

public class Restaurant {
    private int id;
    private String name;
    private String address;
    private ArrayList<Special> specials;

    public Restaurant(int id, String name, String address, ArrayList<Special> specials){
        this.id=id;
        this.name=name;
        this.address=address;
        this.specials=specials;
   }

   public Restaurant(){
        this.id=-1;
        this.name="";
        this.address="";
   }

   public void setName(String name){
       this.name=name;
   }

   public void setId(int id){
       this.id=id;
   }

   public void setAddress(String address){
       this.address=address;
   }

   public void setSpecials(ArrayList<Special> specials) {
       this.specials = specials;
   }

   public int getId() {
       return id;
   }
   public String getName() {
       return name;
   }

   public String getAddress() {
       return address;
   }

    public ArrayList<Special> getSpecials() {
        return specials;
    }
}
