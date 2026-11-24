import 'package:flutter/foundation.dart';

/// Dasar semua ViewModel: menyediakan `isLoading`, `error`, dan kerangka `load()`.
abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _disposed = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> load();

  /// Membungkus proses pemuatan: set loading, tangkap error, lalu beri tahu View.
  @protected
  Future<void> runLoad(Future<void> Function() action) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await action();
    } catch (e) {
      _error = 'Gagal memuat data. ($e)';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
