import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class Triggers extends StatelessWidget {
  const Triggers({super.key});

  basicNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'AMERICA',
        body: 'FUCK YEAH!',
      ),
    );
  }

  bigPictureNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'LOOK AT THIS DOG!',
        body: 'Isn\'t he the cutest',
        bigPicture: 'assets/icons/explosion',
        notificationLayout: NotificationLayout.BigPicture,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Trigger:'),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: basicNotification,
          child: const Text('Basic notification'),
        ),
        ElevatedButton(
          onPressed: bigPictureNotification,
          child: const Text('Big picture notification'),
        ),
      ],
    );
  }
}
