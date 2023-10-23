import 'package:flutter/material.dart';

class ProductAddUnitProvider extends ChangeNotifier {
  int _currentCount = 1;

  int get currentCount => _currentCount;

  void incrementCount() {
    _currentCount++;
    notifyListeners();
  }

  void decrementCount() {
    if (_currentCount > 1) {
      _currentCount--;
      notifyListeners();
    }
  }
}