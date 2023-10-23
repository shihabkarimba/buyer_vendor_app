import 'package:buyer_vendor_app/cloud%20functions/check_wishlist.dart';
import 'package:buyer_vendor_app/provider/screen_change_provider.dart';
import 'package:buyer_vendor_app/utils/constants/animation.dart';
import 'package:buyer_vendor_app/view/sceens/product_details_screen.dart';
import 'package:buyer_vendor_app/view/widgets/like_button.dart';
import 'package:buyer_vendor_app/view/widgets/loading_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

Widget builsWishListDetails(BuildContext context) {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference wishListCollection = _firestore
      .collection('wishList')
      .doc(_auth.currentUser!.uid)
      .collection('items');
  return StreamBuilder<QuerySnapshot>(
    stream: wishListCollection.snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final wishListItems = snapshot.data!.docs;

        if (wishListItems.isEmpty) {
          return Center(
            child:
                Lottie.asset(wishListEmptyAnimation, width: 200, height: 200),
          );
        }
        return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 2.0,
          mainAxisExtent: 260,
        ),
        itemCount: wishListItems.length,
        itemBuilder: (BuildContext context, int index) {
          final wishListItem =
              wishListItems[index].data() as Map<String, dynamic>;

          return Stack(
            children: [
              InkWell(
                onTap: () {
                  Provider.of<ChangeScreenProvider>(context, listen: false)
                      .changeScreen(
                    ProductDetailsScreen(
                      categoryName: wishListItem['categoryName'],
                      productImage: wishListItem['image'],
                      productDescription: wishListItem['description'],
                      productName: wishListItem['productName'],
                      productPrice: wishListItem['price'],
                      productUnit: wishListItem['productUnit'],
                      navigationNumber: 4,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(255, 255, 230, 0), width: 2),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 12,
                          color: Color.fromRGBO(0, 0, 0, 0.16),
                        ),
                      ]),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: 170,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          child: CachedNetworkImage(
                            imageUrl: wishListItem['image'],
                            width: double.infinity,
                            // height: 150,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                                child: LoadingAnimation(
                              width: 40,
                              height: 40,
                            )),
                            errorWidget: (context, url, error) => Center(
                                child: Text(
                              'Error finding data',
                              style: TextStyle(fontSize: 12),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        wishListItem['productName'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'From Rs',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '₹${double.parse(wishListItem['price'])}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                    top: 0,
                    right: 0,
                    child: FutureBuilder<dynamic>(
                      future: isProductInWishlist(wishListItem['productName']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SizedBox(); // You can use a loading indicator here.
                        }
                  
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                  
                        final checkWishlistNumber = snapshot.data;
                  
                        return CustomLikeButton(
                          categoryName: wishListItem['categoryName'],
                          productDescription: wishListItem['description'],
                          productName: wishListItem['productName'],
                          price: wishListItem['price'],
                          imageSrc: wishListItem['image'],
                          productUnit: wishListItem['productUnit'],
                          context: context,
                          isInWishlist: checkWishlistNumber == 0 ? false : true,
                        );
                      },
                    ),
                  ),
            ],
          );
        },
      );
      } else if (snapshot.hasError) {
        return Center(
          child: Lottie.asset(wishListEmptyAnimation, width: 200, height: 200),
        );
      } else {
        return Center(
          child: LoadingAnimation(),
        );
      }
    },
  );
}
