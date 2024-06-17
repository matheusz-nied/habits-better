import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_drawer.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/models/habit.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: const Icon(Icons.add),
      ),
      body: _buildHabitList(),
    );
  }

  Widget _buildHabitList(){
    final habitDatabse = context.watch<HabitDatabase>();
    List<Habit> currentHabits = habitDatabse.currentHabits;
    return ListView.builder(
      itemCount: currentHabits.length,
      itemBuilder: (context, index) {
        
      },
    );
  }
}
