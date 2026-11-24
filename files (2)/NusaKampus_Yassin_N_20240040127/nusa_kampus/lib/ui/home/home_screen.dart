import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/schedule_repository.dart';
import '../../data/repositories/task_repository.dart';
import '../core/formatters.dart';
import '../core/state_views.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(
      scheduleRepository: context.read<ScheduleRepository>(),
      taskRepository: context.read<TaskRepository>(),
    )..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NusaKampus')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          if (_viewModel.isLoading) return const LoadingView();
          if (_viewModel.error != null) {
            return ErrorView(message: _viewModel.error!, onRetry: _viewModel.load);
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _SectionTitle('Kuliah Hari Ini (${dayName(_viewModel.today)})'),
              if (_viewModel.todayCourses.isEmpty)
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.weekend_outlined),
                    title: Text('Tidak ada kuliah hari ini'),
                  ),
                ),
              for (final c in _viewModel.todayCourses)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.menu_book_outlined),
                    title: Text(c.name),
                    subtitle: Text('${c.startTime} - ${c.endTime}  |  ${c.room}\n${c.lecturer}'),
                    isThreeLine: true,
                  ),
                ),
              const SizedBox(height: 16),
              _SectionTitle('Tugas Belum Selesai (${_viewModel.pendingTasks.length})'),
              if (_viewModel.pendingTasks.isEmpty)
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.celebration_outlined),
                    title: Text('Semua tugas sudah selesai!'),
                  ),
                ),
              for (final t in _viewModel.pendingTasks)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.assignment_outlined),
                    title: Text(t.title),
                    subtitle: Text('${t.courseName}\nTenggat: ${formatDate(t.dueDate)}'),
                    isThreeLine: true,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: Theme.of(context).textTheme.titleMedium),
      );
}
