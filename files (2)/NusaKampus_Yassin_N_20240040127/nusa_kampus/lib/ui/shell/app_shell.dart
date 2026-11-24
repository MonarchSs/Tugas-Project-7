import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/task_repository.dart';
import '../announcements/announcements_screen.dart';
import '../home/home_screen.dart';
import '../schedule/schedule_screen.dart';
import '../tasks/tasks_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    // Muat tugas lebih awal agar badge tab Tugas langsung terisi.
    unawaited(context.read<TaskRepository>().load().catchError((_) {}));
  }

  @override
  Widget build(BuildContext context) {
    final taskRepository = context.read<TaskRepository>();
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          HomeScreen(),
          ScheduleScreen(),
          TasksScreen(),
          AnnouncementsScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          const NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Jadwal',
          ),
          NavigationDestination(
            icon: ListenableBuilder(
              listenable: taskRepository,
              builder: (context, _) => Badge(
                label: Text('${taskRepository.pendingCount}'),
                isLabelVisible: taskRepository.pendingCount > 0,
                child: const Icon(Icons.checklist_outlined),
              ),
            ),
            selectedIcon: ListenableBuilder(
              listenable: taskRepository,
              builder: (context, _) => Badge(
                label: Text('${taskRepository.pendingCount}'),
                isLabelVisible: taskRepository.pendingCount > 0,
                child: const Icon(Icons.checklist),
              ),
            ),
            label: 'Tugas',
          ),
          const NavigationDestination(
            icon: Icon(Icons.campaign_outlined),
            selectedIcon: Icon(Icons.campaign),
            label: 'Pengumuman',
          ),
        ],
      ),
    );
  }
}
