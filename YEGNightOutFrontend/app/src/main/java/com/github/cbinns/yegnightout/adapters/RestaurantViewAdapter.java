package com.github.cbinns.yegnightout.adapters;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.github.cbinns.yegnightout.R;
import com.github.cbinns.yegnightout.holders.RestaurantViewHolder;
import com.github.cbinns.yegnightout.models.Restaurant;

import java.util.ArrayList;

public class RestaurantViewAdapter extends RecyclerView.Adapter<RestaurantViewHolder> {

    private ArrayList<Restaurant> restaurants;
    private Context context;

    public RestaurantViewAdapter(ArrayList<Restaurant> restaurantArrayList, Context context) {
        this.restaurants = restaurantArrayList;
        this.context = context;
    }

    @Override
    public RestaurantViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        //Inflate the layout, initialize the View Holder
        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.card_view, parent, false);
        RestaurantViewHolder holder = new RestaurantViewHolder(v);
        return holder;
    }

    @Override
    public void onBindViewHolder(RestaurantViewHolder holder, int position) {
        //Use the provided View Holder on the onCreateViewHolder method to populate the current row on the RecyclerView
        holder.name.setText(restaurants.get(position).getName());
        holder.address.setText(restaurants.get(position).getAddress());

        //animate(holder);
    }

    @Override
    public int getItemCount() {
        //returns the number of elements the RecyclerView will display
        return restaurants.size();
    }

    @Override
    public void onAttachedToRecyclerView(RecyclerView recyclerView) {
        super.onAttachedToRecyclerView(recyclerView);
    }

    // Insert a new item to the RecyclerView on a predefined position
    public void insert(int position, Restaurant restaurant) {
        restaurants.add(position, restaurant);
        notifyItemInserted(position);
    }

    // Remove a RecyclerView item containing a specified Data object
    public void remove(Restaurant restaurant) {
        int position = restaurants.indexOf(restaurant);
        restaurants.remove(position);
        notifyItemRemoved(position);
    }
}