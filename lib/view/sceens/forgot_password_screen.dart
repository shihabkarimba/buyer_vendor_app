import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/bottom_text_button.dart';
import '../widgets/custom_button.dart';
import '../widgets/textfield_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  // final _auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 50, right: 100, top: 250),
              child: SizedBox(
                child: Text(
                  "Let's help you to reset your password",
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextFieldWidget(
              hintText: 'Enter your email',
              controller: _emailController,
              icon: Icons.email,
              obscureText: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email id';
                }
                final emailRegex =
                    RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              }
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonWidget(
              buttonText: 'Send Link',
              press: () async {
                // try {
                //   await _auth.sendPasswordResetEmail(
                //       email: _emailController.text);
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //       content: Text('Password reset email has beens sent'),
                //       backgroundColor: yelloColor,
                //     ),
                //   );
                // } on FirebaseAuthException {
                //   toastMessage('Something went wrong', context, textFeildColor);
                // }
              },
            ),
            const SizedBox(
              height: 200,
            ),
            BottomTextButton(
              linkText: 'Click here',
              text: 'Back to sign in,',
              navigation: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
