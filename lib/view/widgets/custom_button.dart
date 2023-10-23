import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback press;
  const ButtonWidget({super.key, required this.buttonText,required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.yellow,width: 2)
          ),
          child: Center(
              child: Text(
            buttonText,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          )),
        ),
      ),
    );
  }
}
