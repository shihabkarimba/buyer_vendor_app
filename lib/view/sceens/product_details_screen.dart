import 'package:buyer_vendor_app/cloud%20functions/add_to_cart.dart';
import 'package:buyer_vendor_app/cloud%20functions/check_wishlist.dart';
import 'package:buyer_vendor_app/utils/constants/icons.dart';
import 'package:buyer_vendor_app/view/sceens/category_items_screen.dart';
import 'package:buyer_vendor_app/view/sceens/home_sceen.dart';
import 'package:buyer_vendor_app/view/sceens/search_sceen.dart';
import 'package:buyer_vendor_app/view/sceens/wishlist_screen.dart';
import 'package:buyer_vendor_app/view/widgets/like_button.dart';
import 'package:buyer_vendor_app/view/widgets/skeleton_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../provider/product_add_unit_provider.dart';
import '../../provider/screen_change_provider.dart';
import '../widgets/button_addtocart_buynow.dart';
import '../widgets/cart_buttons.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String categoryName;
  final String productImage;
  final String productName;
  final String productDescription;
  final String productPrice;
  final String productUnit;
  final int navigationNumber;

  ProductDetailsScreen({
    Key? key,
    required this.productImage,
    required this.productDescription,
    required this.productName,
    required this.categoryName,
    required this.productPrice,
    required this.productUnit,
    required this.navigationNumber,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Stack(
        children: [
          SizedBox(
            height: screenHeight * .5,
            width: screenWidth,
            child: CachedNetworkImage(
              imageUrl: productImage,
              fit: BoxFit.cover,
              placeholder: (context, url) => BannerSkeletonWidget(),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Consumer<ProductAddUnitProvider>(
              builder: (context, provider, _) {
                return Container(
                  height: screenHeight * .50,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colors.yellow, Colors.white],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          productName,
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(height: 10),
                        Text(
                          productDescription,
                          textDirection: TextDirection.rtl,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '₹${double.parse(productPrice)}',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: ' Per $productUnit',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Divider(thickness: 1),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CartButton(
                                icon: minusIcon,
                                onTap: () {
                                  provider.decrementCount();
                                },
                              ),
                              SizedBox(width: 10),
                              Text(
                                '${provider.currentCount} $productUnit',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(width: 10),
                              CartButton(
                                icon: plusIcon,
                                onTap: () {
                                  provider.incrementCount();
                                },
                              ),
                            ],
                          ),
                        ),
                        Divider(thickness: 1),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BuyNowAndAddToCartButton(
                                onTap: () async {
                                  await addToCart(
                                    productName: productName,
                                    price: double.parse(productPrice),
                                    quantity: provider.currentCount,
                                    imageSrc: productImage,
                                    context: context,
                                    productUnit: productUnit,
                                  );
                                  
                                },
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                                text: 'Add To Cart',
                              ),
                              BuyNowAndAddToCartButton(
                                onTap: () {},
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                                text: 'Buy Now',
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: InkWell(
              onTap: () {
                if (navigationNumber == 1) {
                  Provider.of<ChangeScreenProvider>(context, listen: false)
                      .changeScreen(const HomeScreen());
                } else if (navigationNumber == 2) {
                  Provider.of<ChangeScreenProvider>(context, listen: false)
                      .changeScreen(CategoryItemScreen(
                    categoryName: categoryName,
                  ));
                }else if(navigationNumber == 3){
                   Provider.of<ChangeScreenProvider>(context, listen: false)
                      .changeScreen(const SearchScreen());
                }else if(navigationNumber == 4){
                  Provider.of<ChangeScreenProvider>(context, listen: false)
                      .changeScreen(const WishListScreen());
                }
              },
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    backArrowIcon,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
                    top: 10,
                    right: 0,
                    child: FutureBuilder<dynamic>(
                      future: isProductInWishlist(productName),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SizedBox(); // You can use a loading indicator here.
                        }
                  
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                  
                        final checkWishlistNumber = snapshot.data;
                  
                        return CustomLikeButton(
                          productDescription: productDescription,
                          categoryName: categoryName,
                          productName: productName,
                          price: productPrice,
                          imageSrc: productImage,
                          productUnit: productUnit,
                          context: context,
                          isInWishlist: checkWishlistNumber == 0 ? false : true,
                          size: 70,
                        );
                      },
                    ),
                  ),
        ],
      ),
    );
  }
}