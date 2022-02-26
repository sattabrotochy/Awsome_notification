import 'dart:ffi';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  int createUniqueID() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  Future<NotificationWeekAndTime?> pickSchedule(
      BuildContext context,
      ) async {
    List<String> weekdays = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];
    TimeOfDay? timeOfDay;
    DateTime now = DateTime.now();
    int? selectedDay;

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'I want to be reminded every:',
              textAlign: TextAlign.center,
            ),
            content: Wrap(
              alignment: WrapAlignment.center,
              spacing: 3,
              children: [
                for (int index = 0; index < weekdays.length; index++)
                  ElevatedButton(
                    onPressed: () {
                      selectedDay = index + 1;
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.teal,
                      ),
                    ),
                    child: Text(weekdays[index]),
                  ),
              ],
            ),
          );
        });

    if (selectedDay != null) {
      timeOfDay = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(
            now.add(
              Duration(minutes: 1),
            ),
          ),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData(
                colorScheme: ColorScheme.light(
                  primary: Colors.teal,
                ),
              ),
              child: child!,
            );
          });

      if (timeOfDay != null) {
        return NotificationWeekAndTime ( selectedDay!, timeOfDay);
      }
    }
    return null;
  }

  Future<void> createPlantFoodNotification()async{
   await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: createUniqueID(),
            channelKey: 'basic_channel',
            title: 'Simple Notification',
            body: 'Simple body',
            bigPicture: "asset/image/image.png",
            //notificationLayout: NotificationLayout.BigPicture
        )
    );
  }


  Future<void> createWaterRemainderNotifucation(NotificationWeekAndTime notificationWeekAndTime)async{
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: createUniqueID(),
          channelKey: 'basic_channel',
          title: 'Simple Notification',
          body: 'Simple body',
          bigPicture: "asset/image/image.png",
          notificationLayout: NotificationLayout.Default
          //notificationLayout: NotificationLayout.BigPicture
        ),
      actionButtons: [
        NotificationActionButton(key: 'MARK_DONE', label: "mark_done"),
      ],
      schedule: NotificationCalendar(
        weekday: notificationWeekAndTime.dayOfTheWeek,
        hour: notificationWeekAndTime.timeOfDay.hour,
        minute: notificationWeekAndTime.timeOfDay.minute,
        second: 0,
        millisecond: 0,
        repeats: true,
      )

    );




  }
  Future<void>chancelNotificationSchedule()async{
    await  AwesomeNotifications().cancelAllSchedules();
  }
}

class NotificationWeekAndTime {
  final int dayOfTheWeek;
  final TimeOfDay timeOfDay;

  NotificationWeekAndTime(  this.dayOfTheWeek, this.timeOfDay);
}
