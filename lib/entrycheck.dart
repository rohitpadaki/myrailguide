import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myrailguide/home/nav.dart';
import 'package:myrailguide/phone.dart';

class EntryCheck extends StatelessWidget {
  const EntryCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Navbar(
            user: snapshot.data,
          );
        } else {
          return const Myphone();
        }
      },
    ));
  }
}
