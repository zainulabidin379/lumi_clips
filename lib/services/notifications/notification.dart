import 'package:extensions_kit/extensions_kit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lumi_clips/main.dart';
import 'package:lumi_clips/views/splash/splash.dart';
import 'package:lumi_clips/views/videoPreview/video_preview.dart';

class LocalNotifications {
  static Future<NotificationSettings> requestPermission() async {
    return await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
  }

  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails('activity_notifications', 'Activity Notifications',
          channelDescription: 'Channel to show app notifications', importance: Importance.max, priority: Priority.max, ticker: 'ticker'),
      iOS: DarwinNotificationDetails(
          presentAlert: true, presentBadge: true, presentBanner: true, presentSound: true, interruptionLevel: InterruptionLevel.timeSensitive));

  // initialize
  static Future init() async {
    await requestPermission();

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    _flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: onLocalNotificationTapped);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      ('Received Foreground message:  ${message.notification!.body}').log();
      RemoteNotification? notification = message.notification;

      if (notification != null && Ext.isAndroid) {
        showSimpleNotification(id: notification.hashCode, title: notification.title!, body: notification.body!, payload: message.data["payload"]);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      "Message Opened".log();
      await navigatorKey.currentState?.push(MaterialPageRoute<void>(
        builder: (BuildContext context) => VideoPreview(url: message.data["payload"]),
      ));
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        await navigatorKey.currentState?.push(MaterialPageRoute<void>(
          builder: (BuildContext context) => SplashScreen(url: message.data["payload"]),
        ));
      }
    });
    FirebaseMessaging.onBackgroundMessage(messageHandler);
  }

  static Future showSimpleNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    await _flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails, payload: payload);
  }

  static void onLocalNotificationTapped(NotificationResponse details) async {
    final String? payload = details.payload;
    payload.toString().log();
    if (payload != null) {
      "Message Opened".log();
      await navigatorKey.currentState?.push(MaterialPageRoute<void>(
        builder: (BuildContext context) => VideoPreview(url: payload),
      ));
    } else {
      "Payload not found".log();
    }
  }
}
