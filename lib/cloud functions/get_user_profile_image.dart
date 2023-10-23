import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_profile_provider.dart';

Future<void> getUserProfielImage(String userId,BuildContext context) async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      

    final profileImageUrl = userData['profileImage'];

    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);

    userProfileProvider.setProfileImage(profileImageUrl);
       
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }