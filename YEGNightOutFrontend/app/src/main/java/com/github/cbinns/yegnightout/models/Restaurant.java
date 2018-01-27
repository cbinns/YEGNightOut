package com.github.cbinns.yegnightout.models;

/**
 * Created by Abinsi on 1/27/2018.
 */

public class Restaurant {
    private int id;
    private String name;
    private String address;

    public Restaurant(int id, String name, String address){
        this.id=id;
        this.name=name;
        this.address=address;
   }

   public Restaurant(){
        this.id=-1;
        this.name="";
        this.address="";
   }x

   public void setName(String name){
       this.name=name;
   }

   public void setId(int id){
       this.id=id;
   }

   public void setAddress(String address){
       this.address=address;
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
}
