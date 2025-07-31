import Flutter
import React

@objc(ReactNativeImageEditor)
class ReactNativeImageEditor: NSObject, RCTBridgeModule {
  private let CHANNEL = "react_native_image_editor"
  private var flutterEngine : FlutterEngine?

  static func moduleName() -> String! {
    return "ReactNativeImageEditor"
  }

  static func requiresMainQueueSetup() -> Bool {
    return true
  }

  @objc
  func initializeEngine() {
    if flutterEngine == nil {
      flutterEngine = FlutterEngine(name: "my_engine")
      flutterEngine?.run()
      let methodChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: flutterEngine!.binaryMessenger)
      methodChannel.setMethodCallHandler { (call, result) in
        // handle calls from flutter if needed
      }
    }
  }

  @objc(sendImageToFlutter:resolver:rejecter:)
  func sendImageToFlutter(base64Image: String, resolver: RCTPromiseResolveBlock, rejecter: RCTPromiseRejectBlock) {
    guard let flutterEngine = flutterEngine else {
      rejecter("NO_ENGINE", "Flutter engine not initialized", nil)
      return
    }
    let methodChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: flutterEngine.binaryMessenger)
    methodChannel.invokeMethod("sendImageToFlutter", arguments: base64Image)
    resolver(nil)
  }

  @objc(showFlutterView)
  func showFlutterView() {
    guard let flutterEngine = flutterEngine, let controller = UIApplication.shared.delegate?.window??.rootViewController else {
      return
    }
    let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    controller.present(flutterViewController, animated: true)
  }
}
