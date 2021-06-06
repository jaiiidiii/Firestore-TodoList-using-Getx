import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morphosis_demo/model/todoModel.dart';
import 'package:morphosis_demo/model/user.dart';

class Database {
  final Firestore _firestore = Firestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").document(user.id).setData({
        "name": user.name,
        "email": user.email,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("users").document(uid).get();

      return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addTodo(
      String name, String description, String uid, bool completed) async {
    try {
      await _firestore
          .collection("users")
          .document(uid)
          .collection("todos")
          .add({
        'name': name,
        'dateCreated': Timestamp.now(),
        'description': description,
        'completed_at': completed == true ? Timestamp.now() : null,
        'done': completed,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<TodoModel>> todoStream(String uid) {
    return _firestore
        .collection("users")
        .document(uid)
        .collection("todos")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> retVal = [];
      query.documents.forEach((element) {
        retVal.add(TodoModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  // Stream<List<TodoModel>> todoCompletedStream(String uid) {
  //   return _firestore
  //       .collection("users")
  //       .document(uid)
  //       .collection("todos")
  //       .orderBy("dateCreated", descending: true)
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     List<TodoModel> retVal = List();

  //     query.documents.forEach((element) {
  //       if (element.data["done"])
  //         retVal.add(TodoModel.fromDocumentSnapshot(element));
  //     });
  //     return retVal;
  //   });
  // }

  Future<void> updateTodo(String name, String description, bool newValue,
      String uid, String todoId) async {
    try {
      _firestore
          .collection("users")
          .document(uid)
          .collection("todos")
          .document(todoId)
          .updateData({
        'name': name,
        'completed_at': newValue == true ? Timestamp.now() : null,
        'description': description,
        "done": newValue
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteTodo(String uid, String todoId) async {
    try {
      _firestore
          .collection("users")
          .document(uid)
          .collection("todos")
          .document(todoId)
          .delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
