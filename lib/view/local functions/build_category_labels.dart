import 'package:buyer_vendor_app/view/sceens/category_items_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/screen_change_provider.dart';
import '../../provider/selected_index_provider.dart';
import '../widgets/loading_animation.dart';

buildCategoryLabels() {
   final scrollController = ScrollController();
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('categories').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting ||
          !snapshot.hasData) {
        return Center(
          child: LoadingAnimation(
            height: 20,
            width: 20,
          ),
        );
      }

      if (snapshot.hasError || !snapshot.hasData) {
        return SizedBox(); 
      }

      final categories = snapshot.data!.docs;

      return ListView.separated(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index].data() as Map<String, dynamic>;
          return ActionChip(
            label: Text(
              category['category name'] ?? 'Error',
            ),
            labelStyle: const TextStyle(color: Colors.white),
            backgroundColor: Colors.black,
            onPressed: () {
               Provider.of<SelectedIndexProvider>(context, listen: false)
                        .changeSelectedIndex(2);
                    Provider.of<ChangeScreenProvider>(context, listen: false)
                        .changeScreen(CategoryItemScreen(categoryName: category['category name'],));
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
      );
    },
  );
}
