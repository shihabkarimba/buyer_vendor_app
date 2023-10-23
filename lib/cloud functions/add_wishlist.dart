import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../view/widgets/toast_message.dart';
Future<void> addToWishList({
  required String categoryName,
  required String productName,
  required String price,
  required String imageSrc,
  required String productUnit,
  required String productDescription,
  required BuildContext context,
  required bool isLiked,
}) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference wishListCollection = _firestore
      .collection('wishList')
      .doc(_auth.currentUser!.uid)
      .collection('items');
  try {

    await wishListCollection.add({
      'categoryName': categoryName,
      'productName': productName,
      'price': price,
      'image': imageSrc,
      'description': productDescription,
      'productUnit': productUnit,
    });

    toastMessage(
      text: 'Product added to your wishlist',
      context: context,
    );

    print('Item added to wishlist successfully');
  } catch (e) {
    print('Failed to add item to wishlist: $e');
  }
}
