import 'package:flutter/material.dart';
import 'package:myrailguide/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myrailguide/timeline.dart';

class TrainResult extends StatefulWidget {
  final String? trainno;
  const TrainResult({super.key, this.trainno});

  @override
  State<TrainResult> createState() => _TrainResultState();
}

class _TrainResultState extends State<TrainResult> {
  int status = 0;
  Map<String, dynamic>? res;

  Future<Map<String, dynamic>?> fetchData(trainno) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
          .instance
          .collection('train')
          .doc(trainno)
          .get();

      String trainName = document['trainname'];
      List<bool> week = List<bool>.from(document['week']);
      int trainNo = document['trainno'];
      var sch = document['schedule'];

      DocumentReference<Map<String, dynamic>> fromRef = document['from'];
      DocumentReference<Map<String, dynamic>> toRef = document['to'];

      DocumentSnapshot<Map<String, dynamic>> fromSnapshot = await fromRef.get();
      Map<String, dynamic> fromData = fromSnapshot.data()!;

      DocumentSnapshot<Map<String, dynamic>> toSnapshot = await toRef.get();
      Map<String, dynamic> toData = toSnapshot.data()!;
      List<dynamic> schedules = [];
      for (var i in sch) {
        DocumentReference<Map<String, dynamic>> stat = i['station'];
        Map<String, dynamic> time = {"time": i['time']};
        DocumentSnapshot<Map<String, dynamic>> fromSnapshot = await stat.get();
        Map<String, dynamic> fromData = fromSnapshot.data()!;
        fromData.addAll(time);
        schedules.add(fromData);
      }
      return {
        'trainName': trainName,
        'week': week,
        'trainNo': trainNo,
        'from': fromData,
        'to': toData,
        'schedule': schedules
      };
    } catch (e) {
      return null;
    }
  }

  change(int num) {
    setState(() {
      status = num;
    });
  }

  work() async {
    res = await fetchData(widget.trainno);
    if (res != null) {
      change(1);
    } else {
      change(2);
    }
  }

  @override
  void initState() {
    super.initState();
    work();
  }

  @override
  Widget build(BuildContext context) {
    const Color bgcolor = Color(0xFFF5F5F5);
    return Scaffold(
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
        body: SafeArea(
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.only(left: 35, right: 35, bottom: 10),
              child: Align(
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
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: status == 0
                      ? const TRSLoading()
                      : status == 1
                          ? TrainDetails(
                              result: res,
                            )
                          : const CantFindTrain()),
            )
          ]),
        ));
  }
}

class TrainDetails extends StatefulWidget {
  final Map<String, dynamic>? result;
  const TrainDetails({super.key, this.result});

  @override
  State<TrainDetails> createState() => _TrainDetailsState();
}

class _TrainDetailsState extends State<TrainDetails> {
  @override
  Widget build(BuildContext context) {
    // print(widget.result['from']);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Container(
              width: double.infinity,
              // height: 120,
              decoration: ShapeDecoration(
                  color: const Color(0xFF225FDE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 25,
                      offset: Offset(0, 4),
                      spreadRadius: 1,
                    )
                  ]),

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      // "hello",
                      "${widget.result?['trainName'].toUpperCase()} (${widget.result?['trainNo']})",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: 0.50,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, top: 5, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            // "Hello",
                            '${widget.result?['from']['station']} \n(${widget.result?['from']['sid']})',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: 0.04,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.swap_horiz_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                        Expanded(
                          child: Text(
                            // "Hello",
                            '${widget.result?['to']['station']} \n(${widget.result?['to']['sid']})',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: 0.04,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 1,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5, top: 10, bottom: 15),
                    child: GridView.count(
                      childAspectRatio: 1.5,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      shrinkWrap: true,
                      crossAxisCount: 7,
                      children: [
                        const Center(
                            child: Text(
                          "Sun",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 0.50,
                          ),
                        )),
                        const Center(
                            child: Text(
                          "Mon",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 0.50,
                          ),
                        )),
                        const Center(
                            child: Text(
                          "Tue",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 0.50,
                          ),
                        )),
                        const Center(
                            child: Text(
                          "Wed",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 0.50,
                          ),
                        )),
                        const Center(
                            child: Text(
                          "Thu",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 0.50,
                          ),
                        )),
                        const Center(
                            child: Text(
                          "Fri",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 0.50,
                          ),
                        )),
                        const Center(
                            child: Text(
                          "Sat",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 0.50,
                          ),
                        )),
                        for (var i in widget.result!['week'])
                          (i)
                              ? const Icon(
                                  Icons.done_rounded,
                                  color: Colors.white,
                                )
                              : Container()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 43, vertical: 10),
            child: Column(
              children: [
                for (var item in widget.result!['schedule'])
                  Timeline(
                      isfirst: widget.result!['schedule']!.indexOf(item) == 0,
                      islast: widget.result!['schedule']!.indexOf(item) ==
                          widget.result!['schedule'].length - 1,
                      payload: item),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CantFindTrain extends StatelessWidget {
  const CantFindTrain({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 2 - 280,
        ),
        Image.asset(
          "assets/images/no-results.png",
          width: 150,
          height: 150,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          child: Text(
            "Couldn't find the train you were looking for.",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Urbanist",
                fontSize: 24,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
