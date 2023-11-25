import 'package:flutter/material.dart';
import 'package:myrailguide/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrainResult extends StatefulWidget {
  final String? trainno;
  const TrainResult({super.key, this.trainno});

  @override
  State<TrainResult> createState() => _TrainResultState();
}

class _TrainResultState extends State<TrainResult> {
  bool status = true;
  Map<String, dynamic>? res;
  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Future<Map<String, dynamic>?> verifyTrain(trainno) async {
    if (!isNumeric(trainno)) return null;
    Map<String, dynamic>? data;
    CollectionReference traincoll =
        FirebaseFirestore.instance.collection('train');
    final query = traincoll.where("trainno", isEqualTo: int.parse(trainno));
    final querySnapshot = await query.get();
    data = (querySnapshot.docs.isNotEmpty)
        ? querySnapshot.docs.first.data() as Map<String, dynamic>
        : null;
    return data;
  }

  change() {
    setState(() {
      status = (status) ? false : true;
    });
  }

  work() async {
    res = await verifyTrain(widget.trainno);
    if (res != null) change();
  }

  @override
  void initState() {
    super.initState();
    work();
  }

  @override
  Widget build(BuildContext context) {
    const Color bgcolor = Color(0xFFF5F5F5);

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
                      status
                          ? const TRSLoading()
                          : TrainDetails(
                              result: res,
                            ),
                    ])),
              ),
            )));
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 23.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
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
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    "${widget.result?['tname'].toUpperCase()} (${widget.result?['trainno']})",
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
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.result?['from'][0]} \n(${widget.result?['from'][1]})',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: 0.04,
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Icon(
                            Icons.swap_horiz_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      Text(
                        '${widget.result?['to'][0]} \n(${widget.result?['to'][1]})',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: 0.04,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
