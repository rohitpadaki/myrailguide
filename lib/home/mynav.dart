import 'package:flutter/material.dart';

class MyNav extends StatelessWidget {
  final Function(int) onTap;
  final int pageIndex;
  const MyNav({super.key, required this.onTap, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    Color thcolor = Theme.of(context).primaryColor;
    Color cardcolor = Theme.of(context).cardColor;
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          // color: Color(0xFF225FDE),
          color: cardcolor,
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 25,
              offset: Offset(0, 4),
              spreadRadius: 1,
            )
          ],
        ),
        // height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavButton(
              Icons.home_rounded,
              pageIndex == 0,
              thcolor,
              cardcolor,
              onTap: () => onTap(0),
            ),
            NavButton(
              Icons.location_pin,
              pageIndex == 1,
              thcolor,
              cardcolor,
              onTap: () => onTap(1),
            ),
            NavButton(
              Icons.person_rounded,
              pageIndex == 2,
              thcolor,
              cardcolor,
              onTap: () => onTap(2),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget NavButton(
      IconData icon, bool selected, Color buttoncolor, Color fillcolor,
      {Function()? onTap}) {
    return AnimatedContainer(
      height: 50,
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: selected ? buttoncolor : null,
      ),
      child: IconButton(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        // color: Colors.red,
        onPressed: onTap,
        splashColor: fillcolor,
        iconSize: 30,
        icon: Icon(
          icon,
          color: selected ? fillcolor : buttoncolor,
        ),
      ),
    );
  }
}
