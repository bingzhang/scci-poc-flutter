package com.uiuc.profile;

import android.app.AlertDialog;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
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
            showMarkerAlertDialog(marker);
            return true;
        });
        mapControl.init(error -> {
            if (error == null) {
                runOnUiThread(() -> {
                    mapControl.selectFloor(0);
                    googleMap.animateCamera(CameraUpdateFactory.newLatLngZoom(BUILDING_LOCATION, 17f));
                });
            } else {
                String errorMsg = String.format("MapsIndoors map control 'com.mapsindoors.mapssdk.MapControl' failed to initialize with error:\n%s", error.message);
                Log.d(TAG, errorMsg);
                showAlertDialog(getString(R.string.alert_dialog_default_title), errorMsg);
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

    private void showMarkerAlertDialog(Marker marker) {
        String markerDetailsMsg = String.format("Id: %s\nTitle: %s\nPosition: lat %.7f, long %.7f\nAlpha: %.5f\nRotation: %.5f\nSnippet: %s\nZIndex: %.5f\nTag: %s", marker.getId(), marker.getTitle(), marker.getPosition().latitude, marker.getPosition().longitude, marker.getAlpha(), marker.getRotation(), marker.getSnippet(), marker.getZIndex(), (marker.getTag() != null ? marker.getTag().toString() : "null"));
        showAlertDialog(getString(R.string.poi_details_alert_dialog_title), markerDetailsMsg);
    }

    private void showAlertDialog(String title, String message) {
        AlertDialog.Builder dialogBuilder = new AlertDialog.Builder(this);
        dialogBuilder.setTitle(title);
        dialogBuilder.setMessage(message);
        dialogBuilder.setPositiveButton("OK", (dialog, which) -> dialog.dismiss());
        AlertDialog alertDialog = dialogBuilder.create();
        alertDialog.show();
    }

}
