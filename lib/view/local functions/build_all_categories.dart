import 'package:buyer_vendor_app/view/sceens/category_items_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/screen_change_provider.dart';
import '../widgets/loading_animation.dart';

Widget buildAllCategoryGrid() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('categories').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
            child: LoadingAnimation(
          height: 50,
          width: 50,
        ));
      }

      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }

      final categories = snapshot.data!.docs;

      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          mainAxisExtent: 200,
        ),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index].data() as Map<String, dynamic>;
          return InkWell(
            onTap: () {
               Provider.of<ChangeScreenProvider>(context, listen: false)
                        .changeScreen(CategoryItemScreen(categoryName: category['category name'],));
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(255, 255, 230, 0),
                          width: 2),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 12,
                          color: Color.fromRGBO(0, 0, 0, 0.16),
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl: category['image'],
                          width: double.infinity,
                          height: 150,
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
                      SizedBox(height: 10.0),
                      Text(
                        category['category name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
