import 'package:tasks_flutter_app/localizations.dart';
import '../viewmodels/task_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../task_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('tasks')),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Navigator.pushNamed(context, '/bin');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: taskViewModel.tasks.length,
        itemBuilder: (context, index) {
          final task = taskViewModel.tasks[index];
          return ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                taskViewModel.deleteTask(task);
                TaskManager().removeTask(task.id);
              },
            ),
            onTap: () {
              taskViewModel.toggleTaskCompletion(task);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).translate('add_task')),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                taskViewModel.addTask(controller.text);
                TaskManager().addTask(controller.text);
                Navigator.pop(context);
              }
            },
            child: Text(AppLocalizations.of(context).translate('add')),
          ),
        ],
      ),
    );
  }
}
