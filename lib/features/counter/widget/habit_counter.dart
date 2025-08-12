import 'package:betterloop/models/habit.dart';
import 'package:betterloop/services/habit_log_service.dart';
import 'package:betterloop/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HabitCounter extends StatefulWidget {
  const HabitCounter({super.key, required this.habit});
  final Habit habit;

  @override
  State<HabitCounter> createState() => _HabitCounterState();
}

class _HabitCounterState extends State<HabitCounter> {
  int current = 0;
  int target = 100;
  late Habit habit;

  @override
  void initState() {
    habit = widget.habit;
    target = habit.goal.value;
    setCurrent();
    super.initState();
  }

  void _increment() {
    HabitLogService.logCompletion(habit, 1);
    setState(() {
      if (current < target) current++;
    });
  }

  void setCurrent() async {
    final progress = await HabitLogService.getProgressForHabit(habit.id);
    setState(() {
      current = progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    double percentage = current / target;
    final color = Helpers.parseColor(widget.habit.color);
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: GestureDetector(
        onTap: current == target ? null : _increment,
        child: AspectRatio(
          aspectRatio: 1, // Makes it a square
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: CustomPaint(
              painter:
                  CircularProgressPainter(percentage: percentage, color: color),
              child: Center(
                child: Text('$current',
                    style: textTheme.displayLarge?.copyWith(fontSize: 80)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double percentage;
  final Color color;

  CircularProgressPainter({required this.percentage, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 12.0;
    final radius = (size.width / 2) - strokeWidth;
    final center = Offset(size.width / 2, size.height / 2);

    final backgroundPaint = Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    final sweepAngle = 2 * pi * percentage;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start from top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
