import 'package:betterloop/models/habit.dart';
import 'package:betterloop/services/habit_service.dart';
import 'package:betterloop/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/current_habit_provider.dart';

class HabitsDropdown extends ConsumerStatefulWidget {
  const HabitsDropdown({
    super.key,
    required this.onSelected,
  });
  final void Function(Habit?)? onSelected;

  @override
  ConsumerState<HabitsDropdown> createState() => _HabitsDropdownState();
}

class _HabitsDropdownState extends ConsumerState<HabitsDropdown> {
  final TextEditingController controller = TextEditingController();
  List<Habit> habits = [];

  @override
  void initState() {
    super.initState();
    loadHabits();
  }

  Future<void> loadHabits() async {
    final allHabits = await HabitService.getAllHabits();

    final initialHabit = allHabits.isNotEmpty ? allHabits.first : null;

    setState(() {
      habits = allHabits;
    });
    ref.read(currentHabitProvider.notifier).state = initialHabit;
  }

  @override
  Widget build(BuildContext context) {
    final selectedHabit = ref.watch(currentHabitProvider);

    return DropdownMenu<Habit>(
      width: 250,
      initialSelection: selectedHabit,
      enableSearch: false,
      controller: controller,
      requestFocusOnTap: false,
      leadingIcon: selectedHabit != null
          ? Icon(
              selectedHabit.icon.toIconData,
              color: Helpers.parseColor(selectedHabit.color),
            )
          : Icon(
              Icons.warning_amber_rounded,
              color: Colors.amber,
            ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        enabledBorder: _border(),
        focusedBorder: _border(),
        border: InputBorder.none,
      ),
      onSelected: widget.onSelected,
      dropdownMenuEntries: habits.map((habit) {
        return DropdownMenuEntry<Habit>(
            value: habit,
            label: habit.title,
            leadingIcon: Icon(habit.icon.toIconData,
                color: Helpers.parseColor(habit.color), size: 30));
      }).toList(),
    );
  }

  static _border() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(18),
    );
  }
}
