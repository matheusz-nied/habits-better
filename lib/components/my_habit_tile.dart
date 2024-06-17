import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabitTile extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;
  const MyHabitTile(
      {super.key,
      required this.isCompleted,
      required this.text,
      this.onChanged,
      this.editHabit, this.deleteHabit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            const SizedBox(width: 8,),
            SlidableAction(
              onPressed: editHabit,
              backgroundColor: Colors.grey.shade800,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(4),
            ),
                        const SizedBox(width: 8,),

            SlidableAction(
              spacing: 12,
              onPressed: deleteHabit,
              backgroundColor: const Color.fromARGB(255, 212, 71, 60),
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(4),
            )
          ],
        ),
        child: GestureDetector(
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
            child: ListTile(
              title: Text(text, style: TextStyle(color: isCompleted ? Colors.white : Theme.of(context).colorScheme.inversePrimary),),
              leading: Checkbox(
                activeColor: Colors.green,
                value: isCompleted,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
