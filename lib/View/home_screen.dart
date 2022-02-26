import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:demo_notification_awsome/View/detatils_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'NotificationController.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NotificationController controller=Get.put(NotificationController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Notification"),
                  content: const Text("Notification  aiche ba"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Don't Allow")),
                    TextButton(
                        onPressed: () =>
                            AwesomeNotifications().requestPermissionToSendNotifications().then((_) => Navigator.pop(context)),
                        child: const Text("Allow")),
                  ],
                ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const DetailsScreen());
              },
              icon: const Icon(Icons.next_plan_outlined))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: NetworkImage(
                  "https://images.unsplash.com/photo-1528183429752-a97d0bf99b5a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dHJlZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 100,
                    height: 50,
                    color: Colors.green[800],
                    child: TextButton(
                        onPressed: () {
                          controller.createPlantFoodNotification();
                        },
                        child: const Text(
                          "Plant Food",
                          style: TextStyle(color: Colors.white),
                        ))),
                Container(
                    width: 100,
                    height: 50,
                    color: Colors.green[800],
                    child: TextButton(
                        onPressed: ()async {
                          NotificationWeekAndTime ? notification=await controller.pickSchedule(context);
                          if(notification!=null){
                            controller.createWaterRemainderNotifucation(notification);
                          }

                        },
                        child: const Text(
                          "Water",
                          style: TextStyle(color: Colors.white),
                        ))),
                Container(
                    width: 100,
                    height: 50,
                    color: Colors.green[800],
                    child: TextButton(
                        onPressed: () async{
                          await controller.chancelNotificationSchedule();

                        },

                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
