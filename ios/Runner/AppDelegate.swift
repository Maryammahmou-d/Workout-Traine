import UIKit
import Flutter
import awesome_notifications
import shared_preferences_foundation


@main
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    self.window.makeSecure()
    GeneratedPluginRegistrant.register(with: self)

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    application.registerForRemoteNotifications()

    SwiftAwesomeNotificationsPlugin.setPluginRegistrantCallback { registry in
      SwiftAwesomeNotificationsPlugin.register(
        with: registry.registrar(forPlugin: "io.flutter.plugins.awesomenotifications.AwesomeNotificationsPlugin")!)
      SharedPreferencesPlugin.register(
        with: registry.registrar(forPlugin: "io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin")!)
    }

    // Call the method to disable screenshots
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let screenshotChannel = FlutterMethodChannel(name: "screenshot_channel", binaryMessenger: controller.binaryMessenger)
    screenshotChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "disableScreenshots" {
        self?.disableScreenshots()
        result(nil)
      } else {
        result(FlutterMethodNotImplemented)
      }
    })
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func disableScreenshots() {
       if let window = self.window {
           if let rootViewController = window.rootViewController {
               let overlayView = UIView(frame: rootViewController.view.bounds)
               overlayView.backgroundColor = UIColor.white // Set the color as per your app's design

               // Add an additional view to cover the whole screen
               rootViewController.view.addSubview(overlayView)

               // Bring the overlay view to the front
               rootViewController.view.bringSubviewToFront(overlayView)

               // Remove the overlay view after a delay (you can adjust the delay)
               DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                   overlayView.removeFromSuperview()
               }
           }
       }
  }
   override func applicationWillResignActive(
      _ application: UIApplication
    ) {
      self.window.isHidden = true;
    }
    override func applicationDidBecomeActive(
      _ application: UIApplication
    ) {
      self.window.isHidden = false;
    }
}

extension UIWindow {
    func makeSecure() {
        let field = UITextField()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: field.frame.self.width, height: field.frame.self.height))
        field.isSecureTextEntry = true
        self.addSubview(field)
        self.layer.superlayer?.addSublayer(field.layer)
        field.layer.sublayers?.last!.addSublayer(self.layer)
        field.leftView = view
        field.leftViewMode = .always
    }
}

