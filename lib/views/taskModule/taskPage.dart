import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/model/todoModel.dart';
import 'package:morphosis_demo/views/taskModule/taskController.dart';
import 'package:morphosis_demo/widgets/customLoaderWidget.dart';

class TaskPage extends StatelessWidget {
  TaskPage({this.task});

  final TodoModel task;
  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomLoaderWidget(
          isTrue: taskController.isLoading.value,
          child: Scaffold(
            appBar: AppBar(
              title: Text(task == null ? 'New Task' : 'Edit Task'),
            ),
            body: _TaskForm(task),
          ),
        ));
  }
}

class _TaskForm extends StatefulWidget {
  _TaskForm(this.task);

  final TodoModel task;
  @override
  __TaskFormState createState() => __TaskFormState(task);
}

class __TaskFormState extends State<_TaskForm> {
  static const double _padding = 16;

  __TaskFormState(this.task);

  TodoModel task;
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  final TaskController taskController = Get.find<TaskController>();
  var isCompleted = false.obs;

  void init() {
    if (task == null) {
      isCompleted(false);
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    } else {
      isCompleted(task.done);
      _titleController = TextEditingController(text: task.name);
      _descriptionController = TextEditingController(text: task.description);
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void updateTask() {
    if (task != null) {
      taskController.onTaskUpdate(_titleController.text,
          _descriptionController.text, isCompleted.value, task.todoId);
    } else {
      taskController.onTaskCreated(_titleController.text,
          _descriptionController.text, isCompleted.value);
    }
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(_padding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: _padding),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              SizedBox(height: _padding),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                minLines: 5,
                maxLines: 10,
              ),
              SizedBox(height: _padding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Completed ?'),
                  Obx(() => Switch(
                        value: isCompleted.value,
                        onChanged: (value) {
                          isCompleted(value);
                        },
                      )),
                ],
              ),
              ElevatedButton(
                onPressed: () => updateTask(),
                child: Container(
                  width: double.infinity,
                  child:
                      Center(child: Text(task == null ? 'Create' : 'Update')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
