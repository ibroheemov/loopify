// lib/features/dashboard/dashboard_screen.dart
import 'package:betterloop/features/dashboard/widgets/habit_card.dart';
import 'package:betterloop/features/dashboard/widgets/habit_card_progress.dart';
import 'package:betterloop/features/dashboard/widgets/monthly_habit_tracker.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/services/habit_service.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/utils/extensions.dart';
import 'package:betterloop/widgets/app_container.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

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

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ValueListenableBuilder(
            valueListenable: HabitService.getHabitBoxSync().listenable(),
            builder: _habitsBuilder,
          ),
          ValueListenableBuilder(
            valueListenable: HabitService.getHabitBoxSync().listenable(),
            builder: (context, box, child) {
              final habits = box.values.toList();

              if (habits.isEmpty) {
                return Positioned(
                  left: 45,
                  child: Image.asset(
                    "assets/images/empty_habits.png",
                    width: 250,
                  ),
                );
              }
              return Container();
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            top: AppSpacing.sm,
            child: AppContainer(
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(DateFormat.MMMMd().format(DateTime.now()),
                      style: textTheme.titleSmall),
                  _buildTabBar(),
                  // IconButton.filled(
                  //     style: IconButton.styleFrom(
                  //         fixedSize: Size(52, 52),
                  //         backgroundColor:
                  //             AppColors.of(context).backgroundDark),
                  //     color: AppColors.of(context).textSecondary,
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, RouteNames.paywall);
                  //     },
                  //     icon: Center(
                  //       child: Icon(
                  //         GeneralIcons.settings_outline,
                  //         size: 30,
                  //       ),
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
        controller: _tabController,
        labelPadding: EdgeInsets.all(0),
        indicator: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        tabs: SampleItem.values
            .map((e) => Tab(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 85, maxHeight: 30),
                    padding: const EdgeInsets.all(0),
                    child: Center(child: Text(e.name.capitalize())),
                  ),
                ))
            .toList(),
      ),
    );
  }

  List<Habit> _todaysHabits(List<Habit> habits) {
    final int today = DateTime.now().weekday;

    final todaysHabits = habits.where((habit) {
      final weekdays = habit.weekdays;

      if (weekdays.isXdaysPerWeek) {
        return true;
      }

      return weekdays.selectedWeekDays.contains(today);
    }).toList();

    return todaysHabits;
  }

  Widget _habitsBuilder(context, Box<Habit> box, _) {
    final habits = box.values.toList();
    final todaysHabits = _todaysHabits(habits);

    return TabBarView(
      controller: _tabController,
      children: [
        ListView.builder(
          padding: EdgeInsets.only(top: 80),
          itemCount: todaysHabits.length,
          itemBuilder: (context, index) {
            final habit = todaysHabits[index];
            final goalEnabled = habit.goal.enabled;

            return goalEnabled
                ? HabitCardProgress(habit: habit)
                : HabitCard(habit: habit);
          },
        ),
        ListView.builder(
          padding: EdgeInsets.only(top: 80),
          itemCount: habits.length,
          itemBuilder: (context, index) {
            final habit = habits[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.mdLg)
                  .copyWith(bottom: AppSpacing.md),
              child: WeeklyHabitTracker(habit: habit),
            );
          },
        ),
        ListView.builder(
          padding: EdgeInsets.only(top: 80),
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
