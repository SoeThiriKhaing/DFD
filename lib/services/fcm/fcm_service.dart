import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Function()? onRideRequestReceived;

  static Future<void> setupFCM() async {

    // Request permission for notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("User granted notification permission");
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _showNotification(message);
        if (onRideRequestReceived != null) {
          onRideRequestReceived!();
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        if (onRideRequestReceived != null) {
          onRideRequestReceived!();
        }
      });
    } else {
      debugPrint("User declined notification permission");
    }

  }

  static Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'ride_request_channel',
      'Ride Requests',
      channelDescription: 'Notifications for new ride requests',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0, 
      message.notification?.title ?? "New Ride Request",
      message.notification?.body ?? "You have a new ride request!",
      platformChannelSpecifics,
    );
  }
}
