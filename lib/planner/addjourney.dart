import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:myrailguide/auth.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/pnrstatus/pnrresult.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:myrailguide/widgets/custombutton.dart';
import 'package:myrailguide/widgets/loading.dart';
import 'package:quickalert/quickalert.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class JourneyPlanner extends StatefulWidget {
  final User? user;
  final bool? backbutton;
  final String? sentPnr;
  final String? sentTrain;
  const JourneyPlanner(
      {super.key, this.user, this.backbutton, this.sentPnr, this.sentTrain});
  @override
  State<JourneyPlanner> createState() => _JourneyPlannerState();
}

class _JourneyPlannerState extends State<JourneyPlanner> {
  int status = 0;
  var flag = 0;
  List<DynamicWidget> listDynamic = [];
  // addDynamic() {
  //   listDynamic.add(DynamicWidget());
  //   setState(() {});
  // }
  void showAlert(String tex, QuickAlertType quickAlertType) {
    QuickAlert.show(context: context, type: quickAlertType, text: tex);
  }

  void fetchLocalStoreData() async {
    Localstore.instance.collection(widget.user!.uid).get().then((value) {
      if (value != null) {
        value.forEach((key, data) {
          // Create a DynamicWidget for each document and add it to the list
          DynamicWidget dynamicWidget = DynamicWidget(
            callback: updateState,
            user: widget.user,
            pnr: data['pnrno'],
            trainno: data['trainno'],
            train: data['train_name'],
            to: data['destination']['sid'],
            from: data['source']['sid'],
          );
          listDynamic.add(dynamicWidget);
        });
      }
      setState(() {
        status = 1;
      });
    });
    // Localstore.instance.collection(widget.user!.uid).delete();
  }

  void updateState() {
    setState(() {
      listDynamic = [];
      fetchLocalStoreData();
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.sentPnr != null) {
      submit(widget.sentPnr);
    }
    fetchLocalStoreData();
  }

  static String pnrno = "";

  TextEditingController pnr = TextEditingController();
  Future openDialog() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                title: const Text("PNR Number"),
                titleTextStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                content: TextField(
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Colors.black),
                  autofocus: true,
                  controller: pnr,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    pnrno = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your PNR No.',
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        submit(pnrno);
                      },
                      child: const Text(
                        "SUBMIT",
                        style: TextStyle(fontFamily: "Urbanist"),
                      ))
                ]));
  }

  Future<Map<String, dynamic>?> fetchPNR(pnrno) async {
    var db = await mongo.Db.create(Environment.mongoServerUrl);
    await db.open();
    Map<String, dynamic>? pnrResult =
        await db.collection('pnr').findOne(mongo.where.eq('pnrno', pnrno));
    return pnrResult;
  }

  void submit(pnrVal) async {
    setState(() {
      status = 0;
    });
    if (pnrVal == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("PNR Number can't be empty!"),
      ));
      // showAlert("Please Enter The PNR Number", QuickAlertType.error);
    } else if (pnrVal.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('PNR Number should be of 10 digits!'),
      ));
      // flag = 1;
      // Navigator.of(context).pop();
    } else {
      Map<String, dynamic>? res = await fetchPNR(pnrVal);
      if (res != null) {
        // Add the new PNR to the local store
        for (var item in listDynamic) {
          if (item.pnr == pnrVal) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('The PNR number already exists!'),
            ));
            return;
          }
        }
        Localstore.instance.collection(widget.user!.uid).doc(pnrVal).set(res);
        // Create a new DynamicWidget for the new PNR and add it to listDynamic
        DynamicWidget dynamicWidget = DynamicWidget(
          callback: updateState,
          pnr: pnrVal,
          train: res['train_name'],
          trainno: res['train_no'],
          to: res['destination']['sid'],
          from: res['source']['sid'],
          user: widget.user,
        );
        var db = await mongo.Db.create(Environment.mongoServerUrl);
        await db.open();
        Map<String, dynamic>? userResult = await db
            .collection('token')
            .findOne(mongo.where.eq('user', widget.user?.uid));
        if (userResult != null) {
          userResult['pnr'].add(pnrVal);
          userResult['train'].add(res['train_no']);

          await db
              .collection('token')
              .replaceOne(mongo.where.eq('user', widget.user?.uid), userResult);
        }
        setState(() {
          listDynamic.add(dynamicWidget);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Could not find PNR Number!'),
        ));
      }
      setState(() {
        status = 1;
      });
      // showAlert("PNR Number Consists of 10 Digits", QuickAlertType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (flag == 0) fetchLocalStoreData();
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context, "Journey Planner",
            (widget.backbutton == null) ? true : false),
        floatingActionButton: (widget.backbutton != null)
            ? null
            : Padding(
                padding: const EdgeInsets.all(10),
                child: FloatingActionButton(
                  onPressed: () {
                    openDialog();
                  },
                  backgroundColor: const Color(0xFF225FDE),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Ink(
                    width: 60,
                    height: 60,
                    child: const Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
        body: SafeArea(
          child: (status == 1)
              ? SingleChildScrollView(
                  child: Padding(
                    padding: Paddings.maincontent,
                    child: Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: (listDynamic.isEmpty)
                              ? [
                                  Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Center(
                                        child: Text(
                                      "No Journeys Planned!\nTry Adding Journeys",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(color: Colors.grey),
                                    )),
                                  )
                                ]
                              : listDynamic.map((items) {
                                  return Column(
                                    children: [items],
                                  );
                                }).toList(),
                          // children: <Widget>[
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //     itemCount: listDynamic.length,
                          //     itemBuilder: (_,index)=> listDynamic[index]),

                          // ],
                        )
                      ],
                    ),
                  ),
                )
              : JourneyLoading(),
        ),
      ),
    );
  }
}

class DynamicWidget extends StatelessWidget {
  final VoidCallback callback;
  final User? user;
  final String from;
  final String to;
  final String train;
  final String trainno;
  final String pnr;
  const DynamicWidget(
      {super.key,
      this.user,
      required this.callback,
      required this.from,
      required this.to,
      required this.pnr,
      required this.train,
      required this.trainno});
  @override
  Widget build(BuildContext context) {
    deleteFromDb() async {
      var db = await mongo.Db.create(Environment.mongoServerUrl);
      await db.open();
      Map<String, dynamic>? userResult = await db
          .collection('token')
          .findOne(mongo.where.eq('user', user?.uid));
      if (userResult != null) {
        userResult['pnr'].remove(pnr);
        userResult['train'].remove(trainno);
        await db
            .collection('token')
            .replaceOne(mongo.where.eq('user', user?.uid), userResult);
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PNRResult(
                    user: user,
                    pnrno: pnr,
                  )),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shadowColor: Colors.black54,
        elevation: 12,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text('PNR: $pnr',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(train,
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              Padding(
                padding: Paddings.buttonpad,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(from,
                            style: Theme.of(context).textTheme.headlineMedium)
                      ],
                    ),
                    const Icon(
                      Icons.east_rounded,
                      size: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(to,
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.headlineMedium)
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 22, bottom: 25),
                child: DangerButton(
                    text: "REMOVE",
                    onTap: () {
                      Localstore.instance
                          .collection(user!.uid)
                          .doc(pnr)
                          .delete();
                      deleteFromDb();
                      callback();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
