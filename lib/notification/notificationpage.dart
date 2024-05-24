import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myrailguide/auth.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:myrailguide/widgets/loading.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class NotificationPage1 extends StatefulWidget {
  final User? user;
  const NotificationPage1({Key? key, this.user}) : super(key: key);

  @override
  State<NotificationPage1> createState() => _NotificationPage1();
}

class _NotificationPage1 extends State<NotificationPage1> {
  int status = 0;
  bool value1 = false;
  bool value2 = false;
  static const Color bgcolor = Color(0xFFF5F5F5);
  static const Color thcolor = Color(0xFF225FDE);

  void fetchControls() async {
    var db = await mongo.Db.create(Environment.mongoServerUrl);
    await db.open();
    var control = await db
        .collection('token')
        .findOne(mongo.where.eq("user", widget.user?.uid));
    setState(() {
      value1 = control?['status'];
      status = 1;
    });
  }

  void changeControl(value) async {
    var db = await mongo.Db.create(Environment.mongoServerUrl);
    await db.open();
    var control = await db
        .collection('token')
        .findOne(mongo.where.eq("user", widget.user?.uid));
    if (control != null) {
      control['status_pnr'] = value;
      await db
          .collection('token')
          .replaceOne(mongo.where.eq("user", widget.user?.uid), control);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchControls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Notification Control", true),
      body: SafeArea(
        child: (status == 1)
            ? Padding(
                padding: Paddings.maincontent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15.0, right: 15),
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
                                  changeControl(value);
                                  setState(() {
                                    value1 = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'PNR Status Notification',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15.0, right: 15),
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
                                      // priorArrivalNotification();
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Text('Schedule Change Notification',
                            style: Theme.of(context).textTheme.headlineSmall),
                      ],
                    ),
                  ],
                ),
              )
            : NotifLoading(),
      ),
    );
  }
}
