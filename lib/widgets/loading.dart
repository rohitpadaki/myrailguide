import 'package:flutter/material.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/widgets/placeholders.dart';
import 'package:shimmer/shimmer.dart';

class TRSLoading extends StatelessWidget {
  const TRSLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Shimmer.fromColors(
          baseColor: Theme.of(context).splashColor,
          highlightColor: Theme.of(context).highlightColor,
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
    return Padding(
      padding: Paddings.maincontent,
      child: Shimmer.fromColors(
          baseColor: Theme.of(context).splashColor,
          highlightColor: Theme.of(context).highlightColor,
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
                    height: 640,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.maincontent,
      child: Shimmer.fromColors(
          baseColor: Theme.of(context).splashColor,
          highlightColor: Theme.of(context).highlightColor,
          enabled: true,
          child: const SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 6),
                  child: BannerPlaceholder(
                    height: 164,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0, top: 0),
                  child: BannerPlaceholder(
                    height: 410,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class ProfileLoading extends StatelessWidget {
  const ProfileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.maincontent,
      child: Shimmer.fromColors(
          baseColor: Theme.of(context).splashColor,
          highlightColor: Theme.of(context).highlightColor,
          enabled: true,
          child: const SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0, top: 30),
                  child: CirclePlaceHolder(
                    height: 160,
                    width: double.infinity,
                  ),
                ),
                Center(
                  child: BannerPlaceholder(
                    height: 35,
                    width: 150,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0, top: 0),
                  child: BannerPlaceholder(
                    height: 52,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.0, top: 0),
                  child: BannerPlaceholder(
                    height: 52,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class QRLoading extends StatelessWidget {
  const QRLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.maincontent,
      child: Shimmer.fromColors(
          baseColor: Theme.of(context).splashColor,
          highlightColor: Theme.of(context).highlightColor,
          enabled: true,
          child: const SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 85.7 - Paddings.horizontal, vertical: 246.7),
                  child: BannerPlaceholder(
                    height: 266,
                    width: 240,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class BookingLoading extends StatelessWidget {
  const BookingLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.maincontent,
      child: Shimmer.fromColors(
          baseColor: Theme.of(context).splashColor,
          highlightColor: Theme.of(context).highlightColor,
          enabled: true,
          child: const SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: BannerPlaceholder(
                    height: 160,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: BannerPlaceholder(
                    height: 160,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: BannerPlaceholder(
                    height: 160,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: BannerPlaceholder(
                    height: 160,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
