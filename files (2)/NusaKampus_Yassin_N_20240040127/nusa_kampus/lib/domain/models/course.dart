/// Satu sesi kuliah dalam jadwal mingguan.
class Course {
  const Course({
    required this.id,
    required this.name,
    required this.lecturer,
    required this.room,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  final String id;
  final String name;
  final String lecturer;
  final String room;

  /// 1 = Senin ... 5 = Jumat (sama dengan DateTime.weekday).
  final int day;
  final String startTime;
  final String endTime;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json['id'] as String,
        name: json['name'] as String,
        lecturer: json['lecturer'] as String,
        room: json['room'] as String,
        day: json['day'] as int,
        startTime: json['start'] as String,
        endTime: json['end'] as String,
      );
}
