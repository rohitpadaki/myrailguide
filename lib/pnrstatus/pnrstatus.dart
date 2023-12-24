import 'package:flutter/material.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/pnrstatus/pnrresult.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:myrailguide/widgets/custombutton.dart';

class PNRStatus extends StatefulWidget {
  const PNRStatus({super.key});

  @override
  State<PNRStatus> createState() => _PNRStatusState();
}

class _PNRStatusState extends State<PNRStatus> {
  @override
  Widget build(BuildContext context) {
    TextEditingController pnrcontroller = TextEditingController();
    return Scaffold(
        appBar: buildAppBar(context, "PNR Status", true),
        body: SafeArea(
          child: Padding(
              padding: Paddings.maincontent,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Enter PNR Number',
                        style: Theme.of(context).textTheme.headlineSmall),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: pnrcontroller,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PNRResult(
                                  pnrno: pnrcontroller.text,
                                )),
                      );
                    },
                    text: 'GET DETAILS',
                  ),
                ),
              ])),
        ));
  }
}
