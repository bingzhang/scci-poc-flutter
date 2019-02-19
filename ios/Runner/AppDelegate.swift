import UIKit
import Flutter
import GoogleMaps
import MapsIndoors

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    //TODO KEY must be changed for each client (this is debug key)
    let googleApiKey = "AIzaSyBOyWpp0LBhbaYiQUGUbc_YLcW8pRoA5Sc";
    let mapsIndoorsKey = "56616c7bf5934092acfe0660"; // "57e4e4992e74800ef8b69718"
    GMSServices.provideAPIKey(googleApiKey);
    MapsIndoors.provideAPIKey(mapsIndoorsKey, googleAPIKey: googleApiKey)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
