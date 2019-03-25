/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

package com.uiuc.profile

import android.content.Intent
import android.os.Bundle
import com.uiuc.profile.ui.food_and_merch.FoodAndMerchActivity
import com.uiuc.profile.ui.maps.MapsIndoorsActivity
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
            when {
                methodCall.method == "indoorMaps" -> {
                    launchIndoorMaps(methodCall)
                    result.success(null)
                }
                methodCall.method == "language" -> result.success(getLanguage())
                methodCall.method == "foodAndMerch" -> {
                    launchFnMSdk()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun launchIndoorMaps(methodCall: MethodCall) {
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

    private fun launchFnMSdk() {
        val intent = Intent(this, FoodAndMerchActivity::class.java)
        startActivity(intent)
    }
}
