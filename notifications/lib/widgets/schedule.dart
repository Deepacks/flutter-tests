import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  scheduleNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Amazing News!',
        body: 'You just lost 5 seconds of your life :D',
      ),
      schedule: NotificationCalendar.fromDate(
        date: DateTime.now().add(
          const Duration(seconds: 5),
        ),
        allowWhileIdle: true,
      ),
    );
  }

  cancelScheduledNotification() {
    AwesomeNotifications().cancelSchedule(10);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Schedule:'),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: scheduleNotification,
          child: const Text('Schedule notification (5s)'),
        ),
        ElevatedButton(
          onPressed: cancelScheduledNotification,
          child: const Text('Cancel scheduled notification'),
        ),
      ],
    );
  }
}
