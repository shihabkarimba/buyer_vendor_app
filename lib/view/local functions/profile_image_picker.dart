import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../cloud functions/update_user_profile_picter.dart';
import '../../provider/user_profile_provider.dart';

Future<void> pickProfileImage(BuildContext context) async {
  final ImagePicker _picker = ImagePicker();
  final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    final imageFile = File(pickedFile.path);
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
      userProfileProvider.setImageUploading(true); 
      try {
        await uploadProfileImage(imageFile, userId, userProfileProvider);
      } catch (error) {
        print('Error uploading image: $error');
      } finally {
        userProfileProvider.setImageUploading(false); 
      }
    }
  }
}


