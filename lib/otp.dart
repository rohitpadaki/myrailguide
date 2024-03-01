// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myrailguide/home/nav.dart';
import 'package:myrailguide/widgets/custombutton.dart';
import 'package:pinput/pinput.dart';
import 'package:quickalert/quickalert.dart';
import 'phone.dart';

class Myotp extends StatefulWidget {
  final String phno;
  static String verify = "";
  const Myotp({super.key, required this.phno});
  @override
  State<Myotp> createState() => _MyotpState();
}

class _MyotpState extends State<Myotp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  void showAlert(
    String tex,
    QuickAlertType quickAlertType,
  ) {
    QuickAlert.show(context: context, type: quickAlertType, text: tex);
  }

  @override
  Widget build(BuildContext context) {
    const String countrycode = "+91";
    String ph = widget.phno;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: Theme.of(context).textTheme.headlineMedium,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).splashColor),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(20),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
    );
    var code = "";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(top: 280)),
                //Image.asset("assets/Images/Untitled6_20231103085203.png",height: 150,width: 150,),
                const Text("MyRailGuide",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 51,
                        fontWeight: FontWeight.bold)),
                const Text('Welcome! Your one stop solution for',
                    style: TextStyle(fontFamily: 'Urbanist', fontSize: 16)),
                const Text(
                  'all your railway enquiries',
                  style: TextStyle(fontFamily: 'Urbanist', fontSize: 16),
                ),
                //SizedBox(height: 35,),
                const Padding(padding: EdgeInsets.only(top: 180)),
                Text(
                  "Verify OTP sent to +91 $ph",
                  style: const TextStyle(fontFamily: 'Urbanist', fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  onChanged: (value) {
                    code = value;
                  },
                  showCursor: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                PrimaryButton(
                    text: "SUBMIT",
                    onTap: () async {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: Myphone.verify, smsCode: code);
                        UserCredential usercred =
                            await auth.signInWithCredential(credential);
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          title: "Logged In!",
                          autoCloseDuration: const Duration(milliseconds: 2800),
                          showConfirmBtn: false,
                        );
                        //showAlert("Succesful!!",QuickAlertType.success);

                        if (Navigator.canPop(context)) {
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        }
                        if (Navigator.canPop(context)) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Navbar(
                                      user: usercred.user,
                                    )),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Navbar(
                                      user: usercred.user,
                                    )),
                          );
                        }
                      } catch (e) {
                        if (code == "") {
                          showAlert("Enter the OTP!!", QuickAlertType.error);
                        } else if (code.length != 6) {
                          showAlert(
                              "Enter 6 digit Otp!!", QuickAlertType.error);
                        } else {
                          showAlert("Wrong OTP", QuickAlertType.error);
                        }
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't Receieve?",
                        style: TextStyle(fontFamily: 'Urbanist', fontSize: 16)),
                    TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: countrycode + ph,
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent:
                                (String verificationId, int? resendToken) {
                              Myotp.verify = verificationId;
                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                          );
                        },
                        child: const Text("Resend OTP",
                            style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 16,
                                color: Color(0xFF225FDE))))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
