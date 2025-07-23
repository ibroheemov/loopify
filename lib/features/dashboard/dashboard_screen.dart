// lib/features/dashboard/dashboard_screen.dart
import 'package:betterloop/features/dashboard/widgets/habit_card.dart';
import 'package:betterloop/features/dashboard/widgets/habit_card_progress.dart';
import 'package:betterloop/features/dashboard/widgets/monthly_habit_tracker.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/services/habit_service.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'widgets/weekly_habit_tracker.dart';

enum SampleItem {
  daily("Daily"),
  weekly("Weekly"),
  monthly("Monthly");

  const SampleItem(String value);
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  SampleItem? selectedItem;
  late final TabController _tabController;
  IconData? selectedIcon;
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: SampleItem.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ValueListenableBuilder(
            valueListenable: HabitService.getHabitBoxSync().listenable(),
            builder: _habitsBuilder,
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // IconButton.filled(
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       Icons.settings,
                  //       size: 35,
                  //     )),
                  // Container(width: 35),
                  _buildTabBar(),
                  // IconButton.filled(
                  //     style: IconButton.styleFrom(
                  //         backgroundColor:
                  //             AppColors.of(context).backgroundDark),
                  //     color: AppColors.of(context).textSecondary,
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, RouteNames.settings);
                  //     },
                  //     icon: Icon(
                  //       Icons.settings,
                  //       size: 35,
                  //     ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
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
        controller: _tabController,
        labelPadding: EdgeInsets.all(0),
        indicator: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        tabs: SampleItem.values
            .map((e) => Tab(
                  child: Container(
                    constraints: BoxConstraints(minWidth: 100, maxHeight: 45),
                    padding: const EdgeInsets.all(0),
                    child: Center(child: Text(e.name.capitalize())),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _habitsBuilder(context, Box<Habit> box, _) {
    final habits = box.values.toList();
    return TabBarView(
      controller: _tabController,
      children: [
        ListView.builder(
          padding: EdgeInsets.only(top: 70),
          itemCount: habits.length,
          itemBuilder: (context, index) {
            final habit = habits[index];
            final goalEnabled = habit.goal.enabled;
            return goalEnabled
                ? HabitCardProgress(habit: habit)
                : HabitCard(habit: habit);
          },
        ),
        ListView.builder(
          padding: EdgeInsets.only(top: 70),
          itemCount: habits.length,
          itemBuilder: (context, index) {
            final habit = habits[index];
            return WeeklyHabitTracker(habit: habit);
          },
        ),
        ListView.builder(
          padding: EdgeInsets.only(top: 70),
          itemCount: habits.length,
          itemBuilder: (context, index) {
            final habit = habits[index];
            return MonthlyHabitTracker(habit: habit);
          },
        ),
      ],
    );
  }
}
