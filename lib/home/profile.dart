import 'package:flutter/material.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:myrailguide/widgets/custombutton.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                  const CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white,
                    foregroundImage: NetworkImage(
                        "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_1280.png"),
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
                  "Rohit B Padaki",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "+91 9481541885",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Padding(
                padding: Paddings.buttonpad,
                child: PrimaryButton(text: "CHANGE DISPLAY NAME", onTap: () {}),
              ),
              Padding(
                padding: Paddings.buttonpad,
                child: SecondaryButton(text: "LOGOUT", onTap: () {}),
              )
            ],
          ),
        ),
      )),
    );
  }
}
