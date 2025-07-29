// import 'package:flutter/material.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: daysInMonth,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 10,
//                   mainAxisSpacing: 8,
//                   crossAxisSpacing: 8,
//                 ),
//                 itemBuilder: (context, index) {
//                   final day = index + 1;
//                   final date = DateTime(now.year, now.month, day);

//                   final isCompleted = loggedDays.any((log) =>
//                       log.year == date.year &&
//                       log.month == date.month &&
//                       log.day == date.day);

//                   return FutureBuilder(
//                     future: habit.goal.enabled
//                         ? HabitLogService.getProgressForHabit(habit.id, date)
//                         : null,
//                     builder: (context, snapshot) {
//                       int progress = 0;
//                       final hasData = snapshot.hasData;
//                       if (hasData) {
//                         progress = snapshot.data!;
//                       }
//                       // return MonthlyHabitCard();
//                       return Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: (!habit.goal.enabled && isCompleted)
//                               ? Helpers.parseColor(habit.color)
//                               : progress == 0
//                                   ? AppColors.of(context).onSurfaceBg
//                                   : Helpers.parseColor(habit.color)
//                                       .withOpacity(progress / habit.goal.value),
//                         ),
//                         alignment: Alignment.center,
//                       );
//                     },
//                   );
//                 },
//               );
//   }
// }
