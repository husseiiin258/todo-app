import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo/my_theme.dart';
import 'package:todo/providers/list_provider.dart';
import 'package:todo/task-list/task%20widget.dart';

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
              padding: EdgeInsets.only(left: 20 , top: 30 , right: 20),
              height: mediaQuery.height*0.27,
              color: theme.primaryColor,
              width:mediaQuery.width ,
            child: Text(locale.to_do_list, style: theme.textTheme.bodyLarge,),),
            Positioned(

                height: 30,
                width: mediaQuery.width,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  color:appProvider.isDark()?MyTheme.backgroundDark :MyTheme.backgroundLight,
                )),
            Positioned(
              top: 120,
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
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskWidget(task: listProvider.tasklist[index]);
            },
            itemCount: listProvider.tasklist.length,
          ),
        )
      ],
    );
  }
}
