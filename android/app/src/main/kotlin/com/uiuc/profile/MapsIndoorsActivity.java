package com.uiuc.profile;

import android.app.AlertDialog;
import android.os.Build;
import android.os.Bundle;
import android.text.Html;
import android.text.Spanned;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

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
    private Button nextButton;
    private Button prevButton;
    private TextView stepsTextView;

    private GoogleMap googleMap;
    private MapControl mapControl;
    private RoutingProvider routingProvider;
    private MPDirectionsRenderer directionsRenderer;
    private Route currentRoute;

    private String userName;

    private static final LatLng BUILDING_LOCATION = new LatLng(57.08585, 9.95751);
    private static final LatLng INITIAL_USER_LOCATION = new LatLng(57.087210, 9.958428);
    private static final LatLng DESTINATION_LOCATION = new LatLng(57.0861893, 9.9578803);

    private int currentLegIndex = 0;
    private int currentStepIndex = -1;

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
            makeNextStep(currentLegIndex, ++currentStepIndex);
        } else if ((currentLegIndex + 1) < legsSize) {
            currentStepIndex = 0;
            currentLegIndex++;
            makeNextStep(currentLegIndex, currentStepIndex);
        }
    }

    public void onPreviousClicked(View view) {
        if (currentRoute == null) {
            return;
        }
        if (currentStepIndex > 0) {
            makeNextStep(currentLegIndex, --currentStepIndex);
        } else if (currentLegIndex > 0) {
            currentLegIndex--;
            List<RouteLeg> routeLegs = currentRoute.getLegs();
            RouteLeg currentLeg = routeLegs.get(currentLegIndex);
            List<RouteStep> routeSteps = currentLeg.getSteps();
            int stepsSize = routeSteps.size();
            currentStepIndex = stepsSize - 1;
            makeNextStep(currentLegIndex, currentStepIndex);
        }
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
        nextButton = findViewById(R.id.nextButton);
        prevButton = findViewById(R.id.prevButton);
        stepsTextView = findViewById(R.id.stepsTextView);
        updateUi();
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
            runOnUiThread(() -> updateUi());
        });
        Point origin = new Point(INITIAL_USER_LOCATION);
        Point destination = new Point(DESTINATION_LOCATION.latitude, DESTINATION_LOCATION.longitude, 1);
        routingProvider.query(origin, destination);
    }

    private void setupUserMarker() {
        Marker userMarker = googleMap.addMarker(constructInitialMarker());
        userMarker.showInfoWindow();
    }

    private MarkerOptions constructInitialMarker() {
        MarkerOptions options = new MarkerOptions()
                .position(INITIAL_USER_LOCATION)
                .title(userName);
        return options;
    }

    private void makeNextStep(int legIndex, int stepIndex) {
        directionsRenderer.setRouteLegIndex(legIndex, stepIndex);
        directionsRenderer.animate(0, true);
        updateUi();
    }

    private void updateUi() {
        boolean isPrevEnabled = (currentLegIndex > 0) || (currentStepIndex > 0);
        int prevBackgroundColorResource = isPrevEnabled ? R.color.step_button_enabled_back_color : R.color.step_button_disabled_back_color;
        int prevTextColorResource = isPrevEnabled ? R.color.step_button_enabled_text_color : R.color.step_button_disabled_text_color;
        if (prevButton != null) {
            prevButton.setEnabled(isPrevEnabled);
            prevButton.setBackgroundResource(prevBackgroundColorResource);
            prevButton.setTextColor(getResources().getColor(prevTextColorResource));
        }
        List<RouteLeg> routeLegs = (currentRoute != null) ? currentRoute.getLegs() : null;
        int legsSize = (routeLegs != null) ? routeLegs.size() : 0;
        RouteLeg currentLeg = (routeLegs != null) ? routeLegs.get(currentLegIndex) : null;
        List<RouteStep> routeSteps = (currentLeg != null) ? currentLeg.getSteps() : null;
        int stepsSize = (routeSteps != null) ? routeSteps.size() : 0;
        RouteStep currentStep = ((routeSteps != null) && (currentStepIndex >= 0) && (currentStepIndex < stepsSize)) ?
                routeSteps.get(currentStepIndex) : null;
        boolean isNextEnabled = (currentRoute != null) &&
                ((currentLegIndex < (legsSize - 1)) || currentStepIndex < (stepsSize - 1));
        int nextBackgroundColorResource = isNextEnabled ? R.color.step_button_enabled_back_color : R.color.step_button_disabled_back_color;
        int nextTextColorResource = isNextEnabled ? R.color.step_button_enabled_text_color : R.color.step_button_disabled_text_color;
        if (nextButton != null) {
            nextButton.setEnabled(isNextEnabled);
            nextButton.setBackgroundResource(nextBackgroundColorResource);
            nextButton.setTextColor(getResources().getColor(nextTextColorResource));
        }
        String stepsText = null;
        Spanned htmlText = null;
        if (currentStep != null) {
            if (currentStep.getHtmlInstructions() != null) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    htmlText = Html.fromHtml(currentStep.getHtmlInstructions(), Html.FROM_HTML_MODE_COMPACT);
                } else {
                    htmlText = Html.fromHtml(currentStep.getHtmlInstructions());
                }
            } else if ((currentStep.getManeuver() != null)) {
                stepsText = String.format("Floor %s | %s | %s", currentStep.getStartFloorname(), currentStep.getHighway(), currentStep.getManeuver());
            }
        }
        if (stepsTextView != null) {
            stepsTextView.setText((htmlText != null) ? htmlText : stepsText);
        }
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
