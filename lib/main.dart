import 'package:buyer_vendor_app/firebase_options.dart';
import 'package:buyer_vendor_app/provider/banner_images_provider.dart';
import 'package:buyer_vendor_app/provider/banner_index_provider.dart';
import 'package:buyer_vendor_app/provider/cart_subtotal_provider.dart';
import 'package:buyer_vendor_app/provider/is_registering_provider.dart';
import 'package:buyer_vendor_app/provider/product_add_unit_provider.dart';
import 'package:buyer_vendor_app/provider/screen_change_provider.dart';
import 'package:buyer_vendor_app/provider/selected_index_provider.dart';
import 'package:buyer_vendor_app/provider/user_profile_provider.dart';
import 'package:buyer_vendor_app/utils/theme/material_color.dart';
import 'package:buyer_vendor_app/view/sceens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedIndexProvider()),
        ChangeNotifierProvider(create: (_) => ChangeScreenProvider()),
        ChangeNotifierProvider(create: (_) => BannerImagesProvider()),
        ChangeNotifierProvider(create: (_) => BannerIndexProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
        ChangeNotifierProvider(create: (_) => ProductAddUnitProvider()),
        ChangeNotifierProvider(create: (_) => CartSubtotalProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: customBlack,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
