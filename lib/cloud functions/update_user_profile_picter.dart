import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../provider/user_profile_provider.dart';

Future<void> uploadProfileImage(File imageFile, String userId, UserProfileProvider userProfileProvider) async {
  try {
    final storageReference = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('profile_images')
        .child('$userId.jpg');
    await storageReference.putFile(imageFile);
    final imageUrl = await storageReference.getDownloadURL();
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'profileImage': imageUrl,
    });
    userProfileProvider.setProfileImage(imageUrl); 
    print('Image uploaded successfully.');
  } catch (error) {
    print('Error uploading image: $error');
  }
}