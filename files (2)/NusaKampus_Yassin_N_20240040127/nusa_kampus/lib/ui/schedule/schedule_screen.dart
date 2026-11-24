import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/schedule_repository.dart';
import '../core/formatters.dart';
import '../core/state_views.dart';
import 'schedule_view_model.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late final ScheduleViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ScheduleViewModel(scheduleRepository: context.read<ScheduleRepository>())
      ..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jadwal Kuliah')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<int>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(value: 1, label: Text('Sen')),
                      ButtonSegment(value: 2, label: Text('Sel')),
                      ButtonSegment(value: 3, label: Text('Rab')),
                      ButtonSegment(value: 4, label: Text('Kam')),
                      ButtonSegment(value: 5, label: Text('Jum')),
                    ],
                    selected: {_viewModel.selectedDay},
                    onSelectionChanged: (s) => _viewModel.selectDay(s.first),
                  ),
                ),
              ),
              Expanded(child: _buildBody()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    if (_viewModel.isLoading) return const LoadingView();
    if (_viewModel.error != null) {
      return ErrorView(message: _viewModel.error!, onRetry: _viewModel.load);
    }
    if (_viewModel.courses.isEmpty) {
      return EmptyView(
        icon: Icons.event_available_outlined,
        message: 'Tidak ada kuliah di hari ${dayName(_viewModel.selectedDay)}',
      );
    }
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        for (final c in _viewModel.courses)
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text(c.startTime.substring(0, 2))),
              title: Text(c.name),
              subtitle: Text('${c.startTime} - ${c.endTime}  |  ${c.room}\n${c.lecturer}'),
              isThreeLine: true,
            ),
          ),
      ],
    );
  }
}
