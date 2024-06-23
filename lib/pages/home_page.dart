import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_drawer.dart';
import 'package:habit_tracker/components/my_habit_tile.dart';
import 'package:habit_tracker/components/my_heat_map.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/utils/habit_util.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
    super.initState();
  }

  final TextEditingController textController = TextEditingController();
  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
                content: TextField(
                  controller: textController,
                  decoration:
                      const InputDecoration(hintText: "Create a new Habit"),
                ),
                actions: [
                  MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        textController.clear();
                      },
                      child: const Text("Cancel")),
                  MaterialButton(
                      onPressed: () {
                        String newHabitName = textController.text;
                        if (newHabitName.isNotEmpty) {
                          context.read<HabitDatabase>().addHabit(newHabitName);
                        }

                        Navigator.pop(context);
                        textController.clear();
                      },
                      child: const Text("Add"))
                ]));
  }

  void checkHabitOnOff(bool? value, Habit habit) {
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  void editHabitBox(Habit habit) {
    textController.text = habit.name;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                content: TextField(
                  controller: textController,
                ),
                actions: [
                  MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        textController.clear();
                      },
                      child: const Text("Cancel")),
                  MaterialButton(
                      onPressed: () {
                        String newHabitName = textController.text;
                        if (newHabitName.isNotEmpty) {
                          context
                              .read<HabitDatabase>()
                              .updateHabitName(habit.id, newHabitName);
                        }
                        Navigator.pop(context);
                        textController.clear();
                      },
                      child: const Text("Edit"))
                ]));
  }

  void deleteHabitBox(Habit habit) {
    textController.text = habit.name;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                content: Text('Are you sure you want to delete ${habit.name}?'),
                actions: [
                  MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        textController.clear();
                      },
                      child: const Text("Cancel")),
                  MaterialButton(
                      onPressed: () {
                        String newHabitName = textController.text;
                        if (newHabitName.isNotEmpty) {
                          context.read<HabitDatabase>().deleteHabit(habit);
                        }
                        Navigator.pop(context);
                        textController.clear();
                      },
                      child: const Text("Delete"))
                ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nied Habits"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(

        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child:  Icon(Icons.add, color: Theme.of(context).colorScheme.inversePrimary),
      ),
      body: ListView(
        children: [
          _buildHeatMap(),
          _buildHabitList(),
        ],
      ),
    );
  }

  Widget _buildHeatMap() {
    final habitDatabase = context.watch<HabitDatabase>();
    List<Habit> currentHabits = habitDatabase.currentHabits;
    return FutureBuilder<DateTime?>(
        future: habitDatabase.getFirstLaunchDate(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyHeatMap(
                startDate: snapshot.data!,
                datasets: prepHeatMapDatasets(currentHabits));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _buildHabitList() {
    final habitDatabse = context.watch<HabitDatabase>();
    List<Habit> currentHabits = habitDatabse.currentHabits;
    return ListView.builder(
      itemCount: currentHabits.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final habit = currentHabits[index];
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);
        return MyHabitTile(
          isCompleted: isCompletedToday,
          text: habit.name,
          onChanged: (value) => checkHabitOnOff(value, habit),
          editHabit: (context) => editHabitBox(habit),
          deleteHabit: (context) => deleteHabitBox(habit),
        );
      },
    );
  }
}
