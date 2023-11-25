import 'package:flutter/material.dart';
import 'package:myrailguide/loading.dart';

class PNRResult extends StatefulWidget {
  const PNRResult({super.key});

  @override
  State<PNRResult> createState() => _PNRResultState();
}

class _PNRResultState extends State<PNRResult> {
  bool status = true;
  @override
  Widget build(BuildContext context) {
    const Color bgcolor = Color(0xFFF5F5F5);

    change() {
      setState(() {
        status = (status) ? false : true;
      });
    }

    return SafeArea(
        child: Scaffold(
            backgroundColor: bgcolor,
            appBar: AppBar(
              backgroundColor: bgcolor,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 20),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 30,
                        color: Colors.black,
                      )),
                )
              ],
              leading: null,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              title: const Padding(
                padding: EdgeInsets.only(left: 35, right: 35, top: 20),
                child: Text(
                  "MyRailGuide",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Urbanist",
                      fontSize: 36,
                      fontWeight: FontWeight.w700),
                ),
              ),
              toolbarHeight: 72,
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Column(children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Train Schedule",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Urbanist",
                            fontSize: 25,
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          change();
                        },
                        child: const Text("CHANGE"),
                      ),
                      status ? const PNRLoading() : const PNRDetails(),
                    ])),
              ),
            )));
  }
}

class PNRDetails extends StatefulWidget {
  const PNRDetails({super.key});

  @override
  State<PNRDetails> createState() => _PNRDetailsState();
}

class _PNRDetailsState extends State<PNRDetails> {
  @override
  Widget build(BuildContext context) {
    return const Text("HELLO");
  }
}
