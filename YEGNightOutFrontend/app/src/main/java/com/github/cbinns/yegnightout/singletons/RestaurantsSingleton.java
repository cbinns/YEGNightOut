package com.github.cbinns.yegnightout.singletons;

import com.github.cbinns.yegnightout.models.Restaurant;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Daniel on 2018-01-28.
 */

public class RestaurantsSingleton {
    private static RestaurantsSingleton instance = null;
    private static List<Restaurant> restaurants = new ArrayList<>();

    protected  RestaurantsSingleton() {
        // Exists only to defeat instantiation
    }

    public static RestaurantsSingleton getInstance() {
        if (instance == null) {
            instance = new RestaurantsSingleton();
        }

        return instance;
    }

    public static List<Restaurant> getRestaurants() {
        return restaurants;
    }

    public static void setRestaurants(List<Restaurant> restaurants) {
        RestaurantsSingleton.restaurants = restaurants;
    }
}
