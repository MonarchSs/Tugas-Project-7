import '../../data/repositories/schedule_repository.dart';
import '../../data/repositories/task_repository.dart';
import '../../domain/models/course.dart';
import '../../domain/models/task.dart';
import '../core/base_view_model.dart';

/// Menggabungkan data ScheduleRepository dan TaskRepository untuk Beranda.
class HomeViewModel extends BaseViewModel {
  HomeViewModel({
    required ScheduleRepository scheduleRepository,
    required TaskRepository taskRepository,
    int? weekday,
  })  : _scheduleRepository = scheduleRepository,
        _taskRepository = taskRepository,
        today = weekday ?? DateTime.now().weekday {
    _taskRepository.addListener(notifyListeners); // ikut berubah saat tugas dicentang
  }

  final ScheduleRepository _scheduleRepository;
  final TaskRepository _taskRepository;

  /// Hari ini (1 = Senin ... 7 = Minggu).
  final int today;

  List<Course> _todayCourses = const [];
  List<Course> get todayCourses => _todayCourses;
  List<Task> get pendingTasks => _taskRepository.pendingTasks;

  @override
  Future<void> load() => runLoad(() async {
        final results = await Future.wait([
          _scheduleRepository.getCoursesByDay(today),
          _taskRepository.load(),
        ]);
        _todayCourses = results[0] as List<Course>;
      });

  @override
  void dispose() {
    _taskRepository.removeListener(notifyListeners);
    super.dispose();
  }
}
