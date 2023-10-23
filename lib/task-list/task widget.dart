import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_util.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/providers/list_provider.dart';

import '../model/task.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  bool isDone=false;
  void doneTask(){
    isDone = true;
  }

  TaskWidget({required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              onPressed: (context) {
                FirebaseUtile.deleteTaskFromFireStore(widget.task)
                    .timeout(Duration(milliseconds: 500), onTimeout: () {
                  print("task deleted successfully ");
                  // listProvider.getAllTasksFromFireStore();
                });
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: theme.colorScheme.onSecondaryContainer, borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                color: Theme.of(context).primaryColor,
                height: 70,
                width: 4,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 30 , right: 30),
                      child: Text(
                        widget.task.title ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 30, top: 10 , right: 30),
                      child: Text(widget.task.description ?? "",
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                  decoration: BoxDecoration(
                      color:  Theme.of(context).primaryColor ,
                      borderRadius: BorderRadius.circular(12)),
                  child:Icon(
                    Icons.check,
                    size: 35,
                    color: Colors.white,
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
