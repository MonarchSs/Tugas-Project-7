import 'package:flutter/material.dart';

import 'ui/core/app_theme.dart';
import 'ui/shell/app_shell.dart';

class NusaKampusApp extends StatelessWidget {
  const NusaKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaKampus',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const AppShell(),
    );
  }
}
