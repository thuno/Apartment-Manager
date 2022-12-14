import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Module/room_item.dart';
import 'guest_home_screen.dart';
import 'payment_screen.dart';

class GuestNavigationScreen extends StatefulWidget {
  final RoomItem? roomItem;
  const GuestNavigationScreen({super.key, this.roomItem});

  @override
  State<GuestNavigationScreen> createState() => _GuestNavigationScreenState();
}

class _GuestNavigationScreenState extends State<GuestNavigationScreen> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //set status bar ko màu và các icon có màu tối
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
      ),
      body: Builder(builder: (context) {
        switch (currentTab) {
          case 0:
            return GuestHomeScreen(roomItem: widget.roomItem);
          case 1:
            return const PaymentScreen();
          default:
            return const GuestHomeScreen();
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentTab = index;
            });
          },
          currentIndex: currentTab,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            height: 16 / 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            height: 16 / 12,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: const Color(0xFF366AE2),
          unselectedItemColor: const Color(0xFFBFBFBF),
          items: [
            BottomNavigationBarItem(
              icon: Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset(
                  'lib/Assets/home.svg',
                  color: currentTab == 0 ? const Color(0xFF366AE2) : const Color(0xFFBFBFBF),
                ),
              ),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset(
                  'lib/Assets/payment.svg',
                  color: currentTab == 1 ? const Color(0xFF366AE2) : const Color(0xFFBFBFBF),
                ),
              ),
              label: 'Thanh toán',
            ),
          ]),
    );
  }
}
