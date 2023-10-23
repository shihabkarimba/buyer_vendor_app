import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> deleteWishlistItemByName({
  required String productName,
}) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference wishListCollection = _firestore
      .collection('wishList')
      .doc(_auth.currentUser!.uid)
      .collection('items');

  try {
    final QuerySnapshot querySnapshot = await wishListCollection
        .where('productName', isEqualTo: productName)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      await wishListCollection.doc(querySnapshot.docs[0].id).delete();

      print('Item removed from wishlist successfully');
    } else {
      print('Product not found in the wishlist');
    }
  } catch (e) {
    print('Failed to remove item from wishlist: $e');
  }
}
