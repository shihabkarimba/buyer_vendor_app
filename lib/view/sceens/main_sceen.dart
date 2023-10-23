import 'package:buyer_vendor_app/view/sceens/account_sceen.dart';
import 'package:buyer_vendor_app/view/sceens/cart_sceen.dart';
import 'package:buyer_vendor_app/view/sceens/home_sceen.dart';
import 'package:buyer_vendor_app/view/sceens/search_sceen.dart';
import 'package:buyer_vendor_app/view/sceens/shop_sceen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/screen_change_provider.dart';
import '../../provider/selected_index_provider.dart';
import '../../utils/constants/icons.dart';
import '../widgets/bottom_bar_icon_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
          child: Container(
            height: screenHeight * .08,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomBarIconWidget(
                  selectedIndexCount: 1,
                  icon: homeIcon,
                  onTap: () {
                    Provider.of<SelectedIndexProvider>(context, listen: false)
                        .changeSelectedIndex(1);
                    Provider.of<ChangeScreenProvider>(context, listen: false)
                        .changeScreen(const HomeScreen());
                  },
                ),
                BottomBarIconWidget(
                  selectedIndexCount: 2,
                  icon: shopIcon,
                  onTap: () {
                    Provider.of<SelectedIndexProvider>(context, listen: false)
                        .changeSelectedIndex(2);
                    Provider.of<ChangeScreenProvider>(context, listen: false)
                        .changeScreen(const ShopScreen());
                  },
                ),
                BottomBarIconWidget(
                  selectedIndexCount: 3,
                  icon: cartIcon,
                  onTap: () {
                    Provider.of<SelectedIndexProvider>(context, listen: false)
                        .changeSelectedIndex(3);
                    Provider.of<ChangeScreenProvider>(context, listen: false)
                        .changeScreen(const CartScreen());
                  },
                ),
                BottomBarIconWidget(
                  selectedIndexCount: 4,
                  icon: searchIcon,
                  onTap: () {
                    Provider.of<SelectedIndexProvider>(context, listen: false)
                        .changeSelectedIndex(4);
                    Provider.of<ChangeScreenProvider>(context, listen: false)
                        .changeScreen(const SearchScreen());
                  },
                ),
                BottomBarIconWidget(
                  selectedIndexCount: 5,
                  icon: userIcon,
                  onTap: () {
                    Provider.of<SelectedIndexProvider>(context, listen: false)
                        .changeSelectedIndex(5);
                    Provider.of<ChangeScreenProvider>(context, listen: false)
                        .changeScreen(const AccountScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Consumer<ChangeScreenProvider>(
        builder: (context, value, child) {
          return value.currentScreen;
        },
      ),
    );
  }
}
