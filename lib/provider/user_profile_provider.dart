import 'package:flutter/material.dart';

class UserProfileProvider with ChangeNotifier {
  String? _profileImageUrl;
  bool _isImageUploading = false; 

  String? get profileImageUrl => _profileImageUrl;
  bool get isImageUploading => _isImageUploading; 

  void setProfileImage(String imageUrl) {
    _profileImageUrl = imageUrl;
    notifyListeners();
  }

  void setImageUploading(bool uploading) {
    _isImageUploading = uploading;
    notifyListeners();
  }
}
