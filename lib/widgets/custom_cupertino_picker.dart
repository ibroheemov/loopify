import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoPicker extends StatelessWidget {
  const CustomCupertinoPicker({
    super.key,
    this.onSelectedItemChanged,
    this.initialItem,
    required this.items,
  });
  final void Function(int)? onSelectedItemChanged;
  final int? initialItem;
  final List items;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      child: CupertinoPicker(
        squeeze: 1,
        diameterRatio: 10,
        itemExtent: _kItemExtent,
        // scrollController:
        //     FixedExtentScrollController(initialItem: _selectedFruit),
        onSelectedItemChanged: onSelectedItemChanged,
        looping: true,
        children: List<Widget>.generate(items.length, (int index) {
          return Center(
              child: Text(
            "${items[index]}",
            style: Theme.of(context).textTheme.headlineMedium,
          ));
        }),
        // selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
        //   capStartEdge: false,
        //   capEndEdge: false,
        // ),
      ),
    );
  }

  static const double _kItemExtent = 50.0;
}
