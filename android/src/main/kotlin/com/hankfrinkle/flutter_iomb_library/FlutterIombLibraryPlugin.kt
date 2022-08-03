package com.hankfrinkle.flutter_iomb_library

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import de.infonline.lib.iomb.IOLViewEvent
import de.infonline.lib.iomb.IOMB
import de.infonline.lib.iomb.measurements.Measurement
import de.infonline.lib.iomb.measurements.iomb.IOMBSetup
import de.infonline.lib.iomb.IOLDebug

/** FlutterIombLibraryPlugin */
class FlutterIombLibraryPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_iomb_library")
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "sessionConfiguration" -> {
        sessionConfiguration(
          call.argument<String>("baseURL").orEmpty(),
          call.argument<String>("offerIdentifier").orEmpty(),
          call.argument<String>("hybridIdentifier")
        );
        result.success(true);
      }
      "logViewEvent" -> {
        logViewEvent(
          call.argument<String>("type").orEmpty(),
          call.argument<String>("category").orEmpty(),
          call.argument<String>("comment")
        );
        result.success(true);
      }
      "terminateSession" -> {
        terminateSession()
        result.success(true);
      }
      "setDebugModeEnabled" -> {
        setDebugModeEnabled(call.argument<Boolean>("enable") ?: false)
        result.success(true);
      }
      else -> {
        result.notImplemented();
      }
    }
  }

  // Flutter API methods

  private fun sessionConfiguration(baseURL: String, offerIdentifier: String, hybridIdentifier: String?) {
    val setup = IOMBSetup(
      offerIdentifier = offerIdentifier,
      baseUrl = baseURL,
      hybridIdentifier = hybridIdentifier)

    // Create session synchron
    IOMB_SESSION = IOMB.createBlocking(setup)
  }

  private fun logViewEvent(type: String, category: String, comment: String?) {
    val enumType = IOLViewEvent.IOLViewEventType.valueOf(uppercase(type))
    val event = IOLViewEvent(type = enumType, category = category, comment = comment)
    IOMB_SESSION.logEvent(event)
  }

  private fun terminateSession() {
    IOMB.delete(Measurement.Type.IOMB)
  }

  private fun setDebugModeEnabled(enable: Boolean) {
    IOLDebug.debugMode = enable
  }

  // Helper functions

  companion object {
    val logListeners = mutableListOf<(Int, String, String?, Throwable?) -> Unit>()
    lateinit var IOMB_SESSION: Measurement
  }

  private fun uppercase(value: String) : String {
    return value.replaceFirstChar { it.uppercase() }
  }
}
