import 'dart:developer';

import 'package:complaints_app/core/services/notification/local_votification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    // طلب الصلاحيات
    final settings = await messaging.requestPermission();
    debugPrint('🔐 FCM permission: ${settings.authorizationStatus}');

    // جلب التوكن
    final token = await messaging.getToken();
    log("📲 FCM token is : $token");

    // رسائل الـ foreground
    _handleForegroundMessages();

    // (اختياري) رسائل الضغط على الإشعار وفتح التطبيق
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('📬 onMessageOpenedApp: ${message.messageId}');
    });
  }

  static void _handleForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('🚀 ENTERED onMessage (foreground)');
      debugPrint('📩 title: ${message.notification?.title}');
      debugPrint('📩 body : ${message.notification?.body}');

      // إظهار إشعار System أثناء ما التطبيق مفتوح
      LocalNotificationService.showBasicNotification(message);
    });
  }
}
