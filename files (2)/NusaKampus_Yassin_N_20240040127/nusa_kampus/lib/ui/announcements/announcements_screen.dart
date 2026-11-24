import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/announcement_repository.dart';
import '../core/formatters.dart';
import '../core/state_views.dart';
import 'announcements_view_model.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  late final AnnouncementsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AnnouncementsViewModel(
      announcementRepository: context.read<AnnouncementRepository>(),
    )..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengumuman')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          if (_viewModel.isLoading) return const LoadingView();
          if (_viewModel.error != null) {
            return ErrorView(message: _viewModel.error!, onRetry: _viewModel.load);
          }
          if (_viewModel.announcements.isEmpty) {
            return const EmptyView(icon: Icons.campaign_outlined, message: 'Belum ada pengumuman');
          }
          return RefreshIndicator(
            onRefresh: _viewModel.load,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _viewModel.announcements.length,
              itemBuilder: (context, i) {
                final a = _viewModel.announcements[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Chip(label: Text(a.category), visualDensity: VisualDensity.compact),
                            const Spacer(),
                            Text(formatDate(a.date), style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(a.title, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text(a.body),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
