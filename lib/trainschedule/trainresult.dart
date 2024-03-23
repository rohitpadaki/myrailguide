import 'package:flutter/material.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:myrailguide/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myrailguide/widgets/timeline.dart';

class TrainResult extends StatefulWidget {
  final String? trainno;
  const TrainResult({super.key, this.trainno});

  @override
  State<TrainResult> createState() => _TrainResultState();
}

class _TrainResultState extends State<TrainResult> {
  int status = 0;
  Map<String, dynamic>? res;

  Future<Map<String, dynamic>?> fetchData(trainno, source) async {
    try {
      var db = FirebaseFirestore.instance;
      DocumentSnapshot<Map<String, dynamic>>? document;
      try {
        document = await db
            .collection('train')
            .doc(trainno)
            .get(GetOptions(source: source));
      } on Exception {
        document = await db
            .collection('train')
            .doc(trainno)
            .get(const GetOptions(source: Source.server));
      }
      String trainName = document['trainname'];
      List<bool> week = List<bool>.from(document['week']);
      String trainNo = document['trainno'];
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
        DocumentSnapshot<Map<String, dynamic>> schSnap = await stat.get();

        Map<String, dynamic> schData = schSnap.data()!;
        schData.addAll(time);
        schedules.add(schData);
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

  Future<void> work(source) async {
    res = await fetchData(widget.trainno, source);
    if (res != null) {
      change(1);
    } else {
      change(2);
    }
  }

  @override
  void initState() {
    super.initState();
    work(Source.cache);
  }

  @override
  Widget build(BuildContext context) {

return Scaffold(
  appBar: buildAppBar(context, "Train Schedule", true),
  body: SafeArea(
    child: Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              change(0);
              return work(Source.server);
            },
            color: Theme.of(context).primaryColor,
            strokeWidth: 3,
            child: SingleChildScrollView(
              child: status == 0
                  ? const TRSLoading()
                  : status == 1
                      ? TrainDetails(
                          result: res,
                        )
                      : const CantFindTrain(),
            ),
          ),
        ),
      ],
    ),
  ),
);

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
            padding: Paddings.maincontent,
            child: Container(
              width: double.infinity,
              // height: 120,
              decoration: ShapeDecoration(
                  color: Theme.of(context).primaryColor,
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
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2 - 280,
          ),
          Image.asset(
            "assets/images/no-results.png",
            width: 140,
            height: 140,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 5),
            child: Text(
              "No results found!",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              "Try checking the entered train number.",
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
