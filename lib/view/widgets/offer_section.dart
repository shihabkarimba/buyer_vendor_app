import 'package:buyer_vendor_app/view/local%20functions/build_offer_grid.dart';
import 'package:flutter/material.dart';

class OfferSection extends StatelessWidget {
  const OfferSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'New Offers',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          buildOfferGrid()
        ],
      ),
    );
  }
}