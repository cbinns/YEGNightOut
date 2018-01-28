package com.github.cbinns.yegnightout.views;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;

import com.github.cbinns.yegnightout.R;
import com.github.cbinns.yegnightout.adapters.RestaurantViewAdapter;
import com.github.cbinns.yegnightout.models.Restaurant;
import com.github.cbinns.yegnightout.models.Special;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    RecyclerView rv;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        rv = (RecyclerView)findViewById(R.id.rv);
        rv.setHasFixedSize(true);

        ArrayList<Special> spec = new ArrayList<>();
        spec.add(new Special());
        ArrayList<Restaurant> rest = new ArrayList<>();

        rest.add(new Restaurant(1, "Boston Pizza", "234324 street", spec));
        rest.add(new Restaurant(1, "Boston Pizza 2", "234324 street", spec));
        rest.add(new Restaurant(1, "Boston Pizza 3", "234324 street", spec));
        rest.add(new Restaurant(1, "Boston Pizza 4", "234324 street", spec));
        rest.add(new Restaurant(1, "Boston Pizza 5", "234324 street", spec));

        RestaurantViewAdapter adapter = new RestaurantViewAdapter(rest, getApplication());
        rv.setAdapter(adapter);
        rv.setLayoutManager(new LinearLayoutManager(this));
    }
}
