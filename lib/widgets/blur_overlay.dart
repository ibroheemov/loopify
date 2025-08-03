import 'dart:ui';
import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/widgets/buttons/app_buttons.dart';
import 'package:flutter/material.dart';

class BlurredOverlay extends StatelessWidget {
  final Widget child;
  final bool blur;

  const BlurredOverlay({
    Key? key,
    required this.child,
    this.blur = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child, // Your main UI
        if (blur)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.2), // Optional dimming
                child: Center(
                  child: PrimaryButton(
                      isRounded: true,
                      label: "Unlock this feature",
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.paywall);
                      }),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
