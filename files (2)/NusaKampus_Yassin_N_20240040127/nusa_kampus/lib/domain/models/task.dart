/// Tugas kuliah. Immutable: ubah lewat [copyWith].
class Task {
  const Task({
    required this.id,
    required this.title,
    required this.courseName,
    required this.dueDate,
    this.isDone = false,
  });

  final String id;
  final String title;
  final String courseName;
  final DateTime dueDate;
  final bool isDone;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] as String,
        title: json['title'] as String,
        courseName: json['course'] as String,
        dueDate: DateTime.parse(json['due'] as String),
        isDone: json['isDone'] as bool? ?? false,
      );

  Task copyWith({
    String? id,
    String? title,
    String? courseName,
    DateTime? dueDate,
    bool? isDone,
  }) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        courseName: courseName ?? this.courseName,
        dueDate: dueDate ?? this.dueDate,
        isDone: isDone ?? this.isDone,
      );
}
