import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future<void> deleteAccount(BuildContext context) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return;
  }
  final userId = user.uid;
  // Delete the profile image from Firebase Storage
  final storageReference = firebase_storage.FirebaseStorage.instance
      .ref()
      .child('profile_images')
      .child('$userId.jpg');
  try {
    await storageReference.delete();
    print('Profile image deleted successfully.');
  } catch (error) {
    print('Error deleting profile image: $error');
  }
  // Delete the user document from Firestore
  final userDocRef = FirebaseFirestore.instance.collection('users').doc(userId);
  try {
    await userDocRef.delete();
    print('User document deleted successfully.');
  } catch (error) {
    print('Error deleting user document: $error');
  }
  // Delete the user account
  try {
    await user.delete();
    print('User account deleted successfully.');
  } catch (error) {
    print('Error deleting user account: $error');
  }
}
