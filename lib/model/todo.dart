import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String name;
  String description;
  String todoId;
  Timestamp dateCreated;
  bool done;
  Timestamp completedAt;

  TodoModel(this.name, this.description, this.todoId, this.dateCreated,
      this.done, this.completedAt);

  TodoModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    name = documentSnapshot.data["name"];
    todoId = documentSnapshot.documentID;
    description = documentSnapshot.data["description"];
    dateCreated = documentSnapshot.data["dateCreated"];
    done = documentSnapshot.data["done"];
    completedAt = documentSnapshot.data["completed_at"];
  }
}
