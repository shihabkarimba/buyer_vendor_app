import 'package:buyer_vendor_app/view/widgets/banner_widget.dart';
import 'package:buyer_vendor_app/view/widgets/category_lablel_widget.dart';
import 'package:buyer_vendor_app/view/widgets/offer_section.dart';
import 'package:buyer_vendor_app/view/widgets/welcome_text.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            WelcomeWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(height: 30,color: Colors.black,),
            ),
            BannerWidget(
              context: context,
            ),
            SizedBox(height: 20),
            CategoryLabelWidget(),
            SizedBox(height: 20),
            OfferSection(),
          ],
        ),
      ),
    );
  }
}
