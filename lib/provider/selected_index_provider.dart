import 'package:flutter/material.dart';

class SelectedIndexProvider with ChangeNotifier {
  int selectedIndex = 1;

  void changeSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}