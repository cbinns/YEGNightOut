package com.github.cbinns.yegnightout;

import android.content.Context;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.Toast;

public class DetailActivity extends AppCompatActivity {
    public static final String EXTRA_RESTAURANT_NAME = "DetailActivity.Restaurant";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.detail_view);

        String name = (String) getIntent().getSerializableExtra(EXTRA_RESTAURANT_NAME);

        Context context = getApplicationContext();
        CharSequence text = name;
        int duration = Toast.LENGTH_SHORT;

        Toast toast = Toast.makeText(context, text, duration);
        toast.show();
    }
}
