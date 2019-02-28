/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

package com.uiuc.profile

import android.content.Intent
import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    private val USER_NAME = "user_name"
    private val nativeChannel = "com.uiuc.profile/native_call"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, nativeChannel).setMethodCallHandler { methodCall, result ->
            if (methodCall.method == "indoorMaps") {
                val name = methodCall.argument<String>(USER_NAME);
                launchIndoorMaps(name)
                result.success(null)
            }  else {
                result.notImplemented()
            }
        }
    }

    private fun launchIndoorMaps(name: String? ) {
        val intent = Intent(this, MapsIndoorsActivity::class.java)
        intent.putExtra(USER_NAME, name)
        startActivity(intent)
    }

}
