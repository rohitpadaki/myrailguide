import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:myrailguide/emergency/emergency_contacts.dart';
import 'package:myrailguide/feedback/feedback.dart';
import 'package:myrailguide/notification/notificationpage.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/planner/addjourney.dart';
import 'package:myrailguide/pnrstatus/pnrstatus.dart';
import 'package:myrailguide/trainschedule/trainschedule.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:myrailguide/widgets/loading.dart';

class HomePage extends StatefulWidget {
  final User? user;
  const HomePage({super.key, this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int listCount = 0;
  int status = 0;

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  getDetails() async {
    await Localstore.instance.collection(widget.user!.uid).get().then(
      (value) {
        if (value != null) listCount = value.length;
      },
    );
    setState(() {
      status = 1;
    });
  }

  changeState() {
    setState(() {
      (status == 0) ? status = 1 : status = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Home", false),
      body: (status == 0)
          ? const HomeLoading()
          : SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              child: SafeArea(
                  child: Padding(
                padding: Paddings.maincontent,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28),
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Theme.of(context).cardColor,
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 25,
                              offset: Offset(0, 4),
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 25, horizontal: 25),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Welcome",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      (listCount == 0)
                                          ? 'You currently do not have any journeys planned'
                                          : 'You have $listCount Journey(s) Planned',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            JourneyPlanner(user: widget.user)),
                                  );
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.add_circle,
                                      size: 30,
                                    ),
                                    Text('Add a journey',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28),
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Theme.of(context).cardColor,
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 25,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Card(
                          color: Colors.transparent,
                          shadowColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40.0),
                            child: GridView(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              // crossAxisCount: 3,
                              children: [
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Image.asset(
                                          'assets/images/ticket.png'),
                                      iconSize: 40,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const PNRStatus()),
                                        );
                                      },
                                    ),
                                    Text('PNR\nStatus',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall)
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Image.asset(
                                          'assets/images/train.png'),
                                      iconSize: 40,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const TrainSchedule()),
                                        );
                                      },
                                    ),
                                    Text('Train\nSchedule',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall)
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Image.asset(
                                          'assets/images/destination.png'),
                                      iconSize: 40,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  JourneyPlanner(
                                                      user: widget.user)),
                                        );
                                      },
                                    ),
                                    Text('Journey\nPlanner',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall)
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Image.asset(
                                          'assets/images/review.png'),
                                      iconSize: 40,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FeedbackComp()),
                                        );
                                      },
                                    ),
                                    Text('Feedback &\nComplaints',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall)
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon:
                                          Image.asset('assets/images/bell.png'),
                                      iconSize: 40,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NotificationPage1()),
                                        );
                                      },
                                    ),
                                    Text('Notification\nControl',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall)
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Image.asset(
                                          'assets/images/emergency-call.png'),
                                      iconSize: 40,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const EmergencyContacts()),
                                        );
                                      },
                                    ),
                                    Text('Emergency\nContacts',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
            ),
    );
  }
}
