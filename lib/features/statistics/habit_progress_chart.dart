import 'package:betterloop/models/habit.dart';
import 'package:betterloop/services/habit_log_service.dart';
import 'package:betterloop/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'providers/current_habit_provider.dart';

class HabitChartWithDropdown extends ConsumerStatefulWidget {
  const HabitChartWithDropdown({super.key});

  @override
  ConsumerState<HabitChartWithDropdown> createState() =>
      _HabitChartWithDropdownState();
}

class _HabitChartWithDropdownState
    extends ConsumerState<HabitChartWithDropdown> {
  Map<int, double> dayToProgress = {};
  bool loading = true;
  DateTime selectedMonth = DateTime.now();

  Future<void> loadLogsForHabit(String habitId) async {
    final habit = ref.read(currentHabitProvider);
    final now = selectedMonth;
    final int daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    // final logsBox = await HabitLogService.openBox();
    // final allLogs = logsBox.values.where((log) =>
    //     log.habitId == habitId &&
    //     log.completedAt.year == selectedMonth.year &&
    //     log.completedAt.month == selectedMonth.month);
    Map<int, double> mapped = {};

    if (habit!.goal.enabled) {
      for (var i = 0; i < daysInMonth; i++) {
        final progress = await HabitLogService.getProgressForHabit(
            habitId, DateTime(now.year, now.month, i, 0));
        mapped[i] = ((progress / habit.goal.value) * 100).ceilToDouble();
      }
    } else {
      for (var i = 0; i < daysInMonth; i++) {
        final isCompleted = await HabitLogService.isHabitCompleted(
            habitId, DateTime(now.year, now.month, i, 0));
        mapped[i] = isCompleted ? 100 : 0;
      }
    }

    setState(() => dayToProgress = mapped);
    setState(() => loading = false);
  }

  void _listenCurrentHabit() {
    ref.listen<Habit?>(currentHabitProvider, (prev, next) async {
      if (next != null && next != prev) {
        loadLogsForHabit(next.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _listenCurrentHabit();
    final selectedHabit = ref.watch(currentHabitProvider);

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final daysInMonth =
        DateUtils.getDaysInMonth(selectedMonth.year, selectedMonth.month);

    return loading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              // Month navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white70),
                    onPressed: () async {
                      setState(() {
                        selectedMonth = DateTime(
                          selectedMonth.year,
                          selectedMonth.month - 1,
                        );
                      });
                      await loadLogsForHabit(selectedHabit!.id);
                    },
                  ),
                  Text(DateFormat.yMMMM().format(selectedMonth),
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white70),
                    onPressed: () async {
                      setState(() {
                        selectedMonth = DateTime(
                          selectedMonth.year,
                          selectedMonth.month + 1,
                        );
                      });
                      await loadLogsForHabit(selectedHabit!.id);
                    },
                  ),
                ],
              ),

              // Chart
              Expanded(
                child: LineChart(
                  LineChartData(
                    minX: 1,
                    maxX: daysInMonth.toDouble(),
                    minY: 0,
                    maxY: 100,
                    gridData: FlGridData(show: true),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: isLandscape ? 1 : 5,
                          getTitlesWidget: (value, _) => Text(
                            '${value.toInt()}',
                            style:
                                TextStyle(color: Colors.white54, fontSize: 10),
                          ),
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 20,
                          getTitlesWidget: (value, _) => Text(
                            '${value.toInt()}%',
                            style:
                                TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                        ),
                      ),
                      topTitles: AxisTitles(),
                      rightTitles: AxisTitles(),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: dayToProgress.entries
                            .map((e) =>
                                FlSpot(e.key.toDouble(), e.value.toDouble()))
                            .toList(),
                        isCurved: true,
                        color: selectedHabit != null
                            ? Helpers.parseColor(selectedHabit.color)
                            : null,
                        barWidth: 2,
                        belowBarData: BarAreaData(
                          show: true,
                          color: selectedHabit != null
                              ? Helpers.parseColor(selectedHabit.color)
                                  .withOpacity(0.3)
                              : null,
                        ),
                        dotData: FlDotData(show: false),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
