import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../view/widgets/toast_message.dart';

Future<void> addToCart({
  required String productName,
  required double price,
  required int quantity,
  required String imageSrc,
  required String productUnit,
  required BuildContext context,
}) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference cartCollection = _firestore
      .collection('cart')
      .doc(_auth.currentUser!.uid)
      .collection('items');

  try {
    final QuerySnapshot snapshot =
        await cartCollection.where('productName', isEqualTo: productName).get();

    if (snapshot.docs.isNotEmpty) {
      toastMessage(
        text: '$productName already exist in your cart',
        context: context,
      );
      return;
    }

    await cartCollection.add({
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'image': imageSrc,
      'productUnit': productUnit,
    });

    toastMessage(
      text: 'Prodect added to your cart',
      context: context,
    );

    print('Item added to cart successfully');
  } catch (e) {
    print('Failed to add item to cart: $e');
  }
}
