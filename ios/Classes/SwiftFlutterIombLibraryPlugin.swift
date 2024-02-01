import Flutter
import UIKit
import IOMbLibrary

public class SwiftFlutterIombLibraryPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_iomb_library", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterIombLibraryPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let arguments = call.arguments as? NSDictionary

    switch call.method {
      case "sessionConfiguration":
        sessionConfiguration(
          baseURL: arguments!["baseURL"] as! String,
          offerIdentifier: arguments!["offerIdentifier"] as! String,
          hybridIdentifier: arguments!["hybridIdentifier"] as? String
        )
        result(true)
        break
      case "logViewEvent":
        logViewEvent(
          type: arguments!["type"] as! String,
          category: arguments!["category"] as! String,
          comment: arguments!["comment"] as? String
        )
        result(true)
        break
      case "terminateSession":
        terminateSession()
        result(true)
        break
      case "setDebugLogLevel":
        setDebugLogLevel(arguments!["level"] as! String)
        result(true)
        break
      default:
        result("iOS " + UIDevice.current.systemVersion)
        break
    }
  }

  private func sessionConfiguration(baseURL: String, offerIdentifier: String, hybridIdentifier: String?) {
    guard let url = URL(string: baseURL) else { return }
    let configuration = IOMBSessionConfiguration(
      offerIdentifier: offerIdentifier,
      hybridIdentifier: hybridIdentifier,
      baseURL: url
    )
    IOMBSession.defaultSession(for: .iomb).start(with: configuration)
  }

  private func logViewEvent(type: String, category: String, comment: String?) {
    let types = ["appeared","refreshed","disappeared"]
    let eventType = IOMBViewEventType(rawValue: stringToEnumValue(type, values: types))!
    let event = IOMBViewEvent(type: eventType, category: category, comment: comment)
    IOMBSession.defaultSession(for: .iomb).logEvent(event)
  }

  private func terminateSession() {
    IOMBSession.defaultSession(for: .iomb).terminateSession()
  }

  private func setDebugLogLevel(_ level: String) {
    let levels = ["off","error","warning","info","trace"]
    let level = IOMBDebugLevel(rawValue: Int(stringToEnumValue(level, values: levels)))!
    IOMBLogging.setDebugLogLevel(level)
  }

  // Helper functions

  private func stringToEnumValue(_ value: String, values: [String]) -> UInt {
      return UInt(values.firstIndex(where: {$0 == value}) ?? 0)
  }
}
