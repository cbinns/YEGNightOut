package com.github.cbinns.yegnightout.controllers;

import com.github.cbinns.yegnightout.models.Restaurant;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;

/**
 * Created by Daniel on 2018-01-27.
 */

public interface RestaurantApi {
    @GET("/restaurant")
    Call<List<Restaurant>> getAllRestaurants();
}