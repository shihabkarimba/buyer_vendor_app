import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../utils/constants/animation.dart';

class LoadingAnimation extends StatelessWidget {
  final double? width;
  final double? height;
  const LoadingAnimation({super.key,this.height,this.width});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      laodingAnimation,
      width: width ?? 20,
      height: height ?? 20,
    );
  }
}