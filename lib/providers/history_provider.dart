import 'package:flutter/material.dart';
import '../models/calculation_history.dart';
import '../services/storage_service.dart';

class HistoryProvider extends ChangeNotifier {
  List<CalculationHistory> _history = [];

  List<CalculationHistory> get history => _history;

  // Lấy 3 phép tính gần nhất
  List<CalculationHistory> get lastThree {
    if (_history.length <= 3) return List.from(_history.take(3));
    return List.from(_history.take(3));
  }

  Future<void> loadHistory() async {
    _history = await StorageService.loadHistory();
    notifyListeners();
  }

  Future<void> addHistory(CalculationHistory item) async {
    _history.insert(0, item);
    await StorageService.saveHistory(_history);
    notifyListeners();
  }

  Future<void> clearHistory() async {
    _history = [];
    await StorageService.saveHistory(_history);
    notifyListeners();
  }
}
