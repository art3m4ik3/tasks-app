import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskViewModel extends ChangeNotifier {
  final List<Task> _tasks = [];
  final List<Task> _bin = [];

  List<Task> get tasks => _tasks;
  List<Task> get bin => _bin;

  void addTask(String title) {
    final task = Task(id: DateTime.now().toString(), title: title);
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(Task task) {
    task.deletedAt = DateTime.now();
    _tasks.remove(task);
    _bin.add(task);
    notifyListeners();
  }

  void toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void restoreTask(Task task) {
    _bin.remove(task);
    _tasks.add(task);
    notifyListeners();
  }
}
