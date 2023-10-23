import 'package:buyer_vendor_app/provider/cart_subtotal_provider.dart';
import 'package:buyer_vendor_app/view/local%20functions/build_cart_details.dart';
import 'package:buyer_vendor_app/view/widgets/button_addtocart_buynow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Your Cart',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(),
            SizedBox(
              height: screenHeight * .7,
              child: buildCartDetails(context),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.black, width: 3))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Sub Total'),
                        Consumer<CartSubtotalProvider>(
                          builder: (context, value, child) {
                            return Text(
                              value.subtotal.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    BuyNowAndAddToCartButton(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      text: 'Order Now',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
