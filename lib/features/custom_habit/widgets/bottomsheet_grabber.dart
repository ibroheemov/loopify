import 'package:flutter/material.dart';

class BottomsheetGrabber extends StatelessWidget {
  const BottomsheetGrabber({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Theme.of(context).colorScheme.outline,
      ),
    );
  }
}
