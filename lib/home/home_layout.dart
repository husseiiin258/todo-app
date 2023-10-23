import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/settings/settings.dart';
import 'package:todo/task-list/add_task_bottom_sheet.dart';
import 'package:todo/task-list/task_list.dart';

import '../providers/list_provider.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({super.key});

  static const String routeName = "home_layout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ListProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(

      body: tabs[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: theme.colorScheme.onSecondaryContainer,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: appProvider.currentLocale == "en" ? "Tasks List" : "قائمة المهام ",),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),  label: appProvider.currentLocale == "en" ? "Settings" : "الاعدادات"),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
            side: BorderSide(
          color: theme.colorScheme.onSecondaryContainer,
          width: 5,
        )),
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: const Icon(

          Icons.add,
          size: 30,color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  List<Widget> tabs = [
    TaskListTab(),
    SettingsTab(),
  ];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => AddTaskBottomSheet());
  }
}
