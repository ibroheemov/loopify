import 'package:betterloop/theme/colors.dart';
import 'package:flutter/material.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({super.key, required this.controller, required this.tabs});
  final TabController controller;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 50,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: AppColors.of(context).backgroundDark,
          borderRadius: BorderRadius.circular(15)),
      child: TabBar(
        dividerHeight: 0,
        isScrollable: true,
        tabAlignment: TabAlignment.center,
        labelStyle: Theme.of(context).textTheme.titleMedium,
        unselectedLabelColor: AppColors.of(context).textSecondary,
        controller: controller,
        labelPadding: EdgeInsets.all(0),
        indicator: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        tabs: tabs,
      ),
    );
  }
}
