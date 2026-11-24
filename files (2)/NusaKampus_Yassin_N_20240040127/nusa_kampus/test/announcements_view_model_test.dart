import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kampus/data/repositories/announcement_repository.dart';
import 'package:nusa_kampus/data/services/campus_service.dart';
import 'package:nusa_kampus/domain/models/announcement.dart';
import 'package:nusa_kampus/ui/announcements/announcements_view_model.dart';

/// Service palsu tanpa jeda agar test cepat dan deterministik.
class _FakeCampusService extends CampusService {
  _FakeCampusService({this.shouldFail = false});

  final bool shouldFail;

  @override
  Future<List<Announcement>> fetchAnnouncements() async {
    if (shouldFail) throw Exception('server error');
    return [
      Announcement(
        id: 'a1',
        title: 'Lama',
        body: 'Pengumuman lama',
        date: DateTime(2026, 11, 1),
        category: 'Akademik',
      ),
      Announcement(
        id: 'a2',
        title: 'Baru',
        body: 'Pengumuman baru',
        date: DateTime(2026, 11, 20),
        category: 'Kegiatan',
      ),
    ];
  }
}

AnnouncementsViewModel _buildViewModel({bool shouldFail = false}) =>
    AnnouncementsViewModel(
      announcementRepository:
          AnnouncementRepository(service: _FakeCampusService(shouldFail: shouldFail)),
    );

void main() {
  group('AnnouncementsViewModel', () {
    test('state awal: kosong, tidak loading, tanpa error', () {
      final vm = _buildViewModel();
      expect(vm.announcements, isEmpty);
      expect(vm.isLoading, isFalse);
      expect(vm.error, isNull);
    });

    test('load() sukses mengisi daftar terurut terbaru dahulu', () async {
      final vm = _buildViewModel();
      await vm.load();

      expect(vm.isLoading, isFalse);
      expect(vm.error, isNull);
      expect(vm.announcements.length, 2);
      expect(vm.announcements.first.title, 'Baru');
    });

    test('isLoading bernilai true selama proses load()', () async {
      final vm = _buildViewModel();
      final states = <bool>[];
      vm.addListener(() => states.add(vm.isLoading));

      await vm.load();

      expect(states.first, isTrue); // mulai loading
      expect(states.last, isFalse); // selesai
    });

    test('load() gagal mengisi error dan menghentikan loading', () async {
      final vm = _buildViewModel(shouldFail: true);
      await vm.load();

      expect(vm.error, isNotNull);
      expect(vm.isLoading, isFalse);
      expect(vm.announcements, isEmpty);
    });
  });
}
