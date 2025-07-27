import 'package:betterloop/models/habit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoPicker extends StatelessWidget {
  const CustomCupertinoPicker({
    super.key,
    this.onSelectedItemChanged,
    required this.initialItem,
    required this.items,
    this.habit,
  });
  final void Function(int)? onSelectedItemChanged;
  final int? initialItem;
  final List items;
  final Habit? habit;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      squeeze: 1,
      diameterRatio: 10,
      itemExtent: _kItemExtent,
      scrollController:
          FixedExtentScrollController(initialItem: initialItem ?? 0),
      onSelectedItemChanged: onSelectedItemChanged,
      looping: true,
      children: List<Widget>.generate(items.length, (int index) {
        return Center(
            child: Text(
          "${items[index]}",
          style: Theme.of(context).textTheme.headlineMedium,
        ));
      }),
    );
  }

  static const double _kItemExtent = 50.0;
}
