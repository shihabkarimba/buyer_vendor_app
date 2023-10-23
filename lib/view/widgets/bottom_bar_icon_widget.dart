import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../provider/selected_index_provider.dart';

class BottomBarIconWidget extends StatelessWidget {
  final int selectedIndexCount;
  final String icon;
  final VoidCallback onTap;

  const BottomBarIconWidget({
    Key? key,
    required this.selectedIndexCount,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Consumer<SelectedIndexProvider>(
        builder: (context, provider, _) {
          return SvgPicture.asset(
            icon,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(
              provider.selectedIndex == selectedIndexCount
                  ? Colors.yellow
                  : Colors.white,
              BlendMode.srcIn,
            ),
          );
        },
      ),
    );
  }
}