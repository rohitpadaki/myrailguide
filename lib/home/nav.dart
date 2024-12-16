import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myrailguide/booking/booking.dart';
import 'package:myrailguide/home/homepage.dart';
import 'package:myrailguide/home/mynav.dart';
import 'package:myrailguide/home/profile.dart';
import 'package:myrailguide/padding.dart';

class Navbar extends StatefulWidget {
  final User? user;
  const Navbar({super.key, this.user});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  // final List<Widget> screens = [
  //   const HomePage(),
  //   const HomePage(),
  //   const HomePage(),
  // ];
  final pageController = PageController();
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    User? currentUser = widget.user;
    // print(currentPageIndex);
    return Scaffold(
      // backgroundColor: Colors.cyan,
      extendBody: true,
      body: PageView(
          controller: pageController,
          onPageChanged: (int i) {
            setState(() {
              currentPageIndex = i;
            });
          },
          children: [
            HomePage(user: currentUser),
            JourneyPlanner(
              backbutton: false,
              user: currentUser,
            ),
            // const Booking(),
            ProfilePage(
              user: currentUser,
            ),
          ]),
      bottomNavigationBar: Padding(
        padding: Paddings.doublepad,
        child: MyNav(
            pageIndex: currentPageIndex,
            onTap: (int i) {
              setState(() {
                currentPageIndex = i;
                pageController.animateToPage(currentPageIndex,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear);
              });
            }),
      ),
    );
  }
}
