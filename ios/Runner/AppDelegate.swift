import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
    weak var registrar = self.registrar(forPlugin: "mercMapFactory")

    let factory = FLMapViewFactory(messenger: registrar!.messenger())
    self.registrar(forPlugin: "mercMapPlatformView")!.register(
        factory,
        withId: "mercMap")
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
