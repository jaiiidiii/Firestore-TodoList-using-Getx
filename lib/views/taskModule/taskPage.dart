import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/model/taskModel.dart';
import 'package:morphosis_demo/views/taskModule/taskController.dart';
import 'package:morphosis_demo/widgets/customLoaderWidget.dart';

class TaskPage extends StatelessWidget {
  TaskPage({this.task});

  final Task task;
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

  final Task task;
  @override
  __TaskFormState createState() => __TaskFormState(task);
}

class __TaskFormState extends State<_TaskForm> {
  static const double _padding = 16;

  __TaskFormState(this.task);

  Task task;
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  final TaskController taskController = Get.find<TaskController>();

  // var isCompleted = false.obs;
  void init() {
    if (task == null) {
      task = Task(completed: false.obs);
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    } else {
      // isCompleted = task.completed;
      _titleController = TextEditingController(text: task.name);
      _descriptionController = TextEditingController(text: task.description);
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void _save(BuildContext context) {
    task.name = _titleController.text;
    task.description = _descriptionController.text;
    taskController.tasks.add(task);
    taskController.onTaskCreated(_titleController.text,
        _descriptionController.text, task.completed.value);
    // taskController.
    Get.back();
    //TODO implement save to firestore

    // FirebaseManager.shared.addTask(task);
    // Navigator.of(context).pop();
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
                        value: task.completed.value,
                        onChanged: (value) {
                          // setState(() {
                          // isCompleted.toggle();
                          task.toggleComplete(value);
                          // });
                        },
                      )),
                ],
              ),
              // Spacer(),
              // Expanded(child: null),
              ElevatedButton(
                onPressed: () => _save(context),
                child: Container(
                  width: double.infinity,
                  child: Center(child: Text(task.isNew ? 'Create' : 'Update')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
