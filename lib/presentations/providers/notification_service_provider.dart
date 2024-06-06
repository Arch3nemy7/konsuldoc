import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:konsuldoc/core/constants/hive_constants.dart';
import 'package:konsuldoc/core/constants/table_constants.dart';
import 'package:konsuldoc/core/router/admin_router.gr.dart';
import 'package:konsuldoc/presentations/providers/router_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'notification_service_provider.g.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'konsuldoc_main',
  'konsuldoc main notification channel',
  importance: Importance.max,
);

@Riverpod(keepAlive: true)
class NotificationService extends _$NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  String? build() {
    return null;
  }

  void init() async {
    FirebaseMessaging.onMessage.listen(_handleMessage);

    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: _onClickNotification,
    );

    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) _handleMessage(initialMessage);

    onToken(await _messaging.getToken().catchError((_) => null));
    FirebaseMessaging.instance.onTokenRefresh.listen(onToken).onError((err) {
      BotToast.showText(text: 'Failed to retrieve notification token');
    });
  }

  void _handleMessage(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      final String? id = message.data['id'];

      if (id == null) return;
      ref.read(routerProvider).push(AppointmentDetailRoute(id: id));
      _plugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: android.smallIcon,
            ),
          ),
          payload: jsonEncode(message.data));
    }
  }

  void _onClickNotification(NotificationResponse response) {
    if (response.payload == null) return;

    final data = jsonDecode(response.payload!);
    final String? id = data['id'];
    if (id == null) return;
    ref.read(routerProvider).push(AppointmentDetailRoute(id: id));
  }

  void onToken(String? newToken) async {
    updateToken(newToken);
    state = newToken;
  }

  String? getToken() => state;

  Future<void> updateToken(String? token) async {
    final id = _supabase.auth.currentUser?.id;
    final oldToken = Hive.box(HiveConstants.box).get(HiveConstants.token);

    if (id == null) return;
    if (oldToken != null) {
      await _supabase.from(TableConstants.token).delete().match({
        'id_user': id,
        'token': oldToken,
      });
    }
    if (token != null) {
      await _supabase.from(TableConstants.token).upsert({
        'id_user': id,
        'token': token,
      });
    }
    Hive.box(HiveConstants.box).put(HiveConstants.token, token);
  }
}
