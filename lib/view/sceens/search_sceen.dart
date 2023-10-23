import 'package:buyer_vendor_app/utils/constants/animation.dart';
import 'package:buyer_vendor_app/view/sceens/product_details_screen.dart';
import 'package:buyer_vendor_app/view/widgets/search_input_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../provider/screen_change_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredProducts = []; // Store filtered products

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void searchProducts(String query) async {
    final categoryRef =
        FirebaseFirestore.instance.collection('all category item');
    final categoryItemsSnapshot = await categoryRef.get();

    setState(() {
      filteredProducts = categoryItemsSnapshot.docs
          .where((product) => product['product name']
              .toLowerCase()
              .contains(query.toLowerCase()))
          .map((product) => product.data())
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SearchInputWidget(
              onSearch: searchProducts,
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Lottie.asset(searchingAnimation),
                  )
                : ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final product = filteredProducts[index];

                      return Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Provider.of<ChangeScreenProvider>(context,
                                          listen: false)
                                      .changeScreen(
                                    ProductDetailsScreen(
                                      categoryName:
                                          product['category name'],
                                      productImage: product['image'],
                                      productDescription:
                                          product['product description'],
                                      productName: product['product name'],
                                      productPrice:
                                          product['product price'],
                                      productUnit: product['unit'],
                                      navigationNumber: 3,
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.yellow.shade100,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(2, 2),
                                        blurRadius: 12,
                                        color: Color.fromRGBO(0, 0, 0, 0.16),
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        height: 200,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: product['image'],
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) {
                                              return SizedBox();
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 40),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product['product name'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Current Offer',
                                          ),
                                          Text(
                                            '${double.parse(product['product price'])}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
