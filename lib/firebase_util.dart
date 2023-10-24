import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/task.dart';

class FirebaseUtile {
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, option) => task.toFireStore());
  }

  static Future<void> addTaskToFirebase(Task task) async {
    var taskCollection = getTaskCollection();
    var taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id;
    return await taskDocRef.set(task);
  }



  static Future<void> deleteTaskFromFireStore(Task task) {
    var collectionRef = getTaskCollection();
    return collectionRef.doc(task.id).delete();
  }


  static Future<void> isDone(Task task)async{
     getTaskCollection().doc(task.id).update({"isDone" : !task.isDone!

     });
  }


  static Stream<QuerySnapshot<Task>> getRealTimeDataFromFireStore(){
    var snapshot = getTaskCollection().snapshots();
    return snapshot;
  }
}
