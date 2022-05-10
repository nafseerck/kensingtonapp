


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  List blocklist;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");
  Future initialise() async {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
       // print("onLaunch: ${message['notification']['body']}");
        _showNotification(message['notification']['body']);
        notif_arrived(false);
        // print("onLaunch: $message");
        // Map notification = message['notification'];
        // var body = notification['body'];
        // print("onmessage: $body");
        // String messa=body.toString();






      },
      onLaunch: (Map<String, dynamic> message) async {
      //  print("onLaunchmess: ${message}");
        _showNotification(message['notification']['body']);
        notif_arrived(false);
      },
      onResume: (Map<String, dynamic> message) async {
        _showNotification(message['notification']['body']);
       // print("onResume: $message");
        notif_arrived(false);
      },
    );
    _fcm.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _fcm.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }


  Future<void> _showNotification(message) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'Kensington international', message, platformChannelSpecifics,
        payload: 'item x');


  }
  Future<void> notif_arrived(isselect) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification_arr',isselect );
  }
}