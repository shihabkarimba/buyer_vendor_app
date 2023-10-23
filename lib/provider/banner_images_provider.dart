import 'package:flutter/material.dart';

class BannerImagesProvider extends ChangeNotifier {
  final List<String> bannerImages = [];

  void addBannerImage(String imageUrl) {
    bannerImages.add(imageUrl);
    notifyListeners();
  }
}
