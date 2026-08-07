// onboarding_step_4_goal_areas.dart

import 'package:betterloop/data/seed/default_habit_types.dart';
import 'package:betterloop/features/onboarding/providers/goal_type_provider.dart';
import 'package:betterloop/features/onboarding/widgets/habit_type_tile.dart';
import 'package:betterloop/models/goal_type.dart';
import 'package:betterloop/models/habit_area.dart';
import 'package:betterloop/models/habit_type.dart';
import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/services/habit_area_service.dart';
import 'package:betterloop/services/habit_type_service.dart';
import 'package:betterloop/services/shared_prefs_service.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/buttons/app_buttons.dart';
import 'package:betterloop/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingStep2GoalAreas extends ConsumerStatefulWidget {
  const OnboardingStep2GoalAreas({super.key});

  @override
  ConsumerState<OnboardingStep2GoalAreas> createState() =>
      _OnboardingStep2GoalAreasState();
}

class _OnboardingStep2GoalAreasState
    extends ConsumerState<OnboardingStep2GoalAreas>
    with SingleTickerProviderStateMixin {
  late Future<List<HabitArea>> _areasFuture;
  Map<String, List<HabitType>> _habitTypesByArea = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _areasFuture = HabitAreaService.getAllAreas();
    _loadHabitTypes();
  }

  Future<void> _loadHabitTypes() async {
    final types = await HabitTypeService.getAllHabitTypes();

    setState(() {
      _habitTypesByArea = {}; // clear it first or ensure it's empty

      for (var type in types) {
        _habitTypesByArea[type.areaId] ??=
            []; // if list doesn't exist, create it
        _habitTypesByArea[type.areaId]!.add(type); // add the current type
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final goalType = ref.watch(goalTypeProvider);
    final habits = _getHabitsForGoal(goalType);

    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        floatingActionButton: PrimaryButton(
            isRounded: true,
            label: "Custom habit",
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.customHabit)
                  .then((result) {
                if (result == true) {
                  _completeonboarding();
                }
              });
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: FutureBuilder<List<HabitArea>>(
          future: _areasFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding:
                  const EdgeInsets.all(AppSpacing.lg).copyWith(bottom: 200),
              children: [
                Text(
                  'Choose Habit \nTemplate',
                  style: textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacing.lg),
                ..._habits(habits: habits, areaId: "onboarding"),
              ],
            );
          },
        ),
      ),
    );
  }

  List<OnboardingHabit> _getHabitsForGoal(GoalType? goalType) {
    switch (goalType) {
      case GoalType.good:
        return topGoodHabits;
      case GoalType.bad:
        return topBadHabits;
      case GoalType.both:
        return [...topGoodHabits.take(5), ...topBadHabits.take(5)];
      default:
        return [];
    }
  }

  void _completeonboarding() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    SharedPrefsService().setOnboardingComplete(true);
    setState(() => isLoading = false);
    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNames.home,
      ModalRoute.withName('/'),
      arguments: true,
    );
  }

  List<Widget> _habits(
      {required List<OnboardingHabit> habits, required String areaId}) {
    return habits.isNotEmpty
        ? habits
            .asMap()
            .map((i, habit) {
              return MapEntry(
                i,
                HabitTypeTile(
                    habitType: habit,
                    areaId: areaId,
                    index: i,
                    onTap: _completeonboarding),
              );
            })
            .values
            .toList()
        : [const ListTile(title: Text("No habits available."))];
  }
}
