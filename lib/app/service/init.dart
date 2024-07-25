import 'dart:ui';

import 'package:getx/app/service/app_notifications.dart';
import 'package:getx/app/service/db_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

class AppInitializer {
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      localDbHelper = LocalDbHelper.db;
      await _initFirebase();
      // AppLocalNotificationService.initialize();
    } catch (e) {
      debugPrint("Error to initilize ${e.toString()}");
    }
  }


  Future<void> _initFirebase() async {
    await Firebase.initializeApp();
    requestForPermission();
    AppLocalNotificationService.initialize();
    await FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AppLocalNotificationService.display(message);
    });

    FlutterError.onError = (error) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(error);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    // automatically catch all errors that are thrown the flutter framework by overriding the FlutterError.onError callback
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    AppLocalNotificationService.display(message);
  }

  requestForPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {}
  }
}
