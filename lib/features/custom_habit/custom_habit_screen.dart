import 'package:betterloop/features/custom_habit/pages/all_icons.dart';
import 'package:betterloop/features/custom_habit/providers/goal_provider.dart';
import 'package:betterloop/features/custom_habit/providers/habit_color_provider.dart';
import 'package:betterloop/features/custom_habit/widgets/action_buttons.dart';
import 'package:betterloop/features/custom_habit/widgets/choose_color.dart';
import 'package:betterloop/features/custom_habit/widgets/daily_goal.dart';
import 'package:betterloop/features/custom_habit/widgets/habit_days_section.dart';
import 'package:betterloop/features/custom_habit/widgets/reminder_section.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/services/habit_log_service.dart';
import 'package:betterloop/services/habit_service.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/utils/helpers.dart';
import 'package:betterloop/widgets/bottomsheet_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/habit_icon_provider.dart';
import 'widgets/custom_textfield.dart';

enum Menu { remove }

class CustomHabitScreen extends ConsumerStatefulWidget {
  const CustomHabitScreen({super.key, this.habit});
  final Habit? habit;

  @override
  ConsumerState<CustomHabitScreen> createState() => _CustomHabitScreenState();
}

class _CustomHabitScreenState extends ConsumerState<CustomHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _habitNameController = TextEditingController();
  String habitTitle = "";
  Habit? habit;

  @override
  void initState() {
    habit = widget.habit;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Set it only once to avoid repeated updates
    Future.microtask(() {
      final habit = widget.habit;
      if (habit != null) {
        _habitNameController.text = habit.title;
        habitTitle = habit.title;
        ref.read(habitColorProvider.notifier).state = habit.color;
        ref.read(goalProvider.notifier).state = habit.goal;
        ref.read(habitIconProvider.notifier).state =
            IconData(habit.icon.code, fontFamily: habit.icon.family);
      }
    });
  }

  @override
  void dispose() {
    _habitNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icon = ref.watch(habitIconProvider);
    final iconColor = ref.watch(habitColorProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ActionButtons(
          formKey: _formKey,
          controller: _habitNameController,
          habitTobeUpdated: habit),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: AppSpacing.lg, horizontal: AppSpacing.smMd),
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  if (habit != null)
                    Positioned(
                      right: 0,
                      child: PopupMenuButton<Menu>(
                        popUpAnimationStyle: AnimationStyle.noAnimation,
                        icon: const Icon(Icons.more_vert),
                        onSelected: (Menu item) {
                          if (item == Menu.remove) {
                            _confirmDelete();
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<Menu>>[
                          const PopupMenuItem<Menu>(
                              value: Menu.remove,
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Remove'),
                              )),
                        ],
                      ),
                    ),
                  Column(
                    children: [
                      _buildIcon(icon: icon, iconColor: iconColor),
                      SizedBox(height: AppSpacing.md),
                      Text(
                        habitTitle.isEmpty ? "E.g. Sleep 8 hours" : habitTitle,
                        style: textTheme.titleLarge,
                      ),
                      SizedBox(height: AppSpacing.lg),
                      CustomTextField(
                        label: 'Habit Name',
                        controller: _habitNameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a habit name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() => habitTitle = value);
                          _formKey.currentState!.validate();
                        },
                      ),
                      SizedBox(height: AppSpacing.md),
                      ChooseColor(),
                      SizedBox(height: AppSpacing.md),
                      SectionDailyGoal(habit: widget.habit),
                      SizedBox(height: AppSpacing.md),
                      SectionHabitDays(habit: widget.habit),
                      SizedBox(height: AppSpacing.md),
                      ReminderSection(habit: widget.habit),
                      SizedBox(height: AppSpacing.xxl),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDelete() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Are you sure you want to Delete this habit?'),
        content: const Text(
            'Deleting wipes out all of your logs for this habit, in case you want them back please backup first before deletion.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (habit == null) return;
              await HabitService.deleteHabit(habit!.id);
              await HabitLogService.deleteLogsForHabit(habit!.id);
              if (!context.mounted) return;

              Navigator.pop(context);
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void showAllIcons() {
    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).colorScheme.surface,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BottomsheetWrapper(
            screenHeightOf: 0.8, child: AllIcons(ref: ref));
      },
    );
  }

  Widget _buildIcon({
    required IconData icon,
    required String iconColor,
  }) {
    return GestureDetector(
      onTap: showAllIcons,
      child: Container(
        width: 90,
        height: 90,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Helpers.parseColor(iconColor).withValues(alpha: 0.2),
        ),
        child: Icon(
          icon,
          color: Helpers.parseColor(iconColor),
          size: 65,
        ),
      ),
    );
  }
}
