import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final DateTime startDate;
  const MyHeatMap({super.key, required this.startDate, required this.datasets});

  @override
  Widget build(BuildContext context) {
    return HeatMapCalendar(
      datasets: datasets,
      colorMode: ColorMode.color,
      defaultColor: const Color.fromARGB(255, 30, 30, 30),
      textColor: Colors.white,
      showColorTip: false,
      size: 30,
      colorsets: {
        1: Colors.green.shade100,
        2: Colors.green.shade500,
        3: Colors.green.shade800,
        4: Colors.green.shade800,
        5: Colors.green.shade800,
      },
    );
  }
}