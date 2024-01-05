import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:myrailguide/widgets/custombutton.dart';
import 'package:myrailguide/widgets/loading.dart';

// import 'package:myrailguide/loading.dart';

class PNRResult extends StatefulWidget {
  final String pnrno;
  const PNRResult({super.key, required this.pnrno});

  @override
  State<PNRResult> createState() => _PNRResultState();
}

class _PNRResultState extends State<PNRResult> {
  int status = 0;

  Map<String, dynamic>? res;
  Future<Map<String, dynamic>?> fetchPNR(String pnr, source) async {
    try {
      var db = FirebaseFirestore.instance;
      DocumentSnapshot<Map<String, dynamic>>? document;
      try {
        document =
            await db.collection('pnr').doc(pnr).get(GetOptions(source: source));
      } on Exception {
        document = await db
            .collection('pnr')
            .doc(pnr)
            .get(const GetOptions(source: Source.server));
      }
      List<Map<String, dynamic>> passengers =
          List<Map<String, dynamic>>.from(document['passengers']);
      String chart = document['chart'];
      String pClass = document['class'];
      String remarks = document['remarks'];
      int fare = document['fare'];

      Timestamp depart = document['depart'];
      DateTime departTime = depart.toDate();
      String depTime =
          '${departTime.hour.toString().padLeft(2, '0')}:${departTime.minute.toString().padLeft(2, '0')}';
      String depDate =
          '${departTime.day.toString().padLeft(2, '0')}-${departTime.month.toString().padLeft(2, '0')}-${departTime.year}';

      Timestamp arrive = document['arrive'];

      DateTime arriveTime = arrive.toDate();
      String arrTime =
          '${arriveTime.hour.toString().padLeft(2, '0')}:${arriveTime.minute.toString().padLeft(2, '0')}';
      String arrDate =
          '${arriveTime.day.toString().padLeft(2, '0')}-${arriveTime.month.toString().padLeft(2, '0')}-${arriveTime.year}';

      DocumentReference<Map<String, dynamic>> fromRef = document['src'];
      DocumentReference<Map<String, dynamic>> toRef = document['dst'];
      DocumentReference<Map<String, dynamic>> train = document['train'];

      DocumentSnapshot<Map<String, dynamic>> fromSnapshot = await fromRef.get();
      Map<String, dynamic> fromData = fromSnapshot.data()!;

      DocumentSnapshot<Map<String, dynamic>> toSnapshot = await toRef.get();
      Map<String, dynamic> toData = toSnapshot.data()!;

      DocumentSnapshot<Map<String, dynamic>> trainSnapshot = await train.get();
      Map<String, dynamic> trainData = trainSnapshot.data()!;
      Map<String, dynamic> reqTrain = {
        "train": trainData['trainname'],
        "trainno": trainData['trainno']
      };
      return {
        'src': fromData,
        'dst': toData,
        'train': reqTrain,
        'passengers': passengers,
        'depart': [depDate, depTime],
        'arrive': [arrDate, arrTime],
        'chart': chart,
        'class': pClass,
        'remarks': remarks,
        'fare': fare
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

  changeScreen(src) async {
    res = await fetchPNR(widget.pnrno, src);
    if (res != null) {
      change(1);
    } else {
      change(2);
    }
  }

  @override
  void initState() {
    super.initState();
    changeScreen(Source.server);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: buildAppBar(context, "PNR Status", true),
        body: SafeArea(
          child: SingleChildScrollView(
              child: status == 0
                  ? const PNRLoading()
                  : status == 1
                      ? PNRResPage(
                          res: res,
                          pnrno: widget.pnrno,
                        )
                      : const CantFindPNR()),
        ));
  }
}

class PNRResPage extends StatefulWidget {
  final Map<String, dynamic>? res;
  final String pnrno;
  const PNRResPage({super.key, required this.res, required this.pnrno});

  @override
  State<PNRResPage> createState() => _PNRResPageState();
}

class _PNRResPageState extends State<PNRResPage> {
  String status1 = "CNF";
  String status2 = "CAN";
  String status3 = "WL";
  String status4 = "";

  getfull(String val) {
    switch (val) {
      case "NP":
        return "Not Prepared";
      case "SL":
        return "Sleeper";
      case "P":
        return "Prepared";
      case "3A":
        return "AC 3 Tier";
      case "2A":
        return "AC 2 Tier";
      case "1A":
        return "AC 1 Tier";
      case "2S":
        return "Seater";
      case "CNF":
        return "Confirmed";
      case "CAN":
        return "Cancelled";
      case "WL":
        return "Waiting List";
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "CNF":
        return const Color(0x7F60E290);
      case "CAN":
        return const Color(0x7FF15C6E);
      case "WL":
        return const Color(0x7FF7B731);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.doublepad,
      child: Container(
        width: double.infinity,
        // height: 120,
        decoration: ShapeDecoration(
            color: Theme.of(context).cardColor,
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
              padding: const EdgeInsets.only(top: 13),
              child: Text('PNR: ${widget.pnrno}',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                  '${widget.res?['train']['train']} (${widget.res?['train']['trainno']})',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13.0),
              child: Divider(
                color: Theme.of(context).dividerColor,
                thickness: 1,
                indent: 30,
                endIndent: 30,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.res?['depart'][0]}',
                          style: Theme.of(context).textTheme.labelMedium),
                      Text('${widget.res?['depart'][1]}',
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text('${widget.res?['src']['station']}',
                          style: Theme.of(context).textTheme.labelMedium)
                    ],
                  ),
                  const Icon(
                    Icons.east_rounded,
                    size: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${widget.res?['arrive'][0]}',
                          style: Theme.of(context).textTheme.labelMedium),
                      Text('${widget.res?['arrive'][1]}',
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text('${widget.res?['dst']['station']}',
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.labelMedium)
                    ],
                  )
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              thickness: 1,
              indent: 30,
              endIndent: 30,
            ),
            for (var pass in widget.res?['passengers'])
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: getStatusColor(pass['status']),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${pass['name']}',
                          style: Theme.of(context).textTheme.headlineSmall),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${getfull(pass['status'])}',
                              style: Theme.of(context).textTheme.headlineSmall),
                          Text('${pass['seat']}',
                              style: Theme.of(context).textTheme.headlineSmall)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Class:',
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('${getfull(widget.res?['class'])}',
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Charting Status:',
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('${getfull(widget.res?['chart'])}',
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Total Fare:',
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Rs. ${widget.res?['fare']}',
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Remarks:',
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('${widget.res?['remarks']}',
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text('Have a safe journey! 😊',
                  style: Theme.of(context).textTheme.headlineMedium),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
              child: PrimaryButton(
                onTap: () {},
                text: 'ADD TO JOUNREY PLANNER',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CantFindPNR extends StatelessWidget {
  const CantFindPNR({super.key});

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
              "Try checking the entered PNR number.",
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
