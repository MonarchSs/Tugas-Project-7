/// Pengumuman kampus.
class Announcement {
  const Announcement({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.category,
  });

  final String id;
  final String title;
  final String body;
  final DateTime date;
  final String category;

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        id: json['id'] as String,
        title: json['title'] as String,
        body: json['body'] as String,
        date: DateTime.parse(json['date'] as String),
        category: json['category'] as String,
      );
}
