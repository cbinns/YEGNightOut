package com.github.cbinns.yegnightout.views;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.widget.Toast;

import com.github.cbinns.yegnightout.R;
import com.github.cbinns.yegnightout.adapters.RestaurantViewAdapter;
import com.github.cbinns.yegnightout.controllers.RestaurantApi;
import com.github.cbinns.yegnightout.models.Restaurant;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class MainActivity extends AppCompatActivity {
    private RecyclerView rv;
    private RestaurantApi restaurantApi;
    private RestaurantViewAdapter restaurantViewAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        rv = (RecyclerView)findViewById(R.id.rv);
        rv.setHasFixedSize(true);

        restaurantViewAdapter = new RestaurantViewAdapter(new ArrayList<Restaurant>(), this);
        rv.setAdapter(restaurantViewAdapter);
        rv.setLayoutManager(new LinearLayoutManager(this));

        initializeRestaurantApi();
    }

    private void initializeRestaurantApi() {
        restaurantApi = new Retrofit.Builder()
                .baseUrl("http://41d0cde4.ngrok.io")
                .addConverterFactory(GsonConverterFactory.create())
                .build()
                .create(RestaurantApi.class);
    }

    @Override
    protected void onResume() {
        super.onResume();

        restaurantApi.getAllRestaurants().enqueue(new Callback<List<Restaurant>>() {
            @Override
            public void onResponse(Call<List<Restaurant>> call, Response<List<Restaurant>> response) {
                //loadingProgressBar.setVisibility(View.GONE);

                restaurantViewAdapter.updateRestaurantList(response.body());
                restaurantViewAdapter.notifyDataSetChanged();
            }

            @Override
            public void onFailure(Call<List<Restaurant>> call, Throwable t) {
                Toast.makeText(MainActivity.this, "Could not retrieve restaurants", Toast.LENGTH_SHORT).show();

               // loadingProgressBar.setVisibility(View.GONE);
            }
        });
    }
}
