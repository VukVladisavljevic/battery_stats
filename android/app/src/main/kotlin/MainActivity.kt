package com.example.battery_stats

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class MainActivity: FlutterActivity() {
    private val batteryEventChannel = "battery_stats"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, batteryEventChannel).setStreamHandler(BatteryStreamHandler(context));
    }
}

class BatteryStreamHandler(private val context: Context) : EventChannel.StreamHandler{
    private var receiver: BroadcastReceiver? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        if(events == null) return

        receiver = initReceiver(events)
        context.registerReceiver(receiver, IntentFilter(Intent.ACTION_BATTERY_CHANGED))

    }

    override fun onCancel(arguments: Any?) {
        context.unregisterReceiver(receiver)
        receiver = null
    }

    private fun initReceiver(events: EventChannel.EventSink): BroadcastReceiver {
        return object: BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent) {
                val level = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
                val scale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
                val batteryPct = level * 100 / scale.toFloat()

                events.success(batteryPct)

            }
        }
    }

}