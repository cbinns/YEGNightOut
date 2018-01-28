package com.github.cbinns.yegnightout.holders;

import android.content.Intent;
import android.support.v7.widget.CardView;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.github.cbinns.yegnightout.views.DetailActivity;
import com.github.cbinns.yegnightout.R;

import java.util.Random;

/**
 * Created by Daniel on 2018-01-27.
 */

public class RestaurantViewHolder extends RecyclerView.ViewHolder {

    public CardView cv;
    public TextView name;
    public TextView address;
    public ImageView restaurantImage;

    public RestaurantViewHolder(View itemView) {
        super(itemView);
        itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                TextView name = (TextView) view.findViewById(R.id.name);
                String id = name.getText().toString();
                Intent restaurantDetails = new Intent(view.getContext(), DetailActivity.class);
                restaurantDetails.putExtra(DetailActivity.EXTRA_RESTAURANT_NAME, id);
                view.getContext().startActivity((restaurantDetails));
            }
        });

        cv = (CardView)itemView.findViewById(R.id.cardView);
        restaurantImage = (ImageView)itemView.findViewById(R.id.restaurantImage);
        name = (TextView)itemView.findViewById(R.id.name);
        address = (TextView)itemView.findViewById(R.id.address);

        // Set restaurant image to a random colour
        Random rand = new Random();
        int value = rand.nextInt(4) + 1;
        Log.i("value", Integer.toString(value));
        switch (value) {
            case 1:
                restaurantImage.setImageResource(R.drawable.orange_background);
                break;
            case 2:
                restaurantImage.setImageResource(R.drawable.blue_background);
                break;
            case 3:
                restaurantImage.setImageResource(R.drawable.green_background);
                break;
            case 4:
                restaurantImage.setImageResource(R.drawable.dark_orange_background);
                break;
        }
    }
}