// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:myrailguide/auth.dart';
import 'package:myrailguide/home/nav.dart';
import 'package:myrailguide/widgets/custombutton.dart';
import 'package:myrailguide/widgets/customdialog.dart';
import 'package:pinput/pinput.dart';
import 'package:quickalert/quickalert.dart';
import 'phone.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class Myotp extends StatefulWidget {
  final String phno;
  static String verify = "";
  const Myotp({super.key, required this.phno});
  @override
  State<Myotp> createState() => _MyotpState();
}

class _MyotpState extends State<Myotp> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addToken(user) async {
    Localstore.instance.collection(user!.uid).delete();
    var db = await mongo.Db.create(Environment.mongoServerUrl);
    await db.open();
    String? token = await FirebaseMessaging.instance.getToken();
    var tokenResult =
        await db.collection('token').findOne(mongo.where.eq('user', user.uid));
    if (tokenResult == null) {
      await db.collection('token').insert({
        "user": user.uid,
        "token": token ?? "",
        "status_pnr": true,
        "status_train": true,
        "pnr": [],
        "train": []
      });
    } else {
      print("Updated Token");
      tokenResult['token'] = token;
      tokenResult['pnr'] = [];
      tokenResult['train'] = [];
      await db
          .collection('token')
          .replaceOne(mongo.where.eq('user', user.uid), tokenResult);
    }
  }

  Future<void> showAlert(
    context,
    String tex,
    QuickAlertType quickAlertType,
  ) async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: "Logged In!",
      autoCloseDuration: const Duration(milliseconds: 2800),
      showConfirmBtn: false,
    );
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 30,
                  color: Theme.of(context).dividerColor,
                )),
          )
        ],
        leading: null,
        automaticallyImplyLeading: false,
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
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CustomCircularProgressIndicator(
                                  info: "Verifying OTP...");
                            });
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: Myphone.verify, smsCode: code);
                        UserCredential usercred =
                            await auth.signInWithCredential(credential);
                        await addToken(usercred.user);
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
                        Navigator.pop(context);
                        if (code == "") {
                          showAlert(
                              context, "Enter the OTP!!", QuickAlertType.error);
                        } else if (code.length != 6) {
                          showAlert(context, "Enter 6 digit Otp!!",
                              QuickAlertType.error);
                        } else {
                          showAlert(context, "Wrong OTP", QuickAlertType.error);
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
