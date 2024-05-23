import 'package:flutter/material.dart';
import 'package:myrailguide/widgets/customappbar.dart';

class WorkInProgress extends StatelessWidget {
  const WorkInProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Work In Progress", true),
      body: const SafeArea(
          child: Center(
        child: Text("WORK IN PROGRESS"),
      )),
    );
  }
}
