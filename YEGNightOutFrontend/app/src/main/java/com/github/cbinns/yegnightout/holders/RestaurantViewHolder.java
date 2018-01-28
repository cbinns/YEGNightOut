package com.github.cbinns.yegnightout.holders;

import android.content.Intent;
import android.support.v7.widget.CardView;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.github.cbinns.yegnightout.views.DetailActivity;
import com.github.cbinns.yegnightout.R;

/**
 * Created by Daniel on 2018-01-27.
 */

public class RestaurantViewHolder extends RecyclerView.ViewHolder {

    public CardView cv;
    public TextView name;
    public TextView address;

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
        name = (TextView)itemView.findViewById(R.id.name);
        address = (TextView)itemView.findViewById(R.id.address);
    }
}