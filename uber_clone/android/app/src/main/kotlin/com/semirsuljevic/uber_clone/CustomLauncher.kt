package com.semirsuljevic.uber_clone

import android.os.Bundle
import android.os.PersistableBundle
import com.google.firebase.FirebaseApp
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class CustomLauncher: FlutterActivity() {

    private val CHANNEL = "RideIdFetcher";


    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        FirebaseApp.initializeApp(this);
    }

    private val rideId: String?
        get() = intent.getStringExtra("rideId")

    private val carColor: String?
        get() = intent.getStringExtra("carColor")
    
    private val driverId: String?
        get() = intent.getStringExtra("driverId")

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
            call, result ->
            if( call.method == "getRideId")
            result.success(rideId)

            if(call.method == "getDriverId")
            result.success(driverId)

            result.success(carColor)
        }
    }
    
    override fun getDartEntrypointFunctionName(): String {
        return "customEntryPoint";
    }

    



}