import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyNowAndAddToCartButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const BuyNowAndAddToCartButton({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.text,
    required this.onTap,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: screenWidth * .42,
        height: screenHeight * .07,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 5.0,
                offset: Offset(0.0, 3.0)),
          ],
        ),
        child: Center(
          child: Text(text,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              )),
        ),
      ),
    );
  }
}
