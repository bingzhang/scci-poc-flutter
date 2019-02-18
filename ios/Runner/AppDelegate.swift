import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    //TODO KEY must be changed for each client (this is debug key)
    let googleApiKey = "AIzaSyDzu401K9d7fzJjJ18_VVP_VvWAuFhi29g";
    GMSServices.provideAPIKey(googleApiKey);
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
