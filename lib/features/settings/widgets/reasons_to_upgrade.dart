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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
          left: 55,
          top: -10,
          child: LottieBuilder.asset(
            "assets/images/icons/premium-star-animation.json",
            width: 80,
          ),
        ),
      ],
    );
  }
}
