package com.uiuc.profile

import android.os.Bundle
import com.mapsindoors.mapssdk.MapsIndoors

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val nativeChannel = "com.uiuc.profile/native_call"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        initMapsIndoors()
        MethodChannel(flutterView, nativeChannel).setMethodCallHandler { methodCall, result ->
            if (methodCall.method == "indoorMaps") {
                launchIndoorMaps()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun initMapsIndoors() {
        MapsIndoors.initialize(this, getString(R.string.mapsindoors_api_key))
        MapsIndoors.setGoogleAPIKey(getString(R.string.google_maps_api_key))
    }

    private fun launchIndoorMaps() {
        //val intent = Intent(this, SecondActivity::class.java)
        //startActivity(intent)
    }

}
