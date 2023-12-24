import 'package:flutter/material.dart';
import 'package:myrailguide/padding.dart';

AppBar buildAppBar(BuildContext context, String subtitle, bool back) {
  return AppBar(
    actions: (!back)
        ? null
        : [
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
    title: Padding(
      padding: Paddings.appbar,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MyRailGuide",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    ),
  );
}
