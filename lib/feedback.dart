import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickalert/quickalert.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

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
    Future<void> submitFeedback(fbcoll, fbstring) {
      return fbcoll.add({'feedback': fbstring});
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
                    "Feedback & Complaints",
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
                      'Feedback',
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
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    controller: fbcontroller,
                    cursorColor: Colors.black,
                    maxLength: 150,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
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
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () {
                      CollectionReference fbcoll =
                          firestore.collection('feedback');
                      if (fbcontroller.text.trim() != '') {
                        submitFeedback(fbcoll, fbcontroller.text);
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
                    elevation: 0,
                    color: thcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Padding(
                        padding: EdgeInsets.all(17.0),
                        child: Text(
                          'SUBMIT',
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () {},
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(color: Color(0xFFDDDDDD), width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Padding(
                        padding: EdgeInsets.all(17.0),
                        child: Text(
                          'RATE US ON GOOGLE PLAY',
                          style: TextStyle(
                            color: thcolor,
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
