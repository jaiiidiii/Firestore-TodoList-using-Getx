import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/model/taskModel.dart';

import '../auth.dart';

class TaskController extends GetxController {
  //https://everyday.codes/tutorials/developing-a-todo-app-with-flutter-part-3/
  // var chatsList = List<AllThreads>().obs;
  // var chatList = List<Chats>().obs;
  var isLoading = false.obs;

  var defaultStatus = false.obs;
  var tasks = <Task>[].obs;
  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  List<Task> getTaskList(bool value) {
    if (value) {
      return tasks.where((t) => t.isCompleted).toList();
    } else
      return tasks;
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
  FirebaseUser user;

  void onTaskCreated(String name, String desc) {
    // setState(() {
    tasksList.add(Task(name: name, description: desc, completed: false.obs));
    // });
  }

  void onTaskToggled(Task task) {
    // setState(() {
    task.toggleComplete(true);
    // task.setCompleted(!task.isCompleted());
    // });
  }

}
