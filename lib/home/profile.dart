// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/phone.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:myrailguide/widgets/custombutton.dart';

class ProfilePage extends StatefulWidget {
  final User? user;
  const ProfilePage({super.key, this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController namecontroller = TextEditingController();

  void showChangeDisplayNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextField(
            style: const TextStyle(
                color: Colors.black, fontFamily: "Urbanist", fontSize: 18),
            controller: namecontroller,
            decoration: const InputDecoration(labelText: 'New Display Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String newDisplayName = namecontroller.text.trim();
                await updateDisplayName(newDisplayName);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateDisplayName(String newDisplayName) async {
    try {
      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(newDisplayName);
      // Refresh the user data from Firebase
      await FirebaseAuth.instance.currentUser?.reload();
      setState(() {
        widget.user?.reload();
      });
    } catch (error) {
      // Handle error updating display name
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Profile", false),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
          child: Column(
            children: [
              Stack(alignment: Alignment.bottomRight, children: [
                Stack(alignment: Alignment.center, children: [
                  CircleAvatar(
                    radius: 105,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white,
                    foregroundImage: NetworkImage((widget.user?.photoURL ==
                            null)
                        ? "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_1280.png"
                        : widget.user?.photoURL as String),
                  ),
                ]),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10),
                    backgroundColor: Colors.white, // <-- Splash color
                  ),
                  child:
                      Icon(Icons.edit, color: Theme.of(context).primaryColor),
                )
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  (widget.user?.displayName == null ||
                          widget.user?.displayName == "")
                      ? "MyRailGuide User"
                      : widget.user?.displayName as String,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  (widget.user?.phoneNumber == null)
                      ? ""
                      : widget.user?.phoneNumber as String,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Padding(
                padding: Paddings.buttonpad,
                child: PrimaryButton(
                    text: "CHANGE DISPLAY NAME",
                    onTap: () {
                      showChangeDisplayNameDialog();
                    }),
              ),
              Padding(
                padding: Paddings.buttonpad,
                child: SecondaryButton(
                    text: "LOGOUT",
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Myphone()),
                      );
                    }),
              )
            ],
          ),
        ),
      )),
    );
  }
}
