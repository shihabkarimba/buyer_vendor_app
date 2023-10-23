import 'package:buyer_vendor_app/cloud%20functions/check_wishlist.dart';
import 'package:buyer_vendor_app/view/widgets/like_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/screen_change_provider.dart';
import '../sceens/product_details_screen.dart';
import '../widgets/loading_animation.dart';


buildOfferGrid() {
  return StreamBuilder<QuerySnapshot>(
    stream:
        FirebaseFirestore.instance.collection('all category item').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: LoadingAnimation(
            height: 50,
            width: 50,
          ),
        );
      }

      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }

      final categoryItems = snapshot.data!.docs;

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
        itemCount: categoryItems.length,
        itemBuilder: (BuildContext context, int index) {
          final categoryItem =
              categoryItems[index].data() as Map<String, dynamic>;

          return InkWell(
            onTap: () {
              Provider.of<ChangeScreenProvider>(context, listen: false)
                  .changeScreen(
                ProductDetailsScreen(
                  categoryName: categoryItem['category name'],
                  productImage: categoryItem['image'],
                  productDescription: categoryItem['product description'],
                  productName: categoryItem['product name'],
                  productPrice: categoryItem['product price'],
                  productUnit: categoryItem['unit'],
                  navigationNumber: 1,
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
              child: Stack(
                children: [
                  Column(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: 170,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          child: CachedNetworkImage(
                            imageUrl: categoryItem['image'],
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
                        categoryItem['product name'],
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
                            'From',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '₹${double.parse(categoryItem['product price'])}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  // Inside your GridView.builder
                  Positioned(
                    top: 0,
                    right: 0,
                    child: FutureBuilder<dynamic>(
                      future: isProductInWishlist(categoryItem['product name']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SizedBox(); // You can use a loading indicator here.
                        }
                  
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                  
                        final checkWishlistNumber = snapshot.data;
                  
                        return CustomLikeButton(
                          categoryName: categoryItem['category name'],
                          productDescription: categoryItem['product description'],
                          productName: categoryItem['product name'],
                          price: categoryItem['product price'],
                          imageSrc: categoryItem['image'],
                          productUnit: categoryItem['unit'],
                          context: context,
                          isInWishlist: checkWishlistNumber == 0 ? false : true,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
