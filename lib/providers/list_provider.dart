import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_util.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasklist = [];
  bool isCall = false;
  DateTime selectedDate = DateTime.now();
  String currentLocale = "en";
  ThemeMode currentTheme = ThemeMode.light;


  changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    notifyListeners();
  }
  changeLanguage(String newLanguage) {
    if (currentLocale == newLanguage) return;
    currentLocale = newLanguage;
    notifyListeners();
  }

  bool isDark() {
    return currentTheme == ThemeMode.dark;
  }

  String backgroundImage() {
    return isDark() ? "assets/images/bg.png" : "assets/images/background.png";
  }

  Future<void> getAllTasksFromFireStore({required DateTime dateTime}) async {
    selectedDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
   print(selectedDate.microsecondsSinceEpoch);
    print(selectedDate);
    var querySnapshot = await FirebaseUtile.getTaskCollection()
        .where("dateTime", isEqualTo: selectedDate.microsecondsSinceEpoch)
        .get();

    tasklist = querySnapshot.docs.map(
      (doc) {
        return doc.data();
      },
    ).toList();
    print(tasklist);
    notifyListeners();
    isCall = true;
  }



}
