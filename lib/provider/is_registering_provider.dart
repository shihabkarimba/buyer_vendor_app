import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier {
  bool _isRegistering = false;

  bool get isRegistering => _isRegistering;

  void startRegistration() {
    _isRegistering = true;
    notifyListeners();
  }

  void stopRegistration() {
    _isRegistering = false;
    notifyListeners();
  }
}
