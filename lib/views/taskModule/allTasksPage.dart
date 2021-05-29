import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            body: taskController.getTaskList(isCompletedTaskPage).isEmpty
                ? Center(
                    child: Text('Add your first task'),
                  )
                : ListView.builder(
                    // How many items to render
                    itemCount:
                        taskController.getTaskList(isCompletedTaskPage).length,
                    // Functions that accepts an index and renders a task
                    itemBuilder: (context, index) {
                      return Obx(() => ListTile(
                            onTap: () {
                              Get.to(TaskPage(
                                  task: taskController.getTaskList(
                                      isCompletedTaskPage)[index]));
                            },
                            leading: IconButton(
                              icon: Icon(
                                taskController
                                            .getTaskList(
                                                isCompletedTaskPage)[index]
                                            .completed
                                            .value ==
                                        true
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                              ),
                              onPressed: isCompletedTaskPage
                                  ? () {}
                                  : () {
                                      taskController
                                          .getTaskList(
                                              isCompletedTaskPage)[index]
                                          .toggleComplete(taskController
                                                  .getTaskList(
                                                      isCompletedTaskPage)[index]
                                                  .completed
                                                  .isTrue
                                              ? false
                                              : true);
                                    },
                            ),
                            title: Text(taskController
                                .getTaskList(isCompletedTaskPage)[index]
                                .name),
                            subtitle: Text(taskController
                                .getTaskList(isCompletedTaskPage)[index]
                                .description),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                              ),
                              onPressed: () {
                                taskController
                                    .getTaskList(isCompletedTaskPage)
                                    .remove(taskController.getTaskList(
                                        isCompletedTaskPage)[index]);
                              },
                            ),
                          ));
                    }),
          ),
        ));
  }
}
