import '../../data/repositories/schedule_repository.dart';
import '../../domain/models/course.dart';
import '../core/base_view_model.dart';

class ScheduleViewModel extends BaseViewModel {
  ScheduleViewModel({required ScheduleRepository scheduleRepository, int? weekday})
      : _repository = scheduleRepository,
        _selectedDay = _clampToWeekday(weekday ?? DateTime.now().weekday);

  final ScheduleRepository _repository;
  int _selectedDay;
  List<Course> _courses = const [];

  /// Akhir pekan diarahkan ke Senin.
  static int _clampToWeekday(int d) => (d >= 1 && d <= 5) ? d : 1;

  int get selectedDay => _selectedDay;
  List<Course> get courses => _courses;

  @override
  Future<void> load() => runLoad(() async {
        _courses = await _repository.getCoursesByDay(_selectedDay);
      });

  Future<void> selectDay(int day) async {
    if (day == _selectedDay) return;
    _selectedDay = day;
    await load();
  }
}
