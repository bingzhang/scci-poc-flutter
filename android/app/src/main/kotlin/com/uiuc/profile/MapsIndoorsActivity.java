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
import com.mapsindoors.mapssdk.MPDirectionsRenderer;
import com.mapsindoors.mapssdk.MPRoutingProvider;
import com.mapsindoors.mapssdk.MapControl;
import com.mapsindoors.mapssdk.MapsIndoors;
import com.mapsindoors.mapssdk.Point;
import com.mapsindoors.mapssdk.Route;
import com.mapsindoors.mapssdk.RouteLeg;
import com.mapsindoors.mapssdk.RouteStep;
import com.mapsindoors.mapssdk.RoutingProvider;
import com.mapsindoors.mapssdk.dbglog;
import com.mapsindoors.mapssdk.errors.MIError;

import java.util.List;

import androidx.fragment.app.FragmentActivity;

public class MapsIndoorsActivity extends FragmentActivity {
    private static final String TAG = MapsIndoorsActivity.class.getSimpleName();

    private SupportMapFragment mapFragment;

    private GoogleMap googleMap;
    private MapControl mapControl;
    private RoutingProvider routingProvider;
    private MPDirectionsRenderer directionsRenderer;
    private Route currentRoute;

    private String userName;
    private Marker userMarker;

    private static final LatLng BUILDING_LOCATION = new LatLng(57.08585, 9.95751);
    private static final LatLng INITIAL_USER_LOCATION = new LatLng(57.087210, 9.958428);
    private static final LatLng DESTINATION_LOCATION = new LatLng(57.08603248579481, 9.958068568122826);

    private int currentLegIndex = 0;
    private int currentStepIndex = 0;

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
        if (currentRoute == null) {
            return;
        }
        List<RouteLeg> routeLegs = currentRoute.getLegs();
        int legsSize = routeLegs.size();
        RouteLeg currentLeg = routeLegs.get(currentLegIndex);
        List<RouteStep> routeSteps = currentLeg.getSteps();
        int stepsSize = routeSteps.size();
        if ((currentStepIndex + 1) < stepsSize) {
            directionsRenderer.setRouteLegIndex(currentLegIndex, currentStepIndex++);
        } else if ((currentLegIndex + 1) < legsSize) {
            currentStepIndex = 0;
            currentLegIndex++;
            directionsRenderer.setRouteLegIndex(currentLegIndex, currentStepIndex++);
        }
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
            mapFragment.getMapAsync(this::didGetMapAsync);
        }
    }

    private void didGetMapAsync(GoogleMap map) {
        googleMap = map;
        googleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(BUILDING_LOCATION, 13.0f));
        setupUserMarker();
        setupMapsIndoors();
    }

    private void setupMapsIndoors() {
        routingProvider = new MPRoutingProvider();
        mapControl = new MapControl(this);
        directionsRenderer = new MPDirectionsRenderer(this, googleMap, mapControl, null);
        mapControl.setGoogleMap(googleMap, mapFragment.getView());
        mapControl.setOnMarkerClickListener(marker -> {
            showMarkerAlertDialog(marker);
            return true;
        });
        mapControl.init(this::mapControlDidInit);
    }

    private void mapControlDidInit(MIError error) {
        if (error == null) {
            runOnUiThread(() -> {
                mapControl.selectFloor(0);
                googleMap.animateCamera(CameraUpdateFactory.newLatLngZoom(BUILDING_LOCATION, 17f));
                buildRouting();
            });
        } else {
            String errorMsg = String.format("MapsIndoors map control 'com.mapsindoors.mapssdk.MapControl' failed to initialize with error:\n%s", error.message);
            showAlertDialog(getString(R.string.alert_dialog_default_title), errorMsg);
            Log.d(TAG, errorMsg);
        }
    }

    private void buildRouting() {
        routingProvider.setOnRouteResultListener((route, error) -> {
            if (route != null) {
                directionsRenderer.setRoute(route);
                currentRoute = route;
            } else {
                showAlertDialog(getString(R.string.alert_dialog_default_title), "Failed to retrieve route");
            }
        });
        Point origin = new Point(INITIAL_USER_LOCATION);
        Point destination = new Point(DESTINATION_LOCATION);
        routingProvider.query(origin, destination);
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
        runOnUiThread(() -> {
            AlertDialog.Builder dialogBuilder = new AlertDialog.Builder(this);
            dialogBuilder.setTitle(title);
            dialogBuilder.setMessage(message);
            dialogBuilder.setPositiveButton("OK", (dialog, which) -> dialog.dismiss());
            AlertDialog alertDialog = dialogBuilder.create();
            alertDialog.show();
        });
    }

}
