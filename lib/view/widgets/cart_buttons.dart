import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CartButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  const CartButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 230, 0),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5.0,
              offset: Offset(0.0, 3.0)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
            child: SvgPicture.asset(
          icon,
          width: 17,
          height: 17,
          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        )),
      ),
    );
  }
}
