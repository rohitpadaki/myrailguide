import 'package:flutter/material.dart';
import 'package:myrailguide/auth.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:myrailguide/widgets/custombutton.dart';
import 'package:quickalert/quickalert.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class FeedbackComp extends StatefulWidget {
  const FeedbackComp({super.key});

  @override
  State<FeedbackComp> createState() => _FeedbackCompState();
}

class _FeedbackCompState extends State<FeedbackComp> {
  @override
  @override
  Widget build(BuildContext context) {
    TextEditingController fbcontroller = TextEditingController();

    Future<void> submitFeedback(fbstring) async {
      var db = await mongo.Db.create(Environment.mongoServerUrl);
      await db.open();
      db.collection('feedback').insert({"feedback": fbstring});
    }

    return Scaffold(
        appBar: buildAppBar(context, "Feedback & Complaints", true),
        body: SafeArea(
          child: Padding(
              padding: Paddings.maincontent,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Feedback',
                        style: Theme.of(context).textTheme.headlineSmall),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    controller: fbcontroller,
                    cursorColor: Theme.of(context).dividerColor,
                    maxLength: 150,
                    style: Theme.of(context).textTheme.titleSmall,
                    decoration: InputDecoration(
                      // filled: true,
                      // fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xFFDDDDDD), width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xFFAAAAAA), width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: PrimaryButton(
                    onTap: () {
                      if (fbcontroller.text.trim() != '') {
                        submitFeedback(fbcontroller.text);
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          title: "Thank you!",
                          text:
                              "Your feedback is very valuable to help us improve!",
                          autoCloseDuration: const Duration(milliseconds: 2800),
                          showConfirmBtn: false,
                        );
                      } else {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: "Feedback cannot be empty!",
                          autoCloseDuration: const Duration(milliseconds: 3000),
                          showConfirmBtn: false,
                        );
                      }
                    },
                    text: 'SUBMIT',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: SecondaryButton(
                    text: "RATE US ON GOOGLE PLAY",
                    onTap: () {},
                  ),
                ),
              ])),
        ));
  }
}
