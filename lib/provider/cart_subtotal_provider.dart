import 'package:flutter/material.dart';

class CartSubtotalProvider with ChangeNotifier {
  double _subtotal = 0;

  double get subtotal => _subtotal;

  void updateSubtotal(double amount) {
    _subtotal = amount;
    notifyListeners();
  }
}
