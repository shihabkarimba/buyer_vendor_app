import 'package:flutter/foundation.dart';

class BannerIndexProvider with ChangeNotifier {
  int currentIndex = 0;

  void updateIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}