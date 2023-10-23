import 'package:buyer_vendor_app/cloud%20functions/register_user.dart';
import 'package:buyer_vendor_app/utils/constants/animation.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../provider/is_registering_provider.dart';
import '../widgets/bottom_text_button.dart';
import '../widgets/custom_button.dart';
import '../widgets/textfield_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          LottieBuilder.asset(registerAnimation),
          SizedBox(
            height: screenHeight * .05,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFieldWidget(
                  hintText: 'Full Name',
                  controller: _nameController,
                  icon: Icons.account_box,
                  obscureText: false,
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: screenHeight * .03,
                ),
                TextFieldWidget(
                  validator: (email) {
                    if (!EmailValidator.validate(email!)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  hintText: 'Email',
                  controller: _emailController,
                  icon: Icons.email,
                  obscureText: false,
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
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: screenHeight * .03,
                ),
                TextFieldWidget(
                  hintText: 'Confirm Password',
                  controller: _confirmPasswordController,
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    // ignore: unrelated_type_equality_checks
                    if (_confirmPasswordController.text !=
                        _passwordController.text) {
                      return "Password doesn't match";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: screenHeight * .03,
                ),
                Consumer<RegistrationProvider>(
                  builder: (context, registrationProvider, _) {
                    return registrationProvider.isRegistering
                        ? CircularProgressIndicator()
                        : ButtonWidget(
                            press: () async {
                              if (_formKey.currentState!.validate()) {
                                registrationProvider
                                    .startRegistration(); 
                                try {
                                  await registerUser(
                                    context: context,
                                    name: _nameController.text.trim(),
                                    inputEmail: _emailController.text.trim(),
                                    inputPassword:
                                        _passwordController.text.trim(),
                                  );
                                } finally {
                                  registrationProvider
                                      .stopRegistration(); 
                                }
                              }
                            },
                            buttonText: 'Sign up',
                          );
                  },
                ),
                SizedBox(
                  height: 100,
                ),
                BottomTextButton(
                  linkText: 'Login here',
                  text: "Already Have an account",
                  navigation: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
