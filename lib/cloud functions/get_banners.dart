import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<List<String>> getBanners(BuildContext context) async {
  List<String> bannerImages = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  try {
    final QuerySnapshot querySnapshot =
        await firestore.collection('banner images').get();
    for (var doc in querySnapshot.docs) {
      bannerImages.add(doc['image']);
    }
  } catch (error) {
    debugPrint('Error fetching banners: $error');
  }
  return bannerImages;
}
