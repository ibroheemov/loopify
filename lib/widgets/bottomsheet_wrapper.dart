import 'package:betterloop/features/custom_habit/widgets/bottomsheet_grabber.dart';
import 'package:flutter/material.dart';

class BottomsheetWrapper extends StatelessWidget {
  const BottomsheetWrapper({
    super.key,
    required this.child,
    this.screenHeightOf,
  });
  final Widget child;
  final double? screenHeightOf;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeightOf != null
          ? MediaQuery.of(context).size.height * screenHeightOf!
          : null,
      child: Stack(
        alignment: Alignment.center,
        children: [Positioned(top: 12, child: BottomsheetGrabber()), child],
      ),
    );
  }
}
