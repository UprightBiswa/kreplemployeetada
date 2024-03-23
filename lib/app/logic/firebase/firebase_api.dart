import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:kreplemployee/app/data/model/notification_model.dart';
import 'package:kreplemployee/app/presentation/pages/notifications/notification_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  final notificationTitle = message.notification?.title ?? "No title";
  final notificationBody = message.notification?.body ?? "No body";
  final dataPayload = message.data;

  print('Title: $notificationTitle');
  print('Body: $notificationBody');
  print('Payload: $dataPayload');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _tokenKey = 'fcm_token';

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    // // Make sure you have a Navigator widget with navigatorKey defined in your app
    // navigatorKey.currentState?.pushNamed(
    //   ComplaintDetailsScreen.route,
    //   arguments: message,
    // );
    final notificationTitle = message.notification?.title ?? "No title";
    final notificationBody = message.notification?.body ?? "No body";
    final dataPayload = message.data;
    // Extract data from the payload
    final notificationInfo = dataPayload['info'] ?? "No info";
    // Determine the notification type based on the title
    NotificationType type;
    switch (notificationTitle) {
      case 'Order Cancelled!':
        type = NotificationType.orderCancel;
        break;
      case 'Order Confirmed':
        type = NotificationType.orderDone;
        break;
      // Add more cases as needed
      default:
        type = NotificationType.orderPaid;
    }
    // Create a new NotificationModel instance
    final newNotification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
      notificationAbout: notificationTitle,
      notificationMessage: notificationBody,
      notificationInfo: notificationInfo,
      notificationTime: DateTime.now(),
    );
    // Add the new notification to the list
    notificationsList.add(newNotification);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.to(() => const NotificationView());
    });
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle the notification response here
        final message = RemoteMessage.fromMap(jsonDecode(response.payload!));
        handleMessage(message);
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken(); //
    // Save the FCM token to SharedPreferences
    if (fCMToken != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, fCMToken);
      print('saved token: $fCMToken');
    }
    print('Token: ${fCMToken!}');
    initPushNotification();
    initLocalNotifications();
  }
}
