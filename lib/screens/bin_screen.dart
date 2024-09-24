import 'package:tasks_flutter_app/localizations.dart';
import '../viewmodels/task_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class BinScreen extends StatelessWidget {
  const BinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('bin')),
      ),
      body: ListView.builder(
        itemCount: taskViewModel.bin.length,
        itemBuilder: (context, index) {
          final task = taskViewModel.bin[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(
                '${AppLocalizations.of(context).translate('deleted')} ${task.deletedAt}'),
            trailing: IconButton(
              icon: const Icon(Icons.restore),
              onPressed: () {
                taskViewModel.restoreTask(task);
              },
            ),
          );
        },
      ),
    );
  }
}
