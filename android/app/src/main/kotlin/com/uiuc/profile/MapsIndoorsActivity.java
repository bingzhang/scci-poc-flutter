package com.uiuc.profile;

import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.View;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.mapsindoors.mapssdk.Location;
import com.mapsindoors.mapssdk.MPDirectionsRenderer;
import com.mapsindoors.mapssdk.MPRoutingProvider;
import com.mapsindoors.mapssdk.MapControl;
import com.mapsindoors.mapssdk.MapsIndoors;
import com.mapsindoors.mapssdk.Point;
import com.mapsindoors.mapssdk.RoutingProvider;
import com.mapsindoors.mapssdk.TravelMode;
import com.mapsindoors.mapssdk.dbglog;

import androidx.fragment.app.FragmentActivity;

public class MapsIndoorsActivity extends FragmentActivity {
    public static final String TAG = MapsIndoorsActivity.class.getSimpleName();

    private SupportMapFragment mapFragment;
    private GoogleMap googleMap;
    private MapControl mapControl;
    private RoutingProvider routingProvider;
    private MPDirectionsRenderer routingRenderer;

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

    public void onNextClicked(View view) {
        //TODO:
    }

    public void onPreviousClicked(View view) {
        //TODO:
    }

    private void init() {
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
                setupMapsIndoors();
            });
        }
    }

    private void setupMapsIndoors() {
        routingProvider = new MPRoutingProvider();
        mapControl = new MapControl(this);
        mapControl.setGoogleMap(googleMap, mapFragment.getView());
        routingRenderer = new MPDirectionsRenderer(this, googleMap, mapControl, null);
        mapControl.setOnMarkerClickListener(marker -> {
            final Location loc = mapControl.getLocation(marker);
            if (loc != null) {
                marker.showInfoWindow();
            }
            return true;
        });
        mapControl.init(error -> {
            if (error == null) {
                runOnUiThread(() -> {
                    mapControl.selectFloor(0);
                    googleMap.animateCamera(CameraUpdateFactory.newLatLngZoom(BUILDING_LOCATION, 17f));

                    // Animate route after 2 seconds
                    new Handler(getMainLooper()).postDelayed(this::routing, 2000);
                });
            }
        });
    }

    private void routing() {
        routingProvider.setTravelMode(TravelMode.TRAVEL_MODE_BICYCLING);
        routingProvider.setOnRouteResultListener((route, error) -> {
            if (route != null) {
                routingRenderer.setRoute(route);
                runOnUiThread(() -> routingRenderer.setRouteLegIndex(0));
            }
        });
        Point origin = new Point(57.084171, 9.956732);
        Point destination = new Point(57.08603248579481, 9.958068568122826);
        routingProvider.query(origin, destination);
    }
}
