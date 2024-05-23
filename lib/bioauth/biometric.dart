import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:myrailguide/home/nav.dart';

class Biometric extends StatefulWidget {
  final User? userData;
  const Biometric({super.key, this.userData});

  @override
  State<Biometric> createState() => _BiometricState();
}

class _BiometricState extends State<Biometric> {
  final LocalAuthentication auth = LocalAuthentication();
  checkAuth() async {
    bool isAvailable;
    isAvailable = await auth.canCheckBiometrics;
    if (isAvailable) {
      bool result = await auth.authenticate(
        localizedReason: "Scan your fingerprint to proceed",
      );
      if (result) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Navbar(
                      user: widget.userData,
                    )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int invColor = 0xFFFFFFFF -
        Theme.of(context).scaffoldBackgroundColor.value +
        0xFF000000;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Padding(padding: EdgeInsets.only(top: 100)),
              Image.asset(
                'assets/images/fingerprint.gif',
                height: 200,
                width: 300,
                color: Color(invColor),
                colorBlendMode: BlendMode.difference,
              ),
              const Text("MyRailGuide",
                  style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 51,
                      fontWeight: FontWeight.w700)),
              const Text('Welcome! Your one stop solution for',
                  style: TextStyle(fontFamily: 'Urbanist', fontSize: 16)),
              const Text('all your railway enquiries',
                  style: TextStyle(fontFamily: 'Urbanist', fontSize: 16)),
              const SizedBox(
                height: 35,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 250)),
              MaterialButton(
                color: const Color(0xFF225FDE),
                onPressed: () {
                  checkAuth();
                },
                child: const Text(
                  "Authenticate",
                  style: TextStyle(fontSize: 20, fontFamily: 'Urbanist'),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 50))
            ]),
          ),
        ),
      ),
    );
  }
}
