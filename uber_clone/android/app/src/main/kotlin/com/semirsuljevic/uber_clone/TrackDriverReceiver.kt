package com.semirsuljevic.uber_clone

import android.app.NotificationManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent


class TrackDriverReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent?) {

        if( context == null || intent == null) {
            return;
        }


        val closeDrawer = Intent(Intent.ACTION_CLOSE_SYSTEM_DIALOGS)
        context.sendBroadcast(closeDrawer);

        val ns = Context.NOTIFICATION_SERVICE
        val manager: NotificationManager = context.getSystemService(ns) as NotificationManager
        manager.cancel(intent.getIntExtra("notificationId", -1))

        val startIntent = Intent(context, CustomLauncher::class.java)
        
        startIntent.putExtra("driverId", intent.getStringExtra("driverId"))
        startIntent.putExtra("rideId", intent.getStringExtra("rideId"))
        startIntent.putExtra("carColor", intent.getStringExtra("carColor"))
        
        startIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

        context.startActivity(startIntent, null)


    }
}