import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_drawer_tile.dart';
import 'package:habit_tracker/pages/about_page.dart';
import 'package:habit_tracker/pages/home_page.dart';
import 'package:habit_tracker/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(children: [
         Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: 
              Row(
                children: [
                  const SizedBox(width: 40),
                  const Text('T H E M E'),
                  const SizedBox(width: 20),
                  CupertinoSwitch(
                  value: Provider.of<ThemeProvider>(context).isDarkMode,
                  onChanged: (value) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme())
                ],
              )),
          const SizedBox(
            height: 35,
          ),
          MyDrawerTile(
              text: "H O M E",
              icon: Icons.home,
       onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              }),
          MyDrawerTile(
              text: "A B O U T",
              icon: Icons.abc_outlined,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutPage()));
              }),
            

        ]));
  }
}
