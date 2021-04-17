import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../auth/authentication_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/*
* 🦄initiated at the app start to listen to notifications..
*/
class NotificationService {
  final AuthenticationService auth;
  List<dynamic> userNotifications;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  NotificationService({this.auth});

  Future<void> init(context) async {
    String token = await _firebaseMessaging.getToken();
    print("Firebase token : $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO:add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(context, '/message');
      // arguments: MessageArguments(message, true));
    });

    if (Platform.isIOS) await getIOSPermission();

    await _firebaseMessaging.getToken().then(updateFCMToken);
  }

  Future<void> updateFCMToken(token) async {
    if (token != null) {
      try {
        //TODO: update fcm implementation
        // Preference.setString(PrefKeys.fcmToken, token);

        // print('new fcm:$token');
      } catch (e) {
        print('error updating fcm');
      }
    }
  }

  operateMessage(Map<String, dynamic> message,
      {bool showOverlay = true}) async {
    String body;
    String title;
    Map<dynamic, dynamic> data;
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS &&
        int.parse((await deviceInfo.iosInfo).systemVersion.split('.')[0]) <
            13) {
      final messageData = message['aps']['alert'];
      title = messageData['title'];
      body = messageData['body'];
      data = message['data'];
    } else {
      final messageData = message['notification'];
      title = messageData['title'];
      body = messageData['body'];
      data = message['data'];
    }

    //TODO:implement behavior
  }

  getIOSPermission() async {
    await _firebaseMessaging.requestPermission(
        announcement: true, criticalAlert: true, provisional: true);
    // (const IosNotificationSettings(
    //     sound: true, badge: true, alert: true, provisional: true));

    // final iosSubscription = _firebaseMessaging.onIosSettingsRegistered.listen((data) {
    //       _saveDeviceToken();
    //     });
  }
}
