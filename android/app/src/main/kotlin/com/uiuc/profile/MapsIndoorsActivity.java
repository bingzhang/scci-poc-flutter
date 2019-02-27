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
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import com.mapsindoors.mapssdk.Location;
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

import java.util.ArrayList;
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
    private List<Marker> markerList;

    private String userName;

    private static final LatLng BUILDING_LOCATION = new LatLng(57.08585, 9.95751);
    private static final LatLng ORIGIN_LOCATION = new LatLng(57.087210, 9.958428);
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

    @Override
    protected void onStart() {
        super.onStart();
        if (mapControl != null) {
            mapControl.onStart();
        }
    }

    @Override
    protected void onStop() {
        super.onStop();
        if (mapControl != null) {
            mapControl.onStop();
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (mapControl != null) {
            mapControl.onResume();
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        if (mapControl != null) {
            mapControl.onPause();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (mapControl != null) {
            mapControl.onDestroy();
        }
    }

    @Override
    public void onLowMemory() {
        super.onLowMemory();
        if (mapControl != null) {
            mapControl.onLowMemory();
        }
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
        addMarkers();
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
        mapControl.setOnFloorUpdateListener((building, i) -> {
            didFloorUpdate();
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

    private void didFloorUpdate() {
        updateMarkers();
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
        Point originPoint = new Point(ORIGIN_LOCATION);
        Point destinationPoint = new Point(DESTINATION_LOCATION.latitude, DESTINATION_LOCATION.longitude, 1);
        routingProvider.query(originPoint, destinationPoint);
    }

    private void addMarkers() {
        if (markerList == null) {
            markerList = new ArrayList<>();
            Marker userMarkerOrigin = googleMap.addMarker(constructUserMarkerOptions(ORIGIN_LOCATION, userName, R.drawable.maps_icon_male_toilet));
            userMarkerOrigin.setTag(0); //Store floor in tag property
            markerList.add(userMarkerOrigin);
            Marker userMarkerDestination = googleMap.addMarker(constructUserMarkerOptions(DESTINATION_LOCATION, "Study room", R.drawable.maps_icon_study_zone));
            userMarkerDestination.setTag(1); //Store floor in tag property
            markerList.add(userMarkerDestination);

            updateMarkers();
        }
    }

    private void updateMarkers() {
        if (markerList == null || markerList.isEmpty()) {
            return;
        }
        for (Marker marker : markerList) {
            int markerFloorIndex = (marker.getTag() != null) ? (int) marker.getTag() : 0;
            int currentFloorIndex = (mapControl != null) ? mapControl.getCurrentFloorIndex() : 0;
            boolean markerVisible = (markerFloorIndex == currentFloorIndex);
            marker.setVisible(markerVisible);
            if (markerVisible) {
                marker.showInfoWindow();
            } else {
                marker.hideInfoWindow();
            }
        }
    }

    private MarkerOptions constructUserMarkerOptions(LatLng markerLocation, String title, int iconResource) {
        MarkerOptions markerOptions = new MarkerOptions();
        markerOptions.position(markerLocation);
        markerOptions.zIndex(1);
        markerOptions.title(title);
        markerOptions.icon(BitmapDescriptorFactory.fromResource(iconResource));
        markerOptions.visible(false);
        return markerOptions;
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
        double stepFloorDoubleIndex = (currentStep != null && currentStep.getStartLocation() != null) ?
                currentStep.getStartLocation().getzIndex() : 0.0;
        int stepFloorIndex = (int) stepFloorDoubleIndex;
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
        if ((mapControl != null) && (mapControl.getCurrentFloorIndex() != stepFloorIndex)) {
            mapControl.selectFloor(stepFloorIndex);
        }
    }

    private void showMarkerAlertDialog(Marker marker) {
        StringBuilder builder = new StringBuilder();
        builder.append("Marker fields: \n\n");
        builder.append(String.format("Id: %s\n", marker.getId()));
        builder.append(String.format("Title: %s\n", marker.getTitle()));
        builder.append(String.format("IsVisible: %b\n", marker.isVisible()));
        builder.append(String.format("IsDraggable: %b\n", marker.isDraggable()));
        builder.append(String.format("IsFlat: %b\n", marker.isFlat()));
        builder.append(String.format("IsInfoWindowShown: %b\n", marker.isInfoWindowShown()));
        builder.append(String.format("Position: lat %.7f, long %.7f, \n", marker.getPosition().latitude, marker.getPosition().longitude));
        builder.append(String.format("Alpha: %.5f\n", marker.getAlpha()));
        builder.append(String.format("Rotation: %.5f\n", marker.getRotation()));
        builder.append(String.format("Snippet: %s\n", marker.getSnippet()));
        builder.append(String.format("ZIndex: %.5f\n", marker.getZIndex()));
        builder.append(String.format("Tag: %s\n\n", (marker.getTag() != null ? marker.getTag().toString() : "null")));

        Location markerLocation = mapControl.getLocation(marker);
        if (markerLocation != null) {
            builder.append("\nLocation fields:\n\n");
            builder.append(String.format("Id: %s\n", markerLocation.getId()));
            builder.append(String.format("Name: %s\n", markerLocation.getName()));
            builder.append(String.format("FloorIndex: %d\n", markerLocation.getFloorIndex()));
            builder.append(String.format("LatLang: lat%.7f long %.7f\n", markerLocation.getLatLng().longitude, markerLocation.getLatLng().longitude));
            builder.append(String.format("RoomId: %s\n", markerLocation.getRoomId()));
            builder.append(String.format("Type: %s\n", markerLocation.getType()));
            builder.append(String.format("IsVisible: %b\n", markerLocation.isVisible()));
            builder.append(String.format("IsMarkerSetup: %b\n", markerLocation.isMarkerSetup()));
            builder.append(String.format("Geometry: type %s, iType %d\n", markerLocation.getGeometry().getType(), markerLocation.getGeometry().getIType()));
            String[] categories = markerLocation.getCategories();
            StringBuilder categoriesBuilder = new StringBuilder();
            if (categories != null && categories.length > 0) {
                for (int i = 0; i < categories.length; i++) {
                    categoriesBuilder.append(categories[i]);
                    if (i < (categories.length - 1)) {
                        categoriesBuilder.append(", ");
                    }
                }
            }
            builder.append(String.format("Categories: %s\n", categoriesBuilder.toString()));
        }

        showAlertDialog(getString(R.string.poi_details_alert_dialog_title), builder.toString());
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
