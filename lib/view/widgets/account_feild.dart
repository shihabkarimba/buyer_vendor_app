import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants/icons.dart';

dynamic AccountFeilds({
  required String leadingIcon,
  required feildText,
  required VoidCallback onArrowPressed,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 50,
      vertical: 10,
    ),
    child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    leadingIcon,
                    width: 15,
                    height: 15,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(feildText),
            ],
          ),
          InkWell(
            onTap: onArrowPressed,
            child: SvgPicture.asset(
              forwardIcon,
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
    ),
  );
}
