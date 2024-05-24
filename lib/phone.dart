import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myrailguide/otp.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/widgets/custombutton.dart';
import 'package:myrailguide/widgets/customdialog.dart';
import 'package:quickalert/quickalert.dart';

class Myphone extends StatefulWidget {
  const Myphone({super.key});
  static String verify = "";
  @override
  State<Myphone> createState() => _MyphoneState();
}

class _MyphoneState extends State<Myphone> {
  String tex = "";
  void showAlert(String tex, QuickAlertType quickAlertType) {
    QuickAlert.show(context: context, type: quickAlertType, text: tex);
  }

  TextEditingController countrycode = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  void initState() {
    countrycode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Paddings.maincontent,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 300)),
                //Image.asset("assets/Images/Untitled6_20231103085203.png",height: 150,width: 150,),
                const Text("MyRailGuide",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 51,
                        fontWeight: FontWeight.bold)),
                const Text('Welcome! Your one stop solution for',
                    style: TextStyle(fontFamily: 'Urbanist', fontSize: 16)),
                const Text('all your railway enquiries',
                    style: TextStyle(fontFamily: 'Urbanist', fontSize: 16)),
                const SizedBox(
                  height: 35,
                ),
                const Padding(padding: EdgeInsets.only(top: 180)),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular((10)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: SizedBox(
                            width: 40,
                            child: TextField(
                              readOnly: true,
                              controller: countrycode,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("|",
                          style: TextStyle(fontSize: 33, color: Colors.grey)),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextField(
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Enter Phone Number",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.grey)),
                      )),
                      //TextField(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                    text: "SEND OTP",
                    onTap: () async {
                      if (phone.text.toString() == "") {
                        // showAlert(
                        //     "Please Enter Your Phone No.", QuickAlertType.error);
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: "Phone Number Required!",
                          text: "Please Enter Your Phone No.",
                          autoCloseDuration: const Duration(milliseconds: 3000),
                          showConfirmBtn: false,
                        );
                      } else if (phone.text.toString().length != 10) {
                        // showAlert("Please Enter 10 digits Phone No.",
                        //     QuickAlertType.error);
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: "Invalid Phone Number!",
                          text: "Please Enter 10 digits Phone No.",
                          autoCloseDuration: const Duration(milliseconds: 3000),
                          showConfirmBtn: false,
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CustomCircularProgressIndicator(
                                  info: "Verifying Captcha...");
                            });
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: countrycode.text + phone.text,
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            Myphone.verify = verificationId;
                            String ph = phone.text.toString();
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Myotp(phno: ph)));
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      }

                      // Navigator.pushNamed(context, "otp", arguments: phone);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
