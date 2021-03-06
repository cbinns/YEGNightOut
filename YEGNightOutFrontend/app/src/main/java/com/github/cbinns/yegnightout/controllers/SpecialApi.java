package com.github.cbinns.yegnightout.controllers;

import com.github.cbinns.yegnightout.models.Special;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

/**
 * Created by Daniel on 2018-01-27.
 */

public interface SpecialApi {
    @GET("/special/restaurantName/{name}")
    Call<List<Special>> getSpecial(@Path("name") String name);
}