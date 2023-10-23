import 'package:buyer_vendor_app/utils/constants/icons.dart';
import 'package:buyer_vendor_app/view/local%20functions/build_category_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../provider/screen_change_provider.dart';
import '../../provider/selected_index_provider.dart';
import '../sceens/shop_sceen.dart';

class CategoryLabelWidget extends StatelessWidget {
  CategoryLabelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Category',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: buildCategoryLabels() ?? SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: InkWell(
                    onTap: () {
                      Provider.of<SelectedIndexProvider>(context, listen: false)
                        .changeSelectedIndex(2);
                    Provider.of<ChangeScreenProvider>(context, listen: false)
                        .changeScreen(const ShopScreen());
                    },
                    child: InkWell(
                      child: SvgPicture.asset(
                        forwardIcon,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
