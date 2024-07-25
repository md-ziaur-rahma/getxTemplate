import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class AppLocalNotificationService {
  static const String channelId = "budgetBuddyId";
  static const String channelName = "Budget Buddy App Notification";
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var isoInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: isoInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings);
    Get.put(flutterLocalNotificationsPlugin);
  }

  static void display(RemoteMessage message) async {
    var body = message.notification?.body ?? "";

    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    late FlutterLocalNotificationsPlugin plugin;
    try {
      plugin = Get.find<FlutterLocalNotificationsPlugin>();
    } catch (e) {
      AppLocalNotificationService.initialize();
      plugin = Get.find<FlutterLocalNotificationsPlugin>();
    }

    var androidNotificationDetails = const AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: "This channel is used for important",
        priority: Priority.high,
        ticker: 'ticker');
    var iosNotificationDetails = const DarwinNotificationDetails();
    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);

    await plugin.show(
        id, message.notification?.title ?? "", body, notificationDetails);
  }

  static void displayLocal(String title, String body,
      {String data = ""}) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    late FlutterLocalNotificationsPlugin plugin;
    try {
      plugin = Get.find<FlutterLocalNotificationsPlugin>();
    } catch (e) {
      AppLocalNotificationService.initialize();
      plugin = Get.find<FlutterLocalNotificationsPlugin>();
    }
    var androidNotificationDetails = const AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: "This channel is used for important",
        priority: Priority.high,
        ticker: 'ticker');
    var iosNotificationDetails = const DarwinNotificationDetails();
    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    await plugin.show(id, title, body, notificationDetails);
  }

  static Future<NotificationDetails> notificationDetails(
      {bool isWaterReminder = false}) async {
    var androidNotificationDetails = const AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: "This channel is used for important",
        priority: Priority.max,
        ticker: 'ticker');
    var iosNotificationDetails = const DarwinNotificationDetails();
    return NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
  }
}
