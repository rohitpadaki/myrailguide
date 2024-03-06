import 'package:flutter/material.dart';
import 'package:myrailguide/chatbot/chatresult.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:myrailguide/widgets/custombutton.dart';
import 'package:quickalert/quickalert.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController queryController = TextEditingController();
    bool verifyFormat() {
      // if (queryController.text == '' || !isNumeric(queryController.text)) {
      //   return false;
      // }
      return true;
    }

    return Scaffold(
        appBar: buildAppBar(context, "Chatbot", false),
        body: SafeArea(
          child: Padding(
              padding: Paddings.maincontent,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Enter Your Query',
                        style: Theme.of(context).textTheme.headlineSmall),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    controller: queryController,
                    cursorColor: Theme.of(context).dividerColor,
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
                                  ChatResult(query: queryController.text)),
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
                    text: 'GET RESPONSE',
                  ),
                ),
              ])),
        ));
  }
}
