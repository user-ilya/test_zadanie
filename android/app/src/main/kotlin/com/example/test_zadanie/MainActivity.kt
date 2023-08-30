package com.example.test_zadanie

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.yandex.mapkit.MapKitFactory;
import androidx.annotation.NonNull




class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("ffb899af-896a-46e5-812f-b5c2cea8a45c") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}
