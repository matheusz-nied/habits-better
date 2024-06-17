import 'package:flutter/material.dart';

class MyHabitTile extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final Function(bool?)? onChanged;
  const MyHabitTile(
      {super.key,
      required this.isCompleted,
      required this.text,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged!(!isCompleted);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isCompleted
              ? Colors.green
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(3),
        ),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: ListTile(
          title: Text(text),
          leading: Checkbox(
            activeColor: Colors.green,
            value: isCompleted,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
