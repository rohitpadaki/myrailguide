import 'package:flutter/material.dart';
import 'package:myrailguide/auth.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:myrailguide/widgets/loading.dart';
import 'package:myrailguide/wip.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class BookingResult extends StatefulWidget {
  final String fromStation;
  final String toStation;
  final DateTime date;
  const BookingResult(
      {super.key,
      required this.fromStation,
      required this.toStation,
      required this.date});

  @override
  State<BookingResult> createState() => _BookingResultState();
}

class _BookingResultState extends State<BookingResult> {
  @override
  void initState() {
    super.initState();
    fetchData(widget.fromStation.toUpperCase(), widget.toStation.toUpperCase());
  }

  int status = 0;

  List<Map<String, dynamic>> res = [];
  var resIndices = [];

  void fetchData(fromStation, toStation) async {
    var db = await mongo.Db.create(Environment.mongoServerUrl);
    await db.open();
    var trains = await db.collection('train').find({
      'schedule.sid': {
        '\$all': [fromStation, toStation]
      }
    }).toList();

    // Filter the results to ensure 'fromStation' occurs before 'toStation'
    res = trains.where((train) {
      var schedule = train['schedule'] as List<dynamic>;
      var fromIndex = schedule.indexWhere((item) => item['sid'] == fromStation);
      var toIndex = schedule.indexWhere((item) => item['sid'] == toStation);
      return fromIndex != -1 && toIndex != -1 && fromIndex < toIndex;
    }).map((train) {
      var schedule = train['schedule'] as List<dynamic>;
      var fromIndex = schedule.indexWhere((item) => item['sid'] == fromStation);
      var toIndex = schedule.indexWhere((item) => item['sid'] == toStation);
      return {'train': train, 'fromIndex': fromIndex, 'toIndex': toIndex};
    }).toList();
    setState(() {
      status = 1;
    });
    // Print the filtered results
    // Print the result
    // String trainName = res?['trainname'];
    // List<bool> week = List<bool>.from(res?['week']);
    // String trainNo = res?['trainno'];
    // List<dynamic> schedules = res?['schedule'];
    // var fromData = res?['from'];
    // var toData = res?['to'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Book Your Ticket", true),
      body: SafeArea(
          child: (status == 1)
              ? Padding(
                  padding: Paddings.maincontent,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Column(
                        children: res.map((train) {
                          String srcdate =
                              "${widget.date.day.toString().padLeft(2, "0")}/${widget.date.month.toString().padLeft(2, "0")}";
                          String dstdate = (int.parse(train['train']['schedule']
                                              [train['toIndex']]['arrivalTime']
                                          .split(":")[0]) -
                                      int.parse(train['train']['schedule']
                                                  [train['fromIndex']]
                                              ['departureTime']
                                          .split(":")[0]) >=
                                  0)
                              ? "${widget.date.day.toString().padLeft(2, "0")}/${widget.date.month.toString().padLeft(2, "0")}"
                              : "${((widget.date.day) + 1).toString().padLeft(2, "0")}/${widget.date.month.toString().padLeft(2, "0")}";
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => BookingForm(train: train, departure: srcdate, arrival: dstdate)));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WorkInProgress()));
                              },
                              child: Container(
                                decoration: ShapeDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                train['train']['trainname'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium
                                                    ?.copyWith(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                              Text(
                                                train['train']['trainno'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium
                                                    ?.copyWith(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10,
                                                    top: 16),
                                                child: Text(
                                                  train['train']['schedule']
                                                          [train['fromIndex']]
                                                      ['departureTime'],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                ),
                                                child: Text(
                                                  srcdate,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Icon(
                                            Icons.east_rounded,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10,
                                                    top: 16),
                                                child: Text(
                                                  train['train']['schedule']
                                                          [train['toIndex']]
                                                      ['arrivalTime'],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                ),
                                                child: Text(
                                                  dstdate,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                )
              : const BookingLoading()),
    );
  }
}
