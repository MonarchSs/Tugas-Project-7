import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../data/repositories/announcement_repository.dart';
import '../data/repositories/schedule_repository.dart';
import '../data/repositories/task_repository.dart';
import '../data/services/campus_service.dart';

/// Mendaftarkan service dan semua repository (dependency injection).
/// Urutan penting: service dahulu, baru repository yang membutuhkannya.
Widget buildDependencies({required Widget child}) {
  return MultiProvider(
    providers: [
      Provider<CampusService>(create: (_) => CampusService()),
      Provider<ScheduleRepository>(
        create: (context) => ScheduleRepository(service: context.read<CampusService>()),
      ),
      ChangeNotifierProvider<TaskRepository>(
        create: (context) => TaskRepository(service: context.read<CampusService>()),
      ),
      Provider<AnnouncementRepository>(
        create: (context) => AnnouncementRepository(service: context.read<CampusService>()),
      ),
    ],
    child: child,
  );
}
