import '../../data/repositories/announcement_repository.dart';
import '../../domain/models/announcement.dart';
import '../core/base_view_model.dart';

class AnnouncementsViewModel extends BaseViewModel {
  AnnouncementsViewModel({required AnnouncementRepository announcementRepository})
      : _repository = announcementRepository;

  final AnnouncementRepository _repository;
  List<Announcement> _announcements = const [];

  List<Announcement> get announcements => _announcements;

  @override
  Future<void> load() => runLoad(() async {
        _announcements = await _repository.getAnnouncements();
      });
}
