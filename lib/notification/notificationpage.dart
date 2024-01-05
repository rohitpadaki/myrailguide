import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myrailguide/widgets/customappbar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NotificationPage1(),
    );
  }
}

class NotificationPage1 extends StatefulWidget {
  const NotificationPage1({Key? key}) : super(key: key);

  @override
  State<NotificationPage1> createState() => _NotificationPage1();
}

class _NotificationPage1 extends State<NotificationPage1> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationServices notificationServices = NotificationServices();
  bool value1 = false;
  bool value2 = false;
  static const Color bgcolor = Color(0xFFF5F5F5);
  static const Color thcolor = Color(0xFF225FDE);

  @override
  void initState() {
    super.initState();
    initializeNotifications();
  }

  void initializeNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  void listenToFirestoreChanges() {
    var db = FirebaseFirestore.instance;
    var pnrRef = db.collection('pnr').doc('9876543');
    pnrRef
        .snapshots()
        .listen((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.exists) {
        // Access data using snapshot.data()
        var arrTime = snapshot.data()?['arrive'];
        DateTime A = arrTime.toDate().toLocal();
        var B = '${A.hour}:${A.minute}';
        String time = B.toString();
        if (time != '6:15') {
          notificationServices.sendNotification();
        }
      }
    });
  }

  void priorArrivalNotification() {
    var db = FirebaseFirestore.instance;
    var pnrRef = db.collection('pnr').doc('9876543');

    pnrRef
        .snapshots()
        .listen((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        // Access data using snapshot.data()
        var arrTime = snapshot.data()!['arrive'];

        if (arrTime != null) {
          DateTime A = arrTime.toDate().toLocal();
          var now = DateTime.now();
          var t1 = A.difference(now);
          if (t1.inHours == 1 && t1.inMinutes % 60 == 0) {
            notificationServices.arrivalNotification();
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Notification Control", true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 53.687,
                  height: 33.999,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade500,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: CupertinoSwitch(
                      activeColor: thcolor,
                      thumbColor: value1 ? Colors.white : thcolor,
                      trackColor: bgcolor,
                      value: value1,
                      onChanged: (value) {
                        setState(() {
                          value1 = value;
                          if (value) {
                            listenToFirestoreChanges();
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              Text(
                'Schedule Change Notification',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 53.687,
                  height: 33.999,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade500,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: CupertinoSwitch(
                      activeColor: thcolor,
                      thumbColor: value2 ? Colors.white : thcolor,
                      trackColor: bgcolor,
                      value: value2,
                      onChanged: (value) {
                        setState(() {
                          value2 = value;
                          if (value) {
                            priorArrivalNotification();
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              Text('Arrival Notification',
                  style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
        ],
      ),
    );
  }
}

class NotificationServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> sendNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'main_channel',
      'Main Channel',
      channelDescription: "ashwin",
      importance: Importance.max,
      priority: Priority.max,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Schedule Notification',
      'Your schedule has been changed!!',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  Future<void> arrivalNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', // Replace with your own channel ID
      'Your Channel Name', // Replace with your own channel name
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      1, // Notification ID
      'Arrival Notification', // Title of the notification
      'You will arrive shortly!!', // Body of the notification
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }
}
