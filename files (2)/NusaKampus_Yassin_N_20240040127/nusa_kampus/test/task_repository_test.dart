import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kampus/data/repositories/task_repository.dart';
import 'package:nusa_kampus/data/services/campus_service.dart';

void main() {
  group('TaskRepository', () {
    late TaskRepository repo;

    setUp(() async {
      repo = TaskRepository(service: CampusService(latency: Duration.zero));
      await repo.load();
    });

    test('toggleDone memindahkan tugas ke daftar selesai dan memberi notifikasi', () {
      var notified = 0;
      repo.addListener(() => notified++);
      final before = repo.pendingCount;

      repo.toggleDone('t1', true);

      expect(repo.pendingCount, before - 1);
      expect(repo.doneTasks.any((t) => t.id == 't1'), isTrue);
      expect(notified, 1);
    });

    test('toggleDone(false) mengembalikan tugas ke belum selesai', () {
      repo.toggleDone('t5', false);
      expect(repo.pendingTasks.any((t) => t.id == 't5'), isTrue);
    });
  });
}
