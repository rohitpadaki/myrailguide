import 'package:flutter/material.dart';
import 'package:myrailguide/auth.dart';
import 'package:myrailguide/widgets/loading.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class QRCodeGenerator extends StatefulWidget {
  final String ticket;

  const QRCodeGenerator({super.key, required this.ticket});

  @override
  State<QRCodeGenerator> createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  Map<String, dynamic>? ticketResult = {};
  int status = 0;
  void fetchData() async {
    var db = await mongo.Db.create(Environment.mongoServerUrl);
    await db.open();
    ticketResult = await db
        .collection('ticket')
        .findOne(mongo.where.eq('ticketId', widget.ticket));
    if (ticketResult == null) {
      setState(() {
        status = 2;
      });
    } else {
      setState(() {
        status = 1;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "QR Code", true),
      body: SafeArea(
        child: (status == 1)
            ? Center(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      QrImageView(
                        data: "From: ${ticketResult?['from']}\n"
                                "To: ${ticketResult?['to']}\n"
                                "PNR: ${ticketResult?['pnr']}\n"
                                "Ticket ID: ${ticketResult?['ticketId']}\n"
                                "Train No: ${ticketResult?['trainNo']}\n"
                                "Train Name: ${ticketResult?['trainName']}\n"
                                "Quota: ${ticketResult?['quota']}\n"
                                "Class: ${ticketResult?['class']}\n"
                                "Departure: ${ticketResult?['departure']['date']} at ${ticketResult?['departure']['time']}\n"
                                "Arrival: ${ticketResult?['arrival']['date']} at ${ticketResult?['arrival']['time']}\n"
                                "Ticket Fare: ${ticketResult?['ticketFare']}\n"
                                "Passengers:\n" +
                            ticketResult?['passengers']
                                .map((passenger) =>
                                    "  Name: ${passenger['name']}, Gender: ${passenger['gender']}, Age: ${passenger['age']}, Status: ${passenger['status']}\n")
                                .join(),
                        // data:'From: ${ticketList[0]["from"]["name"]}, ${ticketList[0]["from"]["code"]}\nTo: ${ticketList[0]["to"]["name"]}, ${ticketList[0]["to"]["code"]}\nTravel Duration: ${ticketList[0]["travel_time"]}\nDate:${ticketList
                        // [0]["date"]}\nDeparture Time:${ticketList[0]["departure_time"]}' ,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          ticketResult?['ticketId'],
                          style: const TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : (status == 2)
                ? const CantFindTicket()
                : const QRLoading(),
      ),
    );
  }
}

class CantFindTicket extends StatelessWidget {
  const CantFindTicket({super.key});

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
              "Try checking the entered ticket ID number.",
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
