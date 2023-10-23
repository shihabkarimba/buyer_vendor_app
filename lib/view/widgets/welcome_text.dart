import 'package:buyer_vendor_app/view/widgets/loading_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../provider/screen_change_provider.dart';
import '../../provider/selected_index_provider.dart';
import '../../utils/constants/icons.dart';
import '../sceens/cart_sceen.dart';

class WelcomeWidget extends StatelessWidget {
  WelcomeWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference cartCollection = _firestore
        .collection('cart')
        .doc(_auth.currentUser!.uid)
        .collection('items');

    final Stream<QuerySnapshot<Map<String, dynamic>>> cartStream =
        cartCollection.snapshots()
            as Stream<QuerySnapshot<Map<String, dynamic>>>;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: cartStream,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          final cartItems = snapshot.data!.docs;
          final screenwidth = MediaQuery.of(context).size.width;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: screenwidth * .08),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Howdy, What Are you\nLooking For 👀',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<SelectedIndexProvider>(context, listen: false)
                        .changeSelectedIndex(3);
                    Provider.of<ChangeScreenProvider>(context, listen: false)
                        .changeScreen(CartScreen());
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          cartIcon,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      if (cartItems.length != 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.yellow,
                            child: Text(cartItems.length.toString()),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return LoadingAnimation();
        }
      },
    );
  }
}
