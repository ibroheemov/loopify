import 'package:betterloop/features/custom_habit/pages/all_icons.dart';
import 'package:betterloop/features/custom_habit/providers/habit_color_provider.dart';
import 'package:betterloop/features/custom_habit/widgets/action_buttons.dart';
import 'package:betterloop/features/custom_habit/widgets/choose_color.dart';
import 'package:betterloop/features/custom_habit/widgets/daily_goal.dart';
import 'package:betterloop/features/custom_habit/widgets/habit_days_section.dart';
import 'package:betterloop/features/custom_habit/widgets/reminder_section.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/utils/helpers.dart';
import 'package:betterloop/widgets/bottomsheet_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/habit_icon_provider.dart';
import 'widgets/custom_textfield.dart';

class CustomHabitScreen extends ConsumerStatefulWidget {
  const CustomHabitScreen({super.key});

  @override
  ConsumerState<CustomHabitScreen> createState() => _CustomHabitScreenState();
}

class _CustomHabitScreenState extends ConsumerState<CustomHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _habitNameController = TextEditingController();
  String habitTitle = "";

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
      floatingActionButton:
          ActionButtons(formKey: _formKey, controller: _habitNameController),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: AppSpacing.lg, horizontal: AppSpacing.sm_md),
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
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
                  SectionDailyGoal(),
                  SizedBox(height: AppSpacing.md),
                  SectionHabitDays(),
                  SizedBox(height: AppSpacing.md),
                  ReminderSection(),
                  SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showAllIcons() {
    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).colorScheme.background,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BottomsheetWrapper(screenHeightOf: 0.8, child: AllIcons());
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
          color: Helpers.parseColor(iconColor).withOpacity(0.2),
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
