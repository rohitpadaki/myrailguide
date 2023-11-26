import 'package:flutter/material.dart';
import 'package:myrailguide/placeholders.dart';
import 'package:shimmer/shimmer.dart';

class TRSLoading extends StatelessWidget {
  const TRSLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: const SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0, top: 15),
                  child: BannerPlaceholder(
                    height: 214,
                    width: double.infinity,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: BannerPlaceholder(
                        height: 450,
                        width: 200,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: BannerPlaceholder(
                        height: 450,
                        width: 90,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class PNRLoading extends StatelessWidget {
  const PNRLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: const SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 15.0, top: 15),
                child: BannerPlaceholder(
                  height: 600,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ));
  }
}
