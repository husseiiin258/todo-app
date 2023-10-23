import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_util.dart';
import 'package:todo/providers/list_provider.dart';

import '../model/task.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';

  String description = '';

  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ListProvider>(context);
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            "Add New Task",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please enter task title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: 'Enter Task Title'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (desc) {
                        description = desc;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return ' please enter task description';
                        }
                        return null;
                      },
                      decoration:
                          InputDecoration(hintText: 'Enter Task Description'),
                      maxLines: 4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Select Date",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showCalendar();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          addTask();
                        },
                        child: Text(
                          appProvider.currentLocale == "en" ? "ADD" : "اضافة",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                        )),
                  )
                ],
              ))
        ],
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
    selectedDate =  DateTime(selectedDate.year,selectedDate.month,selectedDate.day);

      Task task = Task(
          title: title,
          description: description,
          dateTime: selectedDate);
      FirebaseUtile.addTaskToFirebase(task).timeout(Duration(milliseconds: 500),
          onTimeout: () {
        print("to do added successfully");
        listProvider.getAllTasksFromFireStore(dateTime: selectedDate);
        Navigator.pop(context);
      });
    }
  }
}
