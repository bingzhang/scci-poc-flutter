package com.uiuc.profile;

import android.os.Bundle;
import android.view.View;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import com.mapsindoors.mapssdk.Location;
import com.mapsindoors.mapssdk.MapControl;
import com.mapsindoors.mapssdk.MapsIndoors;
import com.mapsindoors.mapssdk.dbglog;

import androidx.fragment.app.FragmentActivity;

public class MapsIndoorsActivity extends FragmentActivity {
    private static final String TAG = MapsIndoorsActivity.class.getSimpleName();

    private SupportMapFragment mapFragment;

    private GoogleMap googleMap;
    private MapControl mapControl;

    private String userName;
    private Marker userMarker;

    private static final LatLng BUILDING_LOCATION = new LatLng(57.08585, 9.95751);
    private static final LatLng INITIAL_USER_LOCATION = new LatLng(57.087210, 9.958428);


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.maps_indoors_layout);

        // Enable MapsIndoors debug messages (console)
        {
            dbglog.useDebug(true);
            dbglog.setCustomTagPrefix(TAG + "_");
        }
        init();
        initMapFragment();
    }

    public void onNextClicked(View view) {
        //TODO:
    }

    public void onPreviousClicked(View view) {
        //TODO:
    }

    private void init() {
        userName = getIntent().getExtras().getString("user_name");
        MapsIndoors.initialize(
                getApplicationContext(),
                getString(R.string.mapsindoors_api_key)
        );
        MapsIndoors.setGoogleAPIKey(getString(R.string.google_maps_api_key));
    }

    private void initMapFragment() {
        mapFragment = ((SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.map_fragment));
        if (mapFragment != null) {
            mapFragment.getMapAsync(map -> {
                googleMap = map;
                googleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(BUILDING_LOCATION, 13.0f));
                setupUserMarker();
                setupMapsIndoors();
            });
        }
    }

    private void setupMapsIndoors() {
        mapControl = new MapControl(this);
        mapControl.setGoogleMap(googleMap, mapFragment.getView());
        mapControl.setOnMarkerClickListener(marker -> {
            final Location loc = mapControl.getLocation(marker);
            if (loc != null) {
                marker.showInfoWindow();
            } else if (marker.equals(userMarker)){
                marker.showInfoWindow();
            }
            return true;
        });
        mapControl.init(error -> {
            if (error == null) {
                runOnUiThread(() -> {
                    mapControl.selectFloor(0);
                    googleMap.animateCamera(CameraUpdateFactory.newLatLngZoom(BUILDING_LOCATION, 17f));
                });
            }
        });
    }

    private void setupUserMarker() {
        userMarker = googleMap.addMarker(constructInitialMarker());
        userMarker.showInfoWindow();
    }

    private MarkerOptions constructInitialMarker() {
        MarkerOptions options = new MarkerOptions()
                .position(INITIAL_USER_LOCATION)
                .title(userName);
        return options;
    }

}
