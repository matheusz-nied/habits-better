import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_drawer.dart';
import 'package:habit_tracker/components/my_habit_tile.dart';
import 'package:habit_tracker/components/my_heat_map.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/utils/habit_util.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      drawer: const MyDrawer(),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(21.0),
          child: Column(
            children: [
              Text("Nied tracker", style: TextStyle(fontSize: 30)),
              SizedBox(height: 30),
              Text("Um aplicativo para gerenciar e ajudar a manetr seus novos hábitos saudáveis.", style: TextStyle(fontSize: 20)),
              Text("Crie novos habitos e acompanhe seus progressos.", style: TextStyle(fontSize: 20)),
            ]
          ),
        ),
      ),
    );
  }

}
