package com.kanakkan.kanakkan

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.provider.Telephony
import android.telephony.SmsMessage
import io.flutter.plugin.common.EventChannel
import org.json.JSONArray
import org.json.JSONObject

class SmsReceiver : BroadcastReceiver() {

    companion object {
        var eventSink: EventChannel.EventSink? = null
        private const val PREFS_NAME = "kanakkan_sms_buffer"
        private const val KEY_PENDING_SMS = "pending_sms_list"

        fun getAndClearPendingSms(context: Context): List<Map<String, Any>> {
            val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            val jsonString = prefs.getString(KEY_PENDING_SMS, null) ?: return emptyList()
            val list = mutableListOf<Map<String, Any>>()
            try {
                val array = JSONArray(jsonString)
                for (i in 0 until array.length()) {
                    val obj = array.getJSONObject(i)
                    list.add(
                        mapOf(
                            "sender" to obj.optString("sender"),
                            "body" to obj.optString("body"),
                            "timestamp" to obj.optLong("timestamp")
                        )
                    )
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }
            prefs.edit().remove(KEY_PENDING_SMS).apply()
            return list
        }

        private fun savePendingSms(context: Context, smsData: Map<String, Any>) {
            val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            val existing = prefs.getString(KEY_PENDING_SMS, "[]") ?: "[]"
            try {
                val array = JSONArray(existing)
                val obj = JSONObject(smsData)
                array.put(obj)
                prefs.edit().putString(KEY_PENDING_SMS, array.toString()).apply()
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action != Telephony.Sms.Intents.SMS_RECEIVED_ACTION) return

        val messages: Array<SmsMessage> = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            Telephony.Sms.Intents.getMessagesFromIntent(intent)
        } else {
            val bundle = intent.extras ?: return
            val pdus = bundle.get("pdus") as? Array<*> ?: return
            pdus.mapNotNull { pdu ->
                @Suppress("DEPRECATION")
                SmsMessage.createFromPdu(pdu as ByteArray)
            }.toTypedArray()
        }

        if (messages.isEmpty()) return

        // Multi-part SMS can be split into chunks: reassemble chunks by sender
        val sender = messages.first().originatingAddress ?: "UNKNOWN"
        val timestamp = messages.first().timestampMillis
        val bodyBuilder = StringBuilder()
        for (msg in messages) {
            bodyBuilder.append(msg.messageBody)
        }
        val fullBody = bodyBuilder.toString()

        val payload = mapOf<String, Any>(
            "sender" to sender,
            "body" to fullBody,
            "timestamp" to timestamp
        )

        val sink = eventSink
        if (sink != null) {
            sink.success(payload)
        } else {
            savePendingSms(context, payload)
        }
    }
}

