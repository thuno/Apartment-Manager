import 'package:flutter/material.dart';
import 'package:project1/Module/room_item.dart';
import 'package:project1/Module/user_item.dart';
import 'package:project1/View/guest_navigation_screen.dart';
import 'package:project1/View/login_screen.dart';
import 'package:project1/View/owner_navigation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isLogin = false;

  Future<String?> getstoreData() async {
    SharedPreferences store = await _prefs;
    DateTime? lastLogin = DateTime.tryParse(store.getString('timer') ?? '');
    if (lastLogin != null) {
      if (DateTime.now().difference(lastLogin).inHours <= 24) {
        String userId = store.getString('userID')!;
        return userId;
      }
    }
    return null;
  }

  @override
  void initState() {
    getstoreData().then((value) async {
      if (value == null) {
        return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else if (value == 'Admin') {
        await RoomDA.getListRoom();
        await UserDA.getListAccount();
        // ignore: use_build_context_synchronously
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const OwnerNavigationScreen()));
      } else {
        await RoomDA.getRoomAccount(value);
        // ignore: use_build_context_synchronously
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const GuestNavigationScreen()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'lib/Assets/Splash screen.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
      ),
    );
  }
}
