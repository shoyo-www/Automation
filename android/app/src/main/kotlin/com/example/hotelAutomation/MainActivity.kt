package com.example.hotelAutomation
import com.ttlock.ttlock_flutter.TtlockFlutterPlugin;

import io.flutter.embedding.android.FlutterActivity;

class MainActivity : FlutterActivity() {
    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {
        val ttlockflutterpluginPlugin = flutterEngine!!.plugins[TtlockFlutterPlugin::class.java] as TtlockFlutterPlugin?
        ttlockflutterpluginPlugin?.onRequestPermissionsResult(requestCode, permissions, grantResults)
    }
}
