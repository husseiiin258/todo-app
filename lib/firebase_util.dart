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

  static Future<void> addTaskToFirebase(Task task) {
    var taskCollection = getTaskCollection();
    var taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }



  static Future<void> deleteTaskFromFireStore(Task task) {
    return getTaskCollection().doc(task.id).delete();
  }
}
