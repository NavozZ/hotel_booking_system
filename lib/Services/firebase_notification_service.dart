import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationService {
  static Future<void> initNotification() async {
    // subscribe to topic
    await FirebaseMessaging.instance.subscribeToTopic('hotel');
    //Create a FCM Instance
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    //GetPermission for IOS
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    //Generate FCToken
    String? fcmToken = await messaging.getToken();

    if (fcmToken != null) {
      print("FCM TOKEN :: $fcmToken");
    } else {
      print("Can't generate fcmtoken");
    }

    //Handle Notifications on Background and Terminated State
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    //Create High Priority Notification Channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launch_background');

    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    //Handle Notifications on Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          "Foreground Message Handler :: TITLE - ${message.notification!.title}");
      print(
          "Foreground Message Handler :: BODY - ${message.notification!.body}");

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: android.smallIcon,
              ),
            ));
      }
    });
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}
