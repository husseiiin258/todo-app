import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_util.dart';

import 'package:todo/my_theme.dart';
import 'package:todo/providers/list_provider.dart';
import 'package:todo/task-list/task%20widget.dart';

import '../model/task.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ListProvider>(context);
    var locale = AppLocalizations.of(context)!;
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var listProvider = Provider.of<ListProvider>(context);
    if (!listProvider.isCall) {
      listProvider.getAllTasksFromFireStore(dateTime: DateTime.now());
    }

    return Column(
      children: [
        Stack(

          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20 , top: 45 , right: 20),
              height: mediaQuery.height*0.30,
              color: theme.primaryColor,
              width:mediaQuery.width ,
            child: Text(locale.to_do_list, style: theme.textTheme.bodyLarge,),),
            Positioned(

                height: mediaQuery.width*0.1,
                width: mediaQuery.width,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  color:appProvider.isDark()?MyTheme.backgroundDark :MyTheme.backgroundLight,
                )),
            Positioned(
              top: 125,
              width: mediaQuery.width,


              child: CalendarTimeline(
                shrink: false,
                initialDate: listProvider.selectedDate,
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateSelected: (date) {
                  print(date);
                  listProvider.getAllTasksFromFireStore(dateTime: date);
                },
                leftMargin: 20,
                monthColor:theme.colorScheme.onSecondary,
                dayColor: theme.colorScheme.onSecondary,
                activeDayColor: theme.colorScheme.onPrimary,
                activeBackgroundDayColor: theme.colorScheme.onSecondaryContainer,
                dotsColor: theme.colorScheme.onPrimary,
                selectableDayPredicate: (date) => true,
                locale: 'en_ISO',
              ),
            ),


          ],
        ),


        Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
                stream: FirebaseUtile.getRealTimeDataFromFireStore(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(snapshot.error.toString()),
                        const SizedBox(height: 20),
                        IconButton(onPressed: () {}, icon: Icon(Icons.refresh))
                      ],
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: theme.primaryColor,
                      ),
                    );
                  }
                  var tasksList =
                      snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) =>
                        TaskWidget(task:tasksList[index]),
                    itemCount: tasksList.length,
                  );
                  }),
            )
      ],
    );
  }
}
