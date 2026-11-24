import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/task_repository.dart';
import '../../domain/models/task.dart';
import '../core/formatters.dart';
import '../core/state_views.dart';
import 'tasks_view_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late final TasksViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = TasksViewModel(taskRepository: context.read<TaskRepository>())..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tugas')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          if (_viewModel.isLoading) return const LoadingView();
          if (_viewModel.error != null) {
            return ErrorView(message: _viewModel.error!, onRetry: _viewModel.load);
          }
          return ListView(
            children: [
              _Header('Belum Selesai (${_viewModel.pendingTasks.length})'),
              for (final t in _viewModel.pendingTasks) _tile(t),
              _Header('Selesai (${_viewModel.doneTasks.length})'),
              for (final t in _viewModel.doneTasks) _tile(t),
            ],
          );
        },
      ),
    );
  }

  Widget _tile(Task t) => CheckboxListTile(
        key: ValueKey(t.id),
        value: t.isDone,
        onChanged: (v) => _viewModel.toggle(t, v),
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          t.title,
          style: t.isDone ? const TextStyle(decoration: TextDecoration.lineThrough) : null,
        ),
        subtitle: Text('${t.courseName}  |  Tenggat ${formatDate(t.dueDate)}'),
      );
}

class _Header extends StatelessWidget {
  const _Header(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      );
}
