// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/phone.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:myrailguide/widgets/custombutton.dart';
import 'package:myrailguide/widgets/loading.dart';

class ProfilePage extends StatefulWidget {
  final User? user;
  const ProfilePage({super.key, this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int status = 0;
  TextEditingController namecontroller = TextEditingController();
  User? realuser;
  void showChangeDisplayNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text("Change Name"),
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          content: TextField(
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.black),
            autofocus: true,
            controller: namecontroller,
            decoration: const InputDecoration(
              labelText: 'New Display Name',
            ),
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
                Navigator.of(context).pop();
                String newDisplayName = namecontroller.text.trim();
                await updateDisplayName(newDisplayName);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text("Are you sure you want to Log out?"),
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (Navigator.canPop(context)) {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                }
                if (Navigator.canPop(context)) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Myphone()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Myphone()),
                  );
                }
                // Close the dialog
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  changeStatus() {
    setState(() {
      (status == 0) ? status = 1 : status = 0;
    });
  }

  changeProfilePic() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    changeStatus();
    if (image == null) return;
    final imageref =
        FirebaseStorage.instance.ref().child('profiles/${realuser!.uid}.jpg');
    File file = File(image.path);
    await imageref.putFile(file);
    final dloadlink = await imageref.getDownloadURL();
    await realuser?.updatePhotoURL(dloadlink);
    await realuser?.reload();
    setState(() {
      realuser = FirebaseAuth.instance.currentUser;
    });

    changeStatus();
  }

  @override
  void initState() {
    super.initState();
    realuser = widget.user;
    changeStatus();
  }

  Future<void> updateDisplayName(String newDisplayName) async {
    changeStatus();
    await realuser?.updateDisplayName(newDisplayName);
    await realuser?.reload();
    // Refresh the user data from Firebase

    setState(() {
      realuser = FirebaseAuth.instance.currentUser;
    });

    changeStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Profile", false),
      body: (status == 0)
          ? const ProfileLoading()
          : SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SafeArea(
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
                            foregroundImage: NetworkImage((widget
                                        .user?.photoURL ==
                                    null)
                                ? "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_1280.png"
                                : realuser?.photoURL as String),
                          ),
                        ]),
                        ElevatedButton(
                          onPressed: () async {
                            changeProfilePic();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.white, // <-- Splash color
                          ),
                          child: Icon(Icons.edit,
                              color: Theme.of(context).primaryColor),
                        )
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          (realuser?.displayName == null ||
                                  realuser?.displayName == "")
                              ? "MyRailGuide User"
                              : realuser?.displayName as String,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          (realuser?.phoneNumber == null)
                              ? ""
                              : realuser?.phoneNumber as String,
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
                            onTap: () {
                              showLogoutDialog();
                            }),
                        // onTap: () async {
                        //   await FirebaseAuth.instance.signOut();
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const Myphone()),
                        //   );
                        // }),
                      )
                    ],
                  ),
                ),
              )),
            ),
    );
  }
}
