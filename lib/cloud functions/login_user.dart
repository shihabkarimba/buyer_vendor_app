import 'package:buyer_vendor_app/provider/screen_change_provider.dart';
import 'package:buyer_vendor_app/provider/selected_index_provider.dart';
import 'package:buyer_vendor_app/view/sceens/home_sceen.dart';
import 'package:buyer_vendor_app/view/sceens/main_sceen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/widgets/toast_message.dart';

logInUSer({
  required BuildContext context,
  required String emil,
  required String password,
}) async {
  final _auth = FirebaseAuth.instance;
  try {

    await _auth.signInWithEmailAndPassword(
      email: emil,
      password: password,
    );

    //sharedPreference authentication----------

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAuthenticated', true);

    //----------------------------------

    Provider.of<SelectedIndexProvider>(context, listen: false)
        .changeSelectedIndex(1);
    Provider.of<ChangeScreenProvider>(context, listen: false)
        .changeScreen(const HomeScreen());

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => const MainScreen(),
      ),
    );
  } catch (error) {
    toastMessage(context: context, text: "Password doesn't match");
  }
}
