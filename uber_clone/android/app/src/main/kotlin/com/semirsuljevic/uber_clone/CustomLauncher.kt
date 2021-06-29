package com.semirsuljevic.uber_clone

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class CustomLauncher: FlutterActivity() {

    private val CHANNEL = "RideIdFetcher";

    private val rideId: String?
        get() = intent.getStringExtra("rideId")
    
    private val driverId: String?
        get() = intent.getStringExtra("driverId")

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
            call, result ->
            if( call.method == "getRideId")
            result.success(rideId)
            
            result.success(driverId)
        }
    }


    override fun getDartEntrypointFunctionName(): String {
        return "customEntryPoint";
    }

    



}