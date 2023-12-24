import 'package:flutter/material.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/trainschedule/trainresult.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:myrailguide/widgets/custombutton.dart';
import 'package:quickalert/quickalert.dart';

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

    return Scaffold(
        appBar: buildAppBar(context, "Train Schedule", true),
        body: SafeArea(
          child: Padding(
              padding: Paddings.maincontent,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Enter Train Number',
                        style: Theme.of(context).textTheme.headlineSmall),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    controller: traincontroller,
                    cursorColor: Theme.of(context).dividerColor,
                    decoration: const InputDecoration(
                      counterText: "",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: PrimaryButton(
                    onTap: () {
                      if (verifyFormat()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TrainResult(trainno: traincontroller.text)),
                        );
                      } else {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: "Invalid Train Number",
                          text: "Please verify train number and try again!",
                          autoCloseDuration: const Duration(milliseconds: 3000),
                          showConfirmBtn: false,
                        );
                      }
                    },
                    text: 'GET SCHEDULE',
                  ),
                ),
              ])),
        ));
  }
}
