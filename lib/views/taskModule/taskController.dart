import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/model/taskModel.dart';
import 'package:morphosis_demo/model/todo.dart';
import 'package:morphosis_demo/services/database.dart';
import 'package:morphosis_demo/views/loginModule/loginController.dart';

import '../auth.dart';

class TaskController extends GetxController {
  var isLoading = false.obs;
  String uid;
  var defaultStatus = false.obs;
  var tasks = <Task>[].obs;

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
    fetchTasks();
    super.onInit();
  }

  List<TodoModel> getTaskList(bool value) {
    if (value) {
      return todosCompleted;
    } else
      return todos;
  }

  void fetchTasks() async {
    try {
      isLoading(true);

      await Future.delayed(Duration(seconds: 2));
      tasks.add(
        Task(
            name: 'Do homework',
            description: 'Kindly Complete your Homeword',
            completed: false.obs),
      );
      tasks.add(Task(
          name: 'Laundry',
          description: 'wash out laundry',
          completed: false.obs));
      tasks.add(Task(
          name: 'Finish this tutorial',
          description: 'finish baby',
          completed: false.obs));
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  final List<Task> tasksList = [];
  final Authentication auth = new Authentication();
  // FirebaseUser user;

  void onTaskCreated(String name, String desc, bool completed) {
    Database().addTodo(name, desc, uid, completed);
  }

//updateFirestore
  void onTaskUpdate(String name, String desc, bool completed, String todoId) {
    Database().updateTodo(name, desc, completed, uid, todoId);
    // setState(() {
    // tasksList.add(Task(name: name, description: desc, completed: false.obs));
    // });
  }

  //updateFirestore
  void onTaskDelete(String todoId) {
    Database().deleteTodo(uid, todoId);
    // setState(() {
    // tasksList.add(Task(name: name, description: desc, completed: false.obs));
    // });
  }

  void onTaskToggled(Task task) {
    // setState(() {
    task.toggleComplete(true);
    // task.setCompleted(!task.isCompleted());
    // });
  }
}
