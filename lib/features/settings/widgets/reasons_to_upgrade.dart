import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ReasonsToUpgrade extends StatelessWidget {
  const ReasonsToUpgrade({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        AppCard(
          onTap: () {
            Navigator.pushNamed(context, RouteNames.paywall);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 30),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Reasons to upgrade",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: -5,
          child: LottieBuilder.asset(
            "assets/lottie/premium-star-animation.json",
            width: 70,
          ),
        ),
      ],
    );
  }
}
