// import 'package:betterloop/features/dashboard/widgets/habit_card.dart';
// import 'package:betterloop/features/dashboard/widgets/habit_card_progress.dart';
// import 'package:flutter/material.dart';

// class DailyHabits extends StatefulWidget {
//   const DailyHabits({super.key});

//   @override
//   State<DailyHabits> createState() => _DailyHabitsState();
// }

// class _DailyHabitsState extends State<DailyHabits> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: EdgeInsets.only(top: 80),
//       itemCount: habits.length,
//       itemBuilder: (context, index) {
//         final habit = habits[index];
//         final goalEnabled = habit.goal.enabled;
//         return goalEnabled
//             ? HabitCardProgress(habit: habit)
//             : HabitCard(habit: habit);
//       },
//     );
//   }
// }
