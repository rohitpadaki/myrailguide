import 'package:flutter/material.dart';
import 'package:myrailguide/trainresult.dart';

class TrainSchedule extends StatefulWidget {
  const TrainSchedule({super.key});

  @override
  State<TrainSchedule> createState() => _TrainScheduleState();
}

class _TrainScheduleState extends State<TrainSchedule> {
  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController traincontroller = TextEditingController();
    bool verifyFormat() {
      if (traincontroller.text == '' || !isNumeric(traincontroller.text)) {
        return false;
      }
      return true;
    }

    const Color bgcolor = Color(0xFFF5F5F5);
    const Color thcolor = Color(0xFF225FDE);
    return Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(
          backgroundColor: bgcolor,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 20),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 30,
                    color: Colors.black,
                  )),
            )
          ],
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
              child: Column(children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Train Schedule",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Urbanist",
                      fontSize: 25,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter Train Number',
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
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: traincontroller,
                    cursorColor: Colors.black,
                    // decoration: InputDecoration(
                    //   filled: true,
                    //   fillColor: Colors.white,
                    //   enabledBorder: OutlineInputBorder(
                    //     borderSide: const BorderSide(
                    //         color: Color(0xFFDDDDDD), width: 1),
                    //     borderRadius: BorderRadius.circular(15),
                    //   ),
                    //   focusedBorder: OutlineInputBorder(
                    //     borderSide: const BorderSide(
                    //         color: Color(0xFFDDDDDD), width: 1),
                    //     borderRadius: BorderRadius.circular(15),
                    //   ),
                    // ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () {
                      if (verifyFormat()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TrainResult(trainno: traincontroller.text)),
                        );
                      }
                    },
                    elevation: 0,
                    color: thcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Padding(
                        padding: EdgeInsets.all(17.0),
                        child: Text(
                          'GET SCHEDULE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: 1.25,
                          ),
                        )),
                  ),
                ),
              ])),
        ));
  }
}
