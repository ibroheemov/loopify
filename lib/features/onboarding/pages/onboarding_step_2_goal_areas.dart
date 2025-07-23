// onboarding_step_4_goal_areas.dart

import 'package:betterloop/data/seed/default_habit_types.dart';
import 'package:betterloop/features/onboarding/providers/goal_type_provider.dart';
import 'package:betterloop/features/onboarding/widgets/habit_area_card.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingStep2GoalAreas extends ConsumerStatefulWidget {
  const OnboardingStep2GoalAreas({Key? key}) : super(key: key);

  @override
  ConsumerState<OnboardingStep2GoalAreas> createState() =>
      _OnboardingStep2GoalAreasState();
}

class _OnboardingStep2GoalAreasState
    extends ConsumerState<OnboardingStep2GoalAreas>
    with SingleTickerProviderStateMixin {
  late Future<List<HabitArea>> _areasFuture;
  Map<String, List<HabitType>> _habitTypesByArea = {};
  final Map<String, ExpansionTileController> _controllers = {};
  String? _expandedAreaId;
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
            label: "Custom habit",
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.customHabit);
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: [
            SizedBox(height: AppSpacing.lg),
            Text(
              'Choose Habit Template',
              style: textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.xxl),
            Expanded(
              child: FutureBuilder<List<HabitArea>>(
                future: _areasFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final areas = snapshot.data!;
                  return ListView(
                      children: _habits(habits: habits, areaId: "onboarding"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<HabitType> _getHabitsForGoal(GoalType? goalType) {
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

  void _onExpansionChanged({required bool isExpanded, required String areaId}) {
    if (isExpanded) {
      // Collapse previously expanded tile
      if (_expandedAreaId != null && _expandedAreaId != areaId) {
        _controllers[_expandedAreaId!]!.collapse();
      }
      _expandedAreaId = areaId;
    } else if (_expandedAreaId == areaId) {
      _expandedAreaId = null;
    }
  }

  List<Widget> _areas(List<HabitArea> areas) {
    return [
      ...areas.map((area) {
        final areaId = area.id;
        final habits = _habitTypesByArea[area.id] ?? [];
        _controllers[area.id] =
            _controllers[area.id] ?? ExpansionTileController();

        return HabitAreaCard(
          onExpansionChanged: (isExpanded) =>
              _onExpansionChanged(isExpanded: isExpanded, areaId: areaId),
          area: area,
          controller: _controllers[area.id],
          children: _habits(habits: habits, areaId: areaId),
        );
      }),
    ];
  }

  List<Widget> _habits(
      {required List<HabitType> habits, required String areaId}) {
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
                    onTap: () async {
                      setState(() => isLoading = true);
                      await Future.delayed(const Duration(seconds: 1));
                      SharedPrefsService().setOnboardingComplete(true);
                      setState(() => isLoading = false);
                      Navigator.pushNamed(context, RouteNames.navigation);
                    }),
              );
            })
            .values
            .toList()
        : [const ListTile(title: Text("No habits available."))];
  }
}
