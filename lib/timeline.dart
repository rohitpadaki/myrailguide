import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Timeline extends StatelessWidget {
  final bool isfirst;
  final bool islast;
  final Map<String, dynamic> payload;
  const Timeline(
      {super.key,
      required this.isfirst,
      required this.islast,
      required this.payload});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TimelineTile(
        beforeLineStyle: const LineStyle(color: Color(0xFF225FDE)),
        indicatorStyle: const IndicatorStyle(color: Color(0xFF225FDE)),
        isFirst: isfirst,
        isLast: islast,
        endChild: EndCard(
            str: "${payload['station']} - ${payload['sid']}",
            time: payload['time']),
      ),
    );
  }
}

class EndCard extends StatelessWidget {
  final String str;
  final String time;
  const EndCard({super.key, required this.str, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Text(
              str,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
                height: 0,
                letterSpacing: 0.50,
              ),
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
              height: 0,
              letterSpacing: 0.50,
            ),
          )
        ],
      ),
    );
  }
}
