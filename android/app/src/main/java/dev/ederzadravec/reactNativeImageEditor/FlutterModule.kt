package dev.ederzadravec.reactNativeImageEditor

import com.facebook.react.bridge.*
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel

class reactNativeImageEditorModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
    private val CHANNEL = "react_native_image_editor"
    private var flutterEngine: FlutterEngine? = null

    override fun getName() = "reactNativeImageEditor"

    init {
        flutterEngine = FlutterEngine(reactContext)
        flutterEngine?.dartExecutor?.let {
            MethodChannel(it, CHANNEL).setMethodCallHandler { call, result ->
                // receber chamadas do Flutter, se precisar
            }
        }
        FlutterEngineCache.getInstance().put("my_engine_id", flutterEngine)
    }

    @ReactMethod
    fun sendImageToFlutter(base64Image: String, promise: Promise) {
        flutterEngine?.dartExecutor?.let {
            MethodChannel(it, CHANNEL).invokeMethod("sendImageToFlutter", base64Image)
            promise.resolve(null)
        } ?: run {
            promise.reject("NO_ENGINE", "Flutter engine not initialized")
        }
    }

    @ReactMethod
    fun showFlutterActivity() {
        val currentActivity = currentActivity ?: return
        currentActivity.startActivity(
            FlutterActivity
                .withCachedEngine("my_engine_id")
                .build(currentActivity)
        )
    }
}
