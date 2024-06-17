import 'package:habit_tracker/models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any((day) =>
      day.year == today.year &&
      day.month == today.month &&
      day.day == today.day);
}

Map<DateTime, int> prepHeatMapDatasets(List<Habit> habits) {
  Map<DateTime, int> dataset = {};
  for (var habit in habits) {
    for (var completedDay in habit.completedDays) {
      final normalizedDate =
          DateTime(completedDay.year, completedDay.month, completedDay.day);
      if (dataset.containsKey(normalizedDate)) {
        dataset[normalizedDate] = dataset[normalizedDate]! + 1;
      } else {
        dataset[normalizedDate] = 1;
      }
    }
  }
  return dataset;
}
