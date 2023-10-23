import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final bool obscureText;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.icon,
    required this.obscureText,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: TextFormField(
        validator: validator,
        obscureText: obscureText,
        style: TextStyle(color: Colors.black),
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black,width: 2)
          ),
          filled: true,
          fillColor: Colors.yellow,
          hintText: hintText,
          prefixIcon: Icon(icon, color: Color.fromARGB(188, 0, 0, 0)),
          hintStyle: TextStyle(
            color: Color.fromARGB(133, 20, 20, 20),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
        ),
      ),
    );
  }
}
