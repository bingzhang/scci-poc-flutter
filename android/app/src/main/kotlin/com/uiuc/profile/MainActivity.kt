/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

package com.uiuc.profile

import android.content.Intent
import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.util.*

class MainActivity : FlutterActivity() {
    val EVENT = "event"
    val EVENTS = "events"
    private val nativeChannel = "com.uiuc.profile/native_call"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, nativeChannel).setMethodCallHandler { methodCall, result ->
            if (methodCall.method == "indoorMaps") {
                launchIndoorMaps(methodCall)
                result.success(null)
            }  else if (methodCall.method == "language"){
                result.success(getLanguage())
            }else {
                result.notImplemented()
            }
        }
    }

    private fun launchIndoorMaps(methodCall:  MethodCall) {
        val singleEvent = methodCall.argument<String>(EVENT)
        val events = methodCall.argument<String>(EVENTS)
        val intent = Intent(this, MapsIndoorsActivity::class.java)
        intent.putExtra(EVENT, singleEvent)
        intent.putExtra(EVENTS, events)
        startActivity(intent)
    }

    private fun getLanguage(): String {
        return Locale.getDefault().language
    }
}
