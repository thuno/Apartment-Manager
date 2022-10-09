import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project1/View/list_income_screen.dart';
import 'package:project1/View/list_message_screen.dart';
import 'package:project1/View/owner_home_screen.dart';

class OwnerNavigationScreen extends StatefulWidget {
  const OwnerNavigationScreen({super.key});

  @override
  State<OwnerNavigationScreen> createState() => _OwnerNavigationScreenState();
}

class _OwnerNavigationScreenState extends State<OwnerNavigationScreen> {
  // tab mặc định khi nhảy vào màn hình navigate
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Builder(builder: (context) {
            switch (currentTab) {
              case 0:
                return const OwnerHomeScreen();
              case 1:
                return const ListIncomeScreen();
              case 2:
                return const ListMessage();
              default:
                return const OwnerHomeScreen();
            }
          }),
        ),
        SizedBox(
          height: 64,
          child: BottomNavigationBar(
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
              onTap: (index) {
                setState(() {
                  currentTab = index;
                });
              },
              currentIndex: currentTab,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(
                      'lib/Assets/home.svg',
                      color: currentTab == 0 ? const Color(0xFF366AE2) : const Color(0xFFBFBFBF),
                    ),
                  ),
                  label: 'Trang chủ',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(
                      'lib/Assets/coins.svg',
                      color: currentTab == 1 ? const Color(0xFF366AE2) : const Color(0xFFBFBFBF),
                    ),
                  ),
                  label: 'Doanh thu',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(
                      'lib/Assets/chat.svg',
                      color: currentTab == 2 ? const Color(0xFF366AE2) : const Color(0xFFBFBFBF),
                    ),
                  ),
                  label: 'Liên hệ',
                ),
              ]),
        ),
      ],
    );
  }
}
