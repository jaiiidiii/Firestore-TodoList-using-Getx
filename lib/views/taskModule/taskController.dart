import 'package:get/get.dart';
import 'package:morphosis_demo/model/taskModel.dart';

class TaskController extends GetxController {
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
}
