import UIKit
import Flutter
import GoogleMaps
import TPDirect

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        GMSServices.provideAPIKey("AIzaSyCmVvg9BQ2Brst4zU_VNmPEqcbyEkIFCeA")
        
        TPDSetup.setWithAppId(12348, withAppKey: "app_pa1pQcKoY22IlnSXq5m5WP5jFKzoRG58VEXpT7wU62ud7mMbDOGzCYIlzzLF", with: .sandBox)
        
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let batteryChannel = FlutterMethodChannel(
            name: "samples.flutter.dev/battery",
            binaryMessenger: controller.binaryMessenger
        )
        batteryChannel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // This method is invoked on the UI thread.
            guard call.method == "getBatteryLevel" else {
                result(FlutterMethodNotImplemented)
                return
            }
            self?.receiveBatteryLevel(result: result)
        })
        
        let testStringChannel = FlutterMethodChannel(name: "stylish/test", binaryMessenger: controller.binaryMessenger)
        testStringChannel.setMethodCallHandler { [weak self] (call, result) -> Void in
            if call.method == "getTestString" {
                result("Test String")
            }
            if call.method == "getTestString2" {
                result("2")
            }
        }
        
        let tappayChannel = FlutterMethodChannel(name: "stylish/tappay", binaryMessenger: controller.binaryMessenger)
        tappayChannel.setMethodCallHandler { [weak self] (call, result) in
            switch call.method {
            case "getPrime":
                self?.getPrime(call: call, result: result)
            default:
                result("method unknown")
                return
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func getPrime(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? [String: Any] else {
            result("[Failure] arguments parse failure")
            return
        }
        guard let number = arguments["number"] as? String else {
            result("[Failure] number parse failure")
            return
        }
        guard let dueMonth = arguments["dueMonth"] as? String else {
            result("[Failure] dueMonth parse failure")
            return
        }
        guard let dueYear = arguments["dueYear"] as? String else {
            result("[Failure] dueYear parse failure")
            return
        }
        guard let ccv = arguments["ccv"] as? String else {
            result("[Failure] ccv parse failure")
            return
        }
        
        TPDCard
            .setWithCardNumber(number, withDueMonth: dueMonth, withDueYear: dueYear, withCCV: ccv)
            .onSuccessCallback { prime, cardInfo, cardIdentifier, merchantReferenceInfo in
                result(prime)
            }
            .onFailureCallback { status, message in
                
                result("[Failure] status: \(status), message: \(message)")
            }
            .createToken(withGeoLocation: "UNKNOWN")
    }
    
    private func receiveBatteryLevel(result: FlutterResult) {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        if device.batteryState == UIDevice.BatteryState.unknown {
            result(95)
//            result(FlutterError(
//                code: "UNAVAILABLE",
//                message: "Battery level not available.",
//                details: nil
//            ))
        } else {
            result(Int(device.batteryLevel * 100))
        }
    }
}
