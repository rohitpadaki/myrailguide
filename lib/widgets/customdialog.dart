import 'package:flutter/material.dart';
import 'package:myrailguide/padding.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final String info;
  const CustomCircularProgressIndicator({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: Paddings.dialogpad,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 5,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  info,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
