import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/model/todoModel.dart';
import 'package:morphosis_demo/views/taskModule/taskPage.dart';
import 'package:morphosis_demo/widgets/customLoaderWidget.dart';
import 'taskController.dart';

class AllTasksPage extends StatelessWidget {
  AllTasksPage({this.isCompletedTaskPage = false});

  final bool isCompletedTaskPage;
  final TaskController taskController =
      Get.put<TaskController>(TaskController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomLoaderWidget(
          isTrue: taskController.isLoading.value,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Get.to(TaskPage());
                // // Call the callback with the new task name
                // tasks.add(controller.text);
                // // Go back to list screen
                // Navigator.pop(context);
              },
            ),
            body: taskController.getTaskList(isCompletedTaskPage) == null ||
                    taskController.getTaskList(isCompletedTaskPage).isBlank
                ? Center(
                    child: isCompletedTaskPage
                        ? Text('No Completed Tasks')
                        : Text('Add your first task'),
                  )
                : ListView.builder(
                    itemCount:
                        taskController.getTaskList(isCompletedTaskPage).length,
                    itemBuilder: (context, index) {
                      TodoModel todo = taskController
                          .getTaskList(isCompletedTaskPage)[index];
                      return ListTile(
                        onTap: () {
                          Get.to(TaskPage(task: todo));
                        },
                        leading: Checkbox(
                          value: todo.done,
                          onChanged: (newValue) {
                            taskController.onTaskUpdate(todo.name,
                                todo.description, newValue, todo.todoId);
                            // Database().updateTodo(newValue, uid, todo.todoId);
                          },
                        ),
                        title: Text(todo.name),
                        subtitle: Text(todo.description),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                          ),
                          onPressed: () {
                            taskController.onTaskDelete(todo.todoId);
                            // taskController
                            //     .getTaskList(isCompletedTaskPage)
                            //     .remove(taskController.getTaskList(
                            //         isCompletedTaskPage)[index]);
                          },
                        ),
                      );
                    }),
          ),
        ));
  }
}
