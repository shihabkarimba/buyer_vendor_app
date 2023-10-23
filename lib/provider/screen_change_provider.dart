import 'package:buyer_vendor_app/view/sceens/home_sceen.dart';
import 'package:flutter/material.dart';

class ChangeScreenProvider with ChangeNotifier {
  Widget currentScreen = const HomeScreen();

  void changeScreen(Widget screen) {
    currentScreen = screen;
    notifyListeners();
  }
}