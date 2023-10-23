import 'package:buyer_vendor_app/utils/constants/icons.dart';
import 'package:buyer_vendor_app/view/local%20functions/build_category_items.dart';
import 'package:buyer_vendor_app/view/sceens/shop_sceen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../provider/screen_change_provider.dart';

class CategoryItemScreen extends StatelessWidget {
  final String categoryName;
  const CategoryItemScreen({
    super.key,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                Provider.of<ChangeScreenProvider>(context, listen: false)
                        .changeScreen(const ShopScreen());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SvgPicture.asset(backArrowIcon,width: 20,height: 20,),
              ),
            ),
            Text(
              '$categoryName Items',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            Expanded(child: buildCategoryItems(categoryName)),
          ],
        ),
      ),
    );
  }
}
