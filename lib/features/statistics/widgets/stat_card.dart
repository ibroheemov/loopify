import 'package:betterloop/widgets/app_card.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.color,
    required this.title,
    required this.value,
    required this.bottomText,
  });
  final Color color;
  final String title;
  final String value;
  final String bottomText;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppCard(
        // color: color,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(),
            style: textTheme.titleMedium?.copyWith(color: color)),
        SizedBox(height: 10),
        Text(value.toUpperCase(), style: textTheme.displayLarge),
        // SizedBox(height: 10),
        // Text(bottomText, style: textTheme.titleMedium),
      ],
    ));
  }
}
