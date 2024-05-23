import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myrailguide/booking/booking_result.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:myrailguide/widgets/custombutton.dart';
import 'package:quickalert/quickalert.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);
  @override
  State<Booking> createState() => _Booking();
}

class _Booking extends State<Booking> {
  @override
  void initState() {
    // getClientStream();
    super.initState();
  }

  bool tripType = true;
  final TextEditingController _fromTec = TextEditingController();
  final TextEditingController _toTec = TextEditingController();
  final TextEditingController _dateController1 = TextEditingController();
  final TextEditingController _dateController2 = TextEditingController();
  int flag = 1;

  Future<void> _selectDate1() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController1.text = picked.toString().split(" ")[0];
      });
    }
  }

  bool verifyFormat() {
    if (_fromTec.text.trim() == '' ||
        _toTec.text.trim() == '' ||
        _dateController1.text.trim() == '') return false;
    if (flag == 0 && _dateController2.text.trim() == "") return false;
    if (DateTime(
      DateTime.parse(_dateController1.text).year,
      DateTime.parse(_dateController1.text).month,
      DateTime.parse(_dateController1.text).day,
    ).isBefore(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ))) return false;
    if (flag == 0 &&
        DateTime(
          DateTime.parse(_dateController2.text).year,
          DateTime.parse(_dateController2.text).month,
          DateTime.parse(_dateController2.text).day,
        ).isBefore(DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ))) return false;
    if (flag == 0 &&
        DateTime(
          DateTime.parse(_dateController2.text).year,
          DateTime.parse(_dateController2.text).month,
          DateTime.parse(_dateController2.text).day,
        ).isBefore(DateTime(
          DateTime.parse(_dateController1.text).year,
          DateTime.parse(_dateController1.text).month,
          DateTime.parse(_dateController1.text).day,
        ))) return false;
    return true;
  }

  Future<void> _selectDate2() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController2.text = picked.toString().split(" ")[0];
      });
    }
  }

  List searchResult = [];

  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('search')
        .where('string_id_array', arrayContains: query)
        .get();

    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, "Book Your Ticket", false),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 32),
                        height: 64,
                        width: MediaQuery.of(context).size.width - 160,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(32)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    tripType = true;
                                    tripType ? flag = 1 : flag = 0;
                                  });
                                },
                                child: tripType
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "One Trip",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          "One Trip",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    tripType = false;
                                    tripType ? flag = 1 : flag = 0;
                                  });
                                },
                                child: !tripType
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Round Trip",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          "Round Trip",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                              ),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 140,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          top: 0,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Row(
                                    children: [
                                      const Text("From",
                                          style: TextStyle(
                                              fontFamily: "Urbanist",
                                              fontSize: 16,
                                              color: Colors.grey)),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: TextField(
                                          controller: _fromTec,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Urbanist"),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Row(
                                    children: [
                                      const Text("To",
                                          style: TextStyle(
                                              fontFamily: "Urbanist",
                                              fontSize: 16,
                                              color: Colors.grey)),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: TextField(
                                          controller: _toTec,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Urbanist"),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                        Positioned(
                            right: 16,
                            bottom: 16,
                            top: 16,
                            child: GestureDetector(
                              onTap: () {
                                final tmpText = _fromTec.text;
                                _fromTec.text = _toTec.text;
                                _toTec.text = tmpText;
                                setState(() {});
                              },
                              child: Center(
                                child: CircleAvatar(
                                  radius: 32,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  foregroundColor: Colors.white,
                                  child: const Icon(
                                    Icons.sync,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _dateController1,
                            style: const TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              fillColor: Theme.of(context).cardColor,
                              labelStyle: TextStyle(
                                  color: Color(0xFF000000 +
                                      0xFF000000 -
                                      Theme.of(context)
                                          .scaffoldBackgroundColor
                                          .value)),
                              labelText: "Date",
                              filled: true,
                              prefixIcon: Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: Color(0xFF000000 +
                                    0xFF000000 -
                                    Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .value),
                              ),
                              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            readOnly: true,
                            onTap: () {
                              _selectDate1();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: TextField(
                            enabled: flag == 0,
                            controller: _dateController2,
                            style: const TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              fillColor: Theme.of(context).cardColor,
                              labelStyle: TextStyle(
                                  color: (flag == 0)
                                      ? Color(0xFF000000 +
                                          0xFF000000 -
                                          Theme.of(context)
                                              .scaffoldBackgroundColor
                                              .value)
                                      : Colors.grey),
                              labelText: "Return",
                              filled: true,
                              prefixIcon: Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: (flag == 0)
                                    ? Color(0xFF000000 +
                                        0xFF000000 -
                                        Theme.of(context)
                                            .scaffoldBackgroundColor
                                            .value)
                                    : Colors.grey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            readOnly: true,
                            onTap: () {
                              _selectDate2();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const Text("Passenger",
                  //         style:
                  //             TextStyle(fontFamily: "Urbanist", fontSize: 16)),
                  //     Container(
                  //         height: 42,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(32),
                  //             border:
                  //                 Border.all(color: Colors.grey, width: 1.5)),
                  //         child: Row(
                  //           children: [
                  //             IconButton(
                  //                 onPressed: () {
                  //                   _counter--;
                  //                   if (_counter <= 1) {
                  //                     _counter = 1;
                  //                   }
                  //                   setState(() {});
                  //                 },
                  //                 icon: Icon(
                  //                   Icons.remove,
                  //                   color: _counter == 1
                  //                       ? Colors.grey
                  //                       : Colors.black,
                  //                 )),
                  //             Text("$_counter",
                  //                 style: const TextStyle(
                  //                     fontFamily: "Urbanist", fontSize: 16)),
                  //             IconButton(
                  //                 onPressed: () {
                  //                   setState(() {
                  //                     _counter++;
                  //                     if (_counter >= 3) {
                  //                       _counter = 3;
                  //                     }
                  //                   });
                  //                 },
                  //                 icon: Icon(Icons.add,
                  //                     color: _counter == 3
                  //                         ? Colors.grey
                  //                         : Color(0xFF000000 + 0xFF000000 - Theme.of(context).scaffoldBackgroundColor.value))),
                  //           ],
                  //         ))
                  //   ],
                  // ),

                  PrimaryButton(
                      text: "Search",
                      onTap: () {
                        if (verifyFormat()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookingResult(
                                      fromStation: _fromTec.text,
                                      toStation: _toTec.text,
                                      date: DateTime.parse(
                                          _dateController1.text))));
                        } else {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            title: "Invalid Details",
                            text:
                                "Please verify entered details and try again!",
                            autoCloseDuration:
                                const Duration(milliseconds: 3000),
                            showConfirmBtn: false,
                          );
                        }
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
