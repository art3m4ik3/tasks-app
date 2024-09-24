import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'models/task.dart';
import 'dart:convert';

class TaskManager extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> _deletedTasks = [];

  List<Task> get tasks => _tasks;
  List<Task> get deletedTasks => _deletedTasks;

  TaskManager() {
    _loadTasks();
  }

  void addTask(String title) {
    final newTask = Task(id: DateTime.now().toString(), title: title);
    _tasks.add(newTask);
    _saveTasks();
    notifyListeners();
  }

  void removeTask(String id) {
    try {
      final taskToRemove = _tasks.firstWhere((task) => task.id == id);
      _tasks.remove(taskToRemove);
      _deletedTasks.add(taskToRemove);
      _saveTasks();
      notifyListeners();
    } catch (_) {}
  }

  void restoreTask(Task task) {
    _deletedTasks.remove(task);
    _tasks.add(task);
    _saveTasks();
    notifyListeners();
  }

  void toggleTaskStatus(String id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.isCompleted = !task.isCompleted;
    _saveTasks();
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = jsonEncode(_tasks.map((task) => task.toJson()).toList());
    final deletedTasksJson =
        jsonEncode(_deletedTasks.map((task) => task.toJson()).toList());
    await prefs.setString('tasks', tasksJson);
    await prefs.setString('deletedTasks', deletedTasksJson);
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasks');
    final deletedTasksJson = prefs.getString('deletedTasks');

    if (tasksJson != null) {
      final List<dynamic> taskList = jsonDecode(tasksJson);
      _tasks = taskList.map((task) => Task.fromJson(task)).toList();
    }

    if (deletedTasksJson != null) {
      final List<dynamic> deletedList = jsonDecode(deletedTasksJson);
      _deletedTasks = deletedList.map((task) => Task.fromJson(task)).toList();
    }

    notifyListeners();
  }
}
