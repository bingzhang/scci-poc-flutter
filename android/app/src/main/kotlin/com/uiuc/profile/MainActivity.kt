package com.uiuc.profile

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.StringCodec
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
  private val CHANNEL = "com.uiuc.profile/native_call"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    MethodChannel(flutterView, CHANNEL).setMethodCallHandler(
                      object : MethodCallHandler {
                          override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
                              if(call.method.equals("indoorMaps")) {
                                  launchIndoorMaps()
                              }
                          }
                      })
  }

  private fun launchIndoorMaps() {
    //val intent = Intent(this, SecondActivity::class.java)
    //startActivity(intent)
  }

}
