import 'package:buyer_vendor_app/cloud%20functions/login_user.dart';
import 'package:buyer_vendor_app/utils/constants/animation.dart';
import 'package:buyer_vendor_app/view/sceens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../widgets/bottom_text_button.dart';
import '../widgets/custom_button.dart';
import '../widgets/textfield_widget.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            LottieBuilder.asset(
              loginAnimation,
              width: screenWidth * .8,
              height: 200,
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldWidget(
                    hintText: 'Email',
                    controller: _emailController,
                    icon: Icons.email,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email id';
                      }
                      final emailRegex = RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: screenHeight * .03,
                  ),
                  TextFieldWidget(
                    hintText: 'Password',
                    controller: _passwordController,
                    icon: Icons.lock,
                    obscureText: true,
                    validator: (value) {
                      return null;
                    },
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 36,
                          // vertical: 10,
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen(),
                                ));
                          },
                          child: Text(
                            'Forgot Password',
                            style: GoogleFonts.inter(
                              color: const Color.fromARGB(115, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  ButtonWidget(
                    press: () async {
                      if (_formKey.currentState!.validate()) {
                        logInUSer(
                            context: context,
                            emil: _emailController.text.trim(),
                            password: _passwordController.text.trim());
                      }
                    },
                    buttonText: 'Login',
                  ),
                  SizedBox(
                    height: 170,
                  ),
                  BottomTextButton(
                    linkText: 'Sign up here',
                    text: "Don't have an account?",
                    navigation: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
