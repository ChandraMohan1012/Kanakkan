package com.kanakkan.kanakkan

import android.content.Context
import android.provider.Telephony

class SmsInboxScanner {

    companion object {
        fun scanInbox(
            context: Context,
            sinceTimestamp: Long? = null,
            limit: Int = 300
        ): List<Map<String, Any>> {
            val messages = mutableListOf<Map<String, Any>>()
            val contentResolver = context.contentResolver

            val projection = arrayOf(
                Telephony.Sms.ADDRESS,
                Telephony.Sms.BODY,
                Telephony.Sms.DATE
            )

            var selection: String? = null
            var selectionArgs: Array<String>? = null

            if (sinceTimestamp != null && sinceTimestamp > 0) {
                selection = "${Telephony.Sms.DATE} > ?"
                selectionArgs = arrayOf(sinceTimestamp.toString())
            }

            val sortOrder = "${Telephony.Sms.DATE} DESC LIMIT $limit"

            try {
                val cursor = contentResolver.query(
                    Telephony.Sms.Inbox.CONTENT_URI,
                    projection,
                    selection,
                    selectionArgs,
                    sortOrder
                )

                cursor?.use {
                    val addressIdx = it.getColumnIndex(Telephony.Sms.ADDRESS)
                    val bodyIdx = it.getColumnIndex(Telephony.Sms.BODY)
                    val dateIdx = it.getColumnIndex(Telephony.Sms.DATE)

                    while (it.moveToNext()) {
                        val sender = if (addressIdx != -1) it.getString(addressIdx) ?: "UNKNOWN" else "UNKNOWN"
                        val body = if (bodyIdx != -1) it.getString(bodyIdx) ?: "" else ""
                        val timestamp = if (dateIdx != -1) it.getLong(dateIdx) else 0L

                        messages.add(
                            mapOf(
                                "sender" to sender,
                                "body" to body,
                                "timestamp" to timestamp
                            )
                        )
                    }
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }

            return messages
        }
    }
}

