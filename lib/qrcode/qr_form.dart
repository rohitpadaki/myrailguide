import 'package:flutter/material.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:myrailguide/widgets/custombutton.dart';
import 'package:pinput/pinput.dart';
import 'package:quickalert/quickalert.dart';
import 'package:myrailguide/qrcode/qr_result.dart';

class QRCode1 extends StatelessWidget {
  QRCode1({super.key});
  final TextEditingController ticketId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool verifyFormat() {
      if (!ticketId.text.startsWith("TX")) return false;
      if (ticketId.length < 10) return false;
      return true;
    }

    return Scaffold(
      appBar: buildAppBar(context, "QR Code", true),
      body: SafeArea(
        child: Padding(
          padding: Paddings.maincontent,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    const Text("Ticket ID:",
                        style: TextStyle(
                            fontFamily: "Urbanist",
                            fontSize: 16,
                            color: Colors.grey)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: TextField(
                        maxLength: 10,
                        controller: ticketId,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: "Urbanist"),
                        decoration: const InputDecoration(
                          counterText: "",
                          hintText: "TX12345678",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                  text: "Submit",
                  onTap: () {
                    if (verifyFormat()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  QRCodeGenerator(ticket: ticketId.text)));
                    } else {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: "Invalid Ticket ID",
                        text: "Please verify ticket ID and try again!",
                        autoCloseDuration: const Duration(milliseconds: 3000),
                        showConfirmBtn: false,
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
