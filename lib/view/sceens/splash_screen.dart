import 'package:buyer_vendor_app/utils/constants/icons.dart';
import 'package:buyer_vendor_app/view/sceens/login_screen.dart';
import 'package:buyer_vendor_app/view/sceens/main_sceen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  void _checkAuthentication() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isAuthenticated = prefs.getBool('isAuthenticated') ?? false;

    await Future.delayed(const Duration(milliseconds: 3000));

    if (isAuthenticated) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainScreen(),
      ));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SvgPicture.asset(
              shopIcon,
              width: 50,
              height: 50,
              colorFilter: ColorFilter.mode(
                Colors.yellow,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
