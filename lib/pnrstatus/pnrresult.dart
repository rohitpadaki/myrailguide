import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myrailguide/auth.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/planner/addjourney.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:myrailguide/widgets/custombutton.dart';
import 'package:myrailguide/widgets/loading.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

// import 'package:myrailguide/loading.dart';

class PNRResult extends StatefulWidget {
  final User? user;
  final String pnrno;
  const PNRResult({super.key, required this.pnrno, this.user});

  @override
  State<PNRResult> createState() => _PNRResultState();
}

class _PNRResultState extends State<PNRResult> {
  int status = 0;

  Map<String, dynamic>? pnrResult;
  Future<void> fetchPNR(String pnr) async {
    var db = await mongo.Db.create(Environment.mongoServerUrl);
    await db.open();
    pnrResult =
        await db.collection('pnr').findOne(mongo.where.eq('pnrno', pnr));
  }

  change(int num) {
    setState(() {
      status = num;
    });
  }

  changeScreen(src) async {
    await fetchPNR(widget.pnrno);
    if (pnrResult != null) {
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
                          user: widget.user,
                          res: pnrResult,
                        )
                      : const CantFindPNR()),
        ));
  }
}

class PNRResPage extends StatefulWidget {
  final User? user;
  final Map<String, dynamic>? res;
  const PNRResPage({super.key, required this.res, this.user});

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
              child: Text('PNR: ${widget.res?['pnrno']}',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                  '${widget.res?['train_name']} (${widget.res?['train_no']})',
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
                      Text('${widget.res?['departure']['date']}',
                          style: Theme.of(context).textTheme.labelMedium),
                      Text('${widget.res?['departure']['time']}',
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text('${widget.res?['source']['station']}',
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
                      Text('${widget.res?['arrive']['date']}',
                          style: Theme.of(context).textTheme.labelMedium),
                      Text('${widget.res?['arrive']['time']}',
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text('${widget.res?['destination']['station']}',
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
                          child: Text('${getfull(widget.res?['charting'])}',
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => JourneyPlanner(
                              user: widget.user,
                              sentPnr: widget.res?['pnrno'],
                            )),
                  );
                },
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
