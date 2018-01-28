package com.github.cbinns.yegnightout.holders;

import android.support.v7.widget.CardView;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.github.cbinns.yegnightout.R;

/**
 * Created by Daniel on 2018-01-27.
 */

public class ViewHolder extends RecyclerView.ViewHolder {

    public CardView cv;
    public TextView name;
    public TextView address;

    public ViewHolder(View itemView) {
        super(itemView);
        cv = (CardView)itemView.findViewById(R.id.cardView);
        name = (TextView)itemView.findViewById(R.id.name);
        address = (TextView)itemView.findViewById(R.id.address);
    }
}