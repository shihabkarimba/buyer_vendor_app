import 'package:buyer_vendor_app/provider/screen_change_provider.dart';
import 'package:buyer_vendor_app/view/sceens/home_sceen.dart';
import 'package:buyer_vendor_app/view/sceens/main_sceen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/selected_index_provider.dart';
import '../view/widgets/toast_message.dart';

Future<void> registerUser({
  required BuildContext context,
  required String inputEmail,
  required String inputPassword,
  required String name,
}) async {
  final _auth = FirebaseAuth.instance;
  try {
    final email = inputEmail;
    final methods = await _auth.fetchSignInMethodsForEmail(inputEmail);
    if (methods.isEmpty) {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: inputPassword,
      );
      final User? user = _auth.currentUser;
      final _uid = user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(_uid).set({
        'id': _uid,
        'name': name,
        'email': email,
        'password': inputPassword,
        'address': '-',
        'phone': '-',
        'createAt': Timestamp.now(),
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isAuthenticated', true);
      
      Provider.of<SelectedIndexProvider>(context, listen: false)
          .changeSelectedIndex(1);
      Provider.of<ChangeScreenProvider>(context, listen: false)
          .changeScreen(const HomeScreen());

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
          (Route) => false);
    } else {
      toastMessage(context: context, text: 'The email is already registered');
    }
  } catch (e) {
    toastMessage(context: context, text: 'Please try again later');
  }
}
