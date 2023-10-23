import 'package:buyer_vendor_app/cloud%20functions/deactivate_account.dart';
import 'package:buyer_vendor_app/cloud%20functions/get_user_profile_image.dart';
import 'package:buyer_vendor_app/provider/user_profile_provider.dart';
import 'package:buyer_vendor_app/utils/constants/icons.dart';
import 'package:buyer_vendor_app/utils/constants/images.dart';
import 'package:buyer_vendor_app/view/local%20functions/profile_image_picker.dart';
import 'package:buyer_vendor_app/view/sceens/login_screen.dart';
import 'package:buyer_vendor_app/view/sceens/terms_screen.dart';
import 'package:buyer_vendor_app/view/sceens/wishlist_screen.dart';
import 'package:buyer_vendor_app/view/widgets/loading_animation.dart';
import 'package:buyer_vendor_app/view/widgets/profile_edit_button.dart';
import 'package:buyer_vendor_app/view/widgets/warning_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../provider/screen_change_provider.dart';
import '../widgets/account_feild.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    getUserProfielImage(userId!, context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Stack(
        children: [
          Container(
            width: screenWidth,
            height: 380,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Consumer<UserProfileProvider>(
                        builder: (context, userProfileProvider, child) {
                          final imageUrl = userProfileProvider.profileImageUrl;
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      userProfileProvider.profileImageUrl !=
                                              null
                                          ? NetworkImage(imageUrl!)
                                          : AssetImage(userDefaultImage)
                                              as ImageProvider),
                              if (userProfileProvider
                                  .isImageUploading) // Show loading indicator
                                LoadingAnimation(
                                  width: 30,
                                  height: 30,
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    ProfileEditButton(
                      onEditPressed: () {
                        pickProfileImage(context);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  FirebaseAuth.instance.currentUser?.email ?? '',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 380,
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  AccountFeilds(
                    leadingIcon: cartIcon,
                    feildText: 'My Orders',
                    onArrowPressed: () {},
                  ),
                  Divider(),
                  AccountFeilds(
                    leadingIcon: likeIcon,
                    feildText: 'My Wishlist',
                    onArrowPressed: () {
                      Provider.of<ChangeScreenProvider>(context, listen: false)
                          .changeScreen(const WishListScreen());
                    },
                  ),
                  Divider(thickness: 7,color: Colors.grey.shade200,),
                  AccountFeilds(
                    leadingIcon: termsIcon,
                    feildText: 'Term And Conditions',
                    onArrowPressed: () {
                      Provider.of<ChangeScreenProvider>(context, listen: false)
                          .changeScreen(const TermsAndConditionScreen());
                    },
                  ),
                  Divider(),
                  AccountFeilds(
                    leadingIcon: deactivateIcon,
                    feildText: 'Deactivate',
                    onArrowPressed: () {
                      warningDialog(
                        context: context,
                        content:
                            'Are you sure you want to deactivate your accout, It will erase all your data!',
                        onYesPressed: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('isAuthenticated', false);

                          await deleteAccount(context);

                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            ModalRoute.withName('/'),
                          );
                        },
                      );
                    },
                  ),
                  Divider(),
                  AccountFeilds(
                    leadingIcon: logOutIcon,
                    feildText: 'Log Out',
                    onArrowPressed: () {
                      warningDialog(
                        context: context,
                        content:
                            'Are you sure you want to sign out from the app',
                        onYesPressed: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('isAuthenticated', false);
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            ModalRoute.withName('/'),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
