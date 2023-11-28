import 'package:flutter/material.dart';
import 'package:myrailguide/homepage.dart';
import 'package:myrailguide/mynav.dart';
import 'package:myrailguide/pnrstatus.dart';
import 'package:myrailguide/trainschedule.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

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
          children: const [
            HomePage(),
            TrainSchedule(),
            PNRStatus(),
          ]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 35),
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
