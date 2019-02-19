package com.uiuc.profile

import android.content.Intent
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val nativeChannel = "com.uiuc.profile/native_call"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, nativeChannel).setMethodCallHandler { methodCall, result ->
            if (methodCall.method == "indoorMaps") {
                launchIndoorMaps()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun launchIndoorMaps() {
        val intent = Intent(this, MapsIndoorsActivity::class.java)
        startActivity(intent)
    }

}
