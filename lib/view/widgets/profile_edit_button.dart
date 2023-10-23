import 'package:buyer_vendor_app/utils/constants/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Positioned ProfileEditButton({
  required VoidCallback onEditPressed,
}) {
  return Positioned(
    right: 0,
    bottom: 5,
    child: InkWell(
      onTap: onEditPressed,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5.0,
                  offset: Offset(0.0, 3.0)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: SizedBox(
              child: SvgPicture.asset(
                editIcon,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
            ),
          )),
    ),
  );
}
