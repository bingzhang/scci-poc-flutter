package com.uiuc.profile;

import android.os.Bundle;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.mapsindoors.mapssdk.Location;
import com.mapsindoors.mapssdk.MapControl;
import com.mapsindoors.mapssdk.MapsIndoors;
import com.mapsindoors.mapssdk.dbglog;

import androidx.fragment.app.FragmentActivity;

public class MapsIndoorsActivity extends FragmentActivity {
    public static final String TAG = MapsIndoorsActivity.class.getSimpleName();

    private SupportMapFragment mapFragment;
    private GoogleMap mGoogleMap;
    private MapControl myMapControl;

    private static final LatLng BUILDING_LOCATION = new LatLng(57.08585, 9.95751);

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

    private void initMapFragment() {
        mapFragment = ((SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.map_fragment));
        if (mapFragment != null) {
            mapFragment.getMapAsync(googleMap -> {
                mGoogleMap = googleMap;
                mGoogleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(BUILDING_LOCATION, 13.0f));
                setupMapsIndoors();
            });
        }
    }

    private void setupMapsIndoors() {
        myMapControl = new MapControl(this);
        myMapControl.setGoogleMap(mGoogleMap, mapFragment.getView());
        myMapControl.setOnMarkerClickListener(marker -> {
            final Location loc = myMapControl.getLocation(marker);
            if (loc != null) {
                marker.showInfoWindow();
            }
            return true;
        });
        myMapControl.init(error -> {
            if (error == null) {
                runOnUiThread(() -> {
                    myMapControl.selectFloor(0);
                    mGoogleMap.animateCamera(CameraUpdateFactory.newLatLngZoom(BUILDING_LOCATION, 17f));
                });
            }
        });
    }

    private void init() {
        MapsIndoors.initialize(
                getApplicationContext(),
                getString(R.string.mapsindoors_api_key)
        );
        MapsIndoors.setGoogleAPIKey(getString(R.string.google_maps_api_key));
    }
}
