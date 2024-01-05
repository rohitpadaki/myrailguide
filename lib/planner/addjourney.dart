import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localstore/localstore.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/pnrstatus/pnrresult.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:quickalert/quickalert.dart';

class JourneyPlanner extends StatefulWidget {
  final User? user;
  final bool? backbutton;
  const JourneyPlanner({super.key, this.user, this.backbutton});
  @override
  State<JourneyPlanner> createState() => _JourneyPlannerState();
}

class _JourneyPlannerState extends State<JourneyPlanner> {
  late CollectionReference collectionReference;
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
            pnr: data['pnrno'],
            train: data['train']['train'],
            to: data['dst']['station'],
            from: data['src']['station'],
          );
          listDynamic.add(dynamicWidget);
        });
      }
      setState(() {});
    });
    // Localstore.instance.collection(widget.user!.uid).delete();
  }

  @override
  void initState() {
    super.initState();
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
                  autofocus: true,
                  controller: pnr,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    pnrno = value;
                  },
                  decoration:
                      const InputDecoration(hintText: 'Enter your PNR No.'),
                ),
                actions: [
                  TextButton(
                      onPressed: submit,
                      child: const Text(
                        "SUBMIT",
                        style: TextStyle(fontFamily: "Urbanist"),
                      ))
                ]));
  }

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
        'pnrno': pnr,
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

  void submit() async {
    if (pnrno == "") {
      // showAlert("Please Enter The PNR Number", QuickAlertType.error);
    } else if (pnrno.length == 10) {
      // flag = 1;
      // Navigator.of(context).pop();
    } else {
      Map<String, dynamic>? res = await fetchPNR(pnrno, Source.server);
      if (res != null) {
        // Add the new PNR to the local store
        Localstore.instance.collection(widget.user!.uid).doc(pnrno).set(res);
        // Create a new DynamicWidget for the new PNR and add it to listDynamic
        DynamicWidget dynamicWidget = DynamicWidget(
          pnr: pnrno,
          train: res['train']['train'],
          to: res['dst']['station'],
          from: res['src']['station'],
        );
        listDynamic.add(dynamicWidget);
        setState(() {});
      }
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
            : FloatingActionButton(
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: Paddings.maincontent,
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  // StreamBuilder<QuerySnapshot>(stream: _firebaseFirestore.snapshots(),
                  //     builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                  //       if(!snapshot.hasData){
                  //         return Center(child: CircularProgressIndicator(),);
                  //       }
                  //       else{
                  //         print(snapshot.data);
                  //         return ListView(children: [
                  //           ...snapshot.data!.docs.where(
                  //               (QueryDocumentSnapshot<Object?> element)=> element['pnrno']
                  //                   .toString()
                  //                   .toLowerCase()
                  //                   .contains(pnrno.toLowerCase())).map((QueryDocumentSnapshot<Object?> data){
                  //               train_name=data.get('Train_name');
                  //               dest=data.get('dest');
                  //               frm=data.get('frm');
                  //               pnrn=data.get('pnrno');
                  //               print(train_name);
                  //               print(dest);
                  //               print(frm);
                  //               print(pnrn);
                  //               return Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: listDynamic.map((ex){
                  //                   return Column(
                  //                     children: [
                  //                       ex
                  //                     ],
                  //                   );
                  //                 }).toList(),
                  //                 // children: <Widget>[
                  //                 // ListView.builder(
                  //                 //   shrinkWrap: true,
                  //                 //     itemCount: listDynamic.length,
                  //                 //     itemBuilder: (_,index)=> listDynamic[index]),
                  //
                  //                 // ],
                  //               );
                  //           })
                  //         ],);
                  //       }
                  //     }),
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
          ),
        ),
      ),
    );
  }
}

class DynamicWidget extends StatelessWidget {
  final String from;
  final String to;
  final String train;
  final String pnr;
  const DynamicWidget(
      {super.key,
      required this.from,
      required this.to,
      required this.pnr,
      required this.train});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PNRResult(
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
                padding: Paddings.doublepad,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(from,
                            style: Theme.of(context).textTheme.headlineSmall)
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
                            style: Theme.of(context).textTheme.headlineSmall)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
