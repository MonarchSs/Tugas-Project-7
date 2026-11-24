import '../../domain/models/announcement.dart';
import '../services/campus_service.dart';

class AnnouncementRepository {
  AnnouncementRepository({required CampusService service}) : _service = service;

  final CampusService _service;

  /// Pengumuman terbaru ditampilkan paling atas.
  Future<List<Announcement>> getAnnouncements() async {
    final list = await _service.fetchAnnouncements();
    return list..sort((a, b) => b.date.compareTo(a.date));
  }
}
