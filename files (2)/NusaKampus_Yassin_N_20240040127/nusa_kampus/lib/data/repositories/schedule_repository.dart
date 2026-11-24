import '../../domain/models/course.dart';
import '../services/campus_service.dart';

/// Sumber tunggal data jadwal kuliah. Hasil di-cache setelah pemanggilan pertama.
class ScheduleRepository {
  ScheduleRepository({required CampusService service}) : _service = service;

  final CampusService _service;
  List<Course>? _cache;

  Future<List<Course>> getCourses() async => _cache ??= await _service.fetchCourses();

  Future<List<Course>> getCoursesByDay(int day) async {
    final all = await getCourses();
    return all.where((c) => c.day == day).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }
}
