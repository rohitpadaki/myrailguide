import 'package:flutter/material.dart';
import 'package:myrailguide/feedback.dart';
import 'package:myrailguide/pnrstatus.dart';
import 'package:myrailguide/trainschedule.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const Color bgcolor = Color(0xFFF5F5F5);
    const Color thcolor = Color(0xFF225FDE);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(
          backgroundColor: bgcolor,
          elevation: 0,
          leading: null,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: const Padding(
            padding: EdgeInsets.only(left: 35, right: 35, top: 20),
            child: Text(
              "MyRailGuide",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Urbanist",
                  fontSize: 36,
                  fontWeight: FontWeight.w700),
            ),
          ),
          toolbarHeight: 72,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Urbanist",
                    fontSize: 25,
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
                    color: Colors.white,
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
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Welcome",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Urbanist",
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'You currently do not have any journeys planned',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.50,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Row(
                            children: [
                              Icon(
                                Icons.add_circle,
                                size: 30,
                                color: thcolor,
                              ),
                              Text(
                                'Add a journey',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                  letterSpacing: 0.15,
                                ),
                              )
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
                    color: Colors.white,
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
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                icon: Image.asset('assets/images/ticket.png'),
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
                              const Text(
                                'PNR\nStatus',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                  letterSpacing: 0.40,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Image.asset('assets/images/train.png'),
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
                              const Text(
                                'Train\nSchedule',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                  letterSpacing: 0.40,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Image.asset(
                                    'assets/images/destination.png'),
                                iconSize: 40,
                                onPressed: () {},
                              ),
                              const Text(
                                'Journey\nPlanner',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                  letterSpacing: 0.40,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Image.asset('assets/images/review.png'),
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
                              const Text(
                                'Feedback &\nComplaints',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                  letterSpacing: 0.40,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Image.asset('assets/images/bell.png'),
                                iconSize: 40,
                                onPressed: () {},
                              ),
                              const Text(
                                'Notification\nControl',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                  letterSpacing: 0.40,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Image.asset(
                                    'assets/images/emergency-call.png'),
                                iconSize: 40,
                                onPressed: () {},
                              ),
                              const Text(
                                'Emergency\nContacts',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                  letterSpacing: 0.40,
                                ),
                              )
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
