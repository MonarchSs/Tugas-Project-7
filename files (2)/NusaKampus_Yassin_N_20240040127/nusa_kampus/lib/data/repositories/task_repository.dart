import 'package:flutter/foundation.dart';

import '../../domain/models/task.dart';
import '../services/campus_service.dart';

/// Sumber tunggal data tugas. Merupakan [ChangeNotifier] sehingga Beranda,
/// halaman Tugas, dan badge tab ikut diperbarui saat tugas dicentang.
class TaskRepository extends ChangeNotifier {
  TaskRepository({required CampusService service}) : _service = service;

  final CampusService _service;
  List<Task> _tasks = const [];
  Future<void>? _pending;

  List<Task> get tasks => List.unmodifiable(_tasks);
  List<Task> get pendingTasks =>
      _tasks.where((t) => !t.isDone).toList()..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  List<Task> get doneTasks => _tasks.where((t) => t.isDone).toList();
  int get pendingCount => _tasks.where((t) => !t.isDone).length;

  /// Memuat data sekali saja; pemanggilan berikutnya memakai hasil yang sama.
  Future<void> load({bool force = false}) {
    if (force) _pending = null;
    return _pending ??= _fetch();
  }

  Future<void> _fetch() async {
    try {
      _tasks = await _service.fetchTasks();
      notifyListeners();
    } catch (_) {
      _pending = null; // izinkan retry
      rethrow;
    }
  }

  void toggleDone(String id, bool isDone) {
    _tasks = [
      for (final t in _tasks) t.id == id ? t.copyWith(isDone: isDone) : t,
    ];
    notifyListeners();
  }
}
