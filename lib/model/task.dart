import 'package:cloud_firestore/cloud_firestore.dart';

class Task{
  static const String collectionName = 'tasks';
  String? id ;
  String? title ;
  String? description ;
  DateTime? dateTime ;
  bool isDone;

  Task({this.id="" ,
    required this.title ,
    required this.description ,
    required this.dateTime ,
    required this.isDone,
  }
  );

  Task.fromFireStore(Map<String, dynamic> data):this(
    id: data['id'] as String?,
    title: data['title'] as String?,
    description: data['description']as String?,
    dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
    isDone: data['isDone']
  );

  Map<String , dynamic> toFireStore(){
    return{
      'id' : id,
      'title' : title,
      'description' : description,
      'dateTime' : dateTime?.microsecondsSinceEpoch,
      'isDone' : isDone
    };
  }
}