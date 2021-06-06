import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/model/todoModel.dart';
import 'package:morphosis_demo/services/database.dart';
import 'package:morphosis_demo/views/loginModule/loginController.dart';

class TaskController extends GetxController {
  var isLoading = false.obs;
  String uid;

  final collection = Firestore.instance.collection('tasks');

  Rx<List<TodoModel>> todoList = Rx<List<TodoModel>>();

  List<TodoModel> get todos => todoList.value;
  List<TodoModel> get todosCompleted =>
      todoList.value.where((element) => element.done == true).toList();

  @override
  void onInit() {
    uid = Get.find<LoginController>().user.id;
    todoList
        .bindStream(Database().todoStream(uid)); //stream coming from firebase
    super.onInit();
  }

  List<TodoModel> getTaskList(bool value) {
    if (value) {
      return todosCompleted;
    } else
      return todos;
  }

  void onTaskCreated(String name, String desc, bool completed) {
    isLoading(true);
    Database().addTodo(name, desc, uid, completed);
    isLoading(false);
  }

  void onTaskUpdate(String name, String desc, bool completed, String todoId) {
    isLoading(true);

    Database().updateTodo(name, desc, completed, uid, todoId);
    isLoading(false);
  }

  void onTaskDelete(String todoId) {
    isLoading(true);

    Database().deleteTodo(uid, todoId);
    isLoading(false);
  }
}
