import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> isProductInWishlist(String productName) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    if (_auth.currentUser == null) {
      return 0;
    }

    final userWishlistSnapshot = await _firestore
        .collection('wishList')
        .doc(_auth.currentUser!.uid)
        .collection('items')
        .where('productName', isEqualTo: productName)
        .limit(1)
        .get();

    if(userWishlistSnapshot.docs.isNotEmpty){
      return 1;
    }
  } catch (e) {
    print('Error checking if product is in wishlist: $e');
    return 0; 
  }
  return 0;
}
