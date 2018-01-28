package com.github.cbinns.yegnightout.views;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;
import android.widget.Toast;

import com.github.cbinns.yegnightout.R;
import com.github.cbinns.yegnightout.controllers.SpecialApi;
import com.github.cbinns.yegnightout.models.Special;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class DetailActivity extends AppCompatActivity {
    public static final String EXTRA_RESTAURANT_NAME = "DetailActivity.Restaurant";
    private String name;
    private TextView tName;
    private TextView specials;
    private SpecialApi specialApi;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.detail_view);

        this.name = (String) getIntent().getSerializableExtra(EXTRA_RESTAURANT_NAME);

        this.tName = (TextView) findViewById(R.id.name);
        this.specials = (TextView) findViewById(R.id.restaurantSpecials);

        this.tName.setText(name);

        initializeSpecialApi();
    }

    private void initializeSpecialApi() {
        specialApi = new Retrofit.Builder()
                .baseUrl("http://41d0cde4.ngrok.io")
                .addConverterFactory(GsonConverterFactory.create())
                .build()
                .create(SpecialApi.class);
    }

    @Override
    protected void onResume() {
        super.onResume();

        specialApi.getSpecial(this.name).enqueue(new Callback<List<Special>>() {

            @Override
            public void onResponse(Call<List<Special>> call, Response<List<Special>> response) {
                //loadingProgressBar.setVisibility(View.GONE);


                for (Special special: response.body()) {
                    Log.i("HI", special.getDescription());
                }
            }

            @Override
            public void onFailure(Call<List<Special>> call, Throwable t) {
                Toast.makeText(DetailActivity.this, "Could not retrieve specials", Toast.LENGTH_SHORT).show();

                //loadingProgressBar.setVisibility(View.GONE);
            }
        });
    }
}
