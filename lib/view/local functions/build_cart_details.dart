import 'package:buyer_vendor_app/utils/constants/animation.dart';
import 'package:buyer_vendor_app/view/widgets/loading_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../provider/cart_subtotal_provider.dart';
import '../../utils/constants/icons.dart';
import '../widgets/cart_buttons.dart';

Widget buildCartDetails(BuildContext context) {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference cartCollection = _firestore
      .collection('cart')
      .doc(_auth.currentUser!.uid)
      .collection('items');
  return StreamBuilder<QuerySnapshot>(
    stream: cartCollection.snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final cartItems = snapshot.data!.docs;

        if (cartItems.isEmpty) {
          Future.delayed(Duration.zero,(){
               calculateSubtotal([], context);
          });
          return Center(
            child: Lottie.asset(cartEmptyAnimation, width: 300, height: 300),
          );
        }

        Future.delayed(Duration.zero, () {
          calculateSubtotal(cartItems, context);
        });

        return ListView.separated(
          itemCount: cartItems.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            final cartItem = cartItems[index].data() as Map<String, dynamic>;
            final productName = cartItem['productName'];
            final price = cartItem['price'];
            int quantity = cartItem['quantity'];
            final imageSrc = cartItem['image'];
            final productUnit = cartItem['productUnit'];
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5.0,
                        offset: Offset(0.0, 3.0),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 130,
                        height: 100,
                        child: CachedNetworkImage(
                          imageUrl: imageSrc,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => LoadingAnimation(),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(productName),
                          Text(
                            '₹$price',
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CartButton(
                                icon: minusIcon,
                                onTap: () async {
                                  if (quantity > 1) {
                                    quantity--;
                                    // Update the quantity in Firestore
                                    await cartCollection
                                        .doc(cartItems[index].id)
                                        .update({
                                      'quantity': quantity,
                                    });
                                  }
                                },
                              ),
                              SizedBox(width: 10),
                              Text('$quantity$productUnit'),
                              SizedBox(width: 10),
                              CartButton(
                                icon: plusIcon,
                                onTap: () async {
                                  quantity++;
                                  await cartCollection
                                      .doc(cartItems[index].id)
                                      .update({
                                    'quantity': quantity,
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Total amount\n${quantity * price}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    DocumentReference cartItemRef =
                        cartCollection.doc(cartItems[index].id);
                    await cartItemRef.delete();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      deleteIcon,
                      colorFilter: ColorFilter.mode(
                          Colors.grey.shade800, BlendMode.srcIn),
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      } else if (snapshot.hasError) {
        return Center(
          child: Text('Error fetching cart items'),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

void calculateSubtotal(
  List<QueryDocumentSnapshot> cartItems,
  BuildContext context,
) {
  double subtotal = 0;
  cartItems.forEach((cartItem) {
    final item = cartItem.data() as Map<String, dynamic>;
    final price = item['price'];
    final quantity = item['quantity'];
    subtotal += price * quantity;
  });
  Provider.of<CartSubtotalProvider>(context, listen: false)
      .updateSubtotal(subtotal);
}
