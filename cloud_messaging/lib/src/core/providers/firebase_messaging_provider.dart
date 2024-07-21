import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_messaging/src/core/providers/local_notification_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseMessagingProvider = FutureProvider<FirebaseMessaging>(
  (
    ref,
  ) async {
    final localNotifications = ref.watch(localNotificationsProvider);

    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      criticalAlert: true,
      provisional: false,
    );

    // Start listening to messages only if user granted permission to display them
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          print('NOTIFICATION');
          localNotifications.maybeWhen(
            data: (sendNotification) {
              print('SEND');

              sendNotification(message.notification!);
            },
            orElse: () => print('UH OH'),
          );
        }
      });
    }

    return messaging;
  },
);
