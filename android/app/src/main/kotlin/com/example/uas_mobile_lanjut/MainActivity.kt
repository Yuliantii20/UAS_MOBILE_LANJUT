package com.example.uas_mobile_lanjut

import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "diginews/native"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            if (call.method == "reverseNim") {

                val nim = call.argument<String>("nim") ?: ""

                val reversed = nim.reversed()

                Toast.makeText(
                    this,
                    "NIM Reverse : $reversed",
                    Toast.LENGTH_LONG
                ).show()

                result.success(reversed)

            } else {

                result.notImplemented()

            }
        }
    }
}