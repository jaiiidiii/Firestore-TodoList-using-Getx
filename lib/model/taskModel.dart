import 'package:get/get.dart';

class Task {
  Task({this.name, this.description, this.completed});

  // Class properties
  // Underscore makes them private
  String name;
  RxBool completed;
  String description;
  // @JsonKey(name: 'completed_at')
  DateTime completedAt;
  String id;

  bool get isNew {
    return id == null;
  }

  bool get isCompleted {
    return completedAt != null;
  }

  void toggleComplete(bool value) {
    // completed.toggle();
    if (!value) {
      completed(false);
      completedAt = null;
    } else {
      completed(true);
      completedAt = DateTime.now();
    }
  }
  // Default constructor
  // this syntax means that it will accept a value and set it to this.name
  // Task(this._name, this._description);

  // Getter and setter for name
  // getName() => this._name;
  // setName(name) => this._name = name;

  // Getter and setter for name
  // getDesc() => this._description;
  // setDesc(desc) => this._description = desc;

  // Getter and setter for completed
  // isCompleted() => this._completed;
  // setCompleted(completed) => this._completed = completed;
}
