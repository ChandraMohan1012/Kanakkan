package com.kanakkan.kanakkan

import android.Manifest
import android.content.pm.PackageManager
import android.os.Build
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val METHOD_CHANNEL = "com.kanakkan/sms_methods"
    private val EVENT_CHANNEL = "com.kanakkan/sms_stream"
    private val PERMISSION_REQUEST_CODE = 1001
    private var pendingPermissionResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // MethodChannel for commands
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "checkPermissions" -> {
                    val readGranted = ContextCompat.checkSelfPermission(
                        this,
                        Manifest.permission.READ_SMS
                    ) == PackageManager.PERMISSION_GRANTED

                    val receiveGranted = ContextCompat.checkSelfPermission(
                        this,
                        Manifest.permission.RECEIVE_SMS
                    ) == PackageManager.PERMISSION_GRANTED

                    result.success(readGranted && receiveGranted)
                }

                "requestPermissions" -> {
                    val permissionsToRequest = mutableListOf(
                        Manifest.permission.READ_SMS,
                        Manifest.permission.RECEIVE_SMS
                    )
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                        permissionsToRequest.add(Manifest.permission.POST_NOTIFICATIONS)
                    }

                    pendingPermissionResult = result
                    ActivityCompat.requestPermissions(
                        this,
                        permissionsToRequest.toTypedArray(),
                        PERMISSION_REQUEST_CODE
                    )
                }

                "scanInbox" -> {
                    val sinceTimestamp = call.argument<Number>("sinceTimestamp")?.toLong()
                    val limit = call.argument<Int>("limit") ?: 300
                    val scannedList = SmsInboxScanner.scanInbox(this, sinceTimestamp, limit)
                    result.success(scannedList)
                }

                "getPendingBackgroundSms" -> {
                    val pendingList = SmsReceiver.getAndClearPendingSms(this)
                    result.success(pendingList)
                }

                else -> result.notImplemented()
            }
        }

        // EventChannel for real-time incoming SMS stream
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    SmsReceiver.eventSink = events

                    // Flush any pending SMS captured while app was in background
                    val pending = SmsReceiver.getAndClearPendingSms(this@MainActivity)
                    for (sms in pending) {
                        events?.success(sms)
                    }
                }

                override fun onCancel(arguments: Any?) {
                    SmsReceiver.eventSink = null
                }
            }
        )
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == PERMISSION_REQUEST_CODE) {
            val allGranted = grantResults.isNotEmpty() && grantResults.all { it == PackageManager.PERMISSION_GRANTED }
            pendingPermissionResult?.success(allGranted)
            pendingPermissionResult = null
        }
    }
}
