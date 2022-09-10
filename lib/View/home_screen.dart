import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 360,
        backgroundColor: Colors.transparent,
        flexibleSpace: Stack(
          children: [
            Container(
              child: SvgPicture.asset('lib/Assets/Home screen.svg'),
            ),
            Positioned(
              left: 16,
              top: 48,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        'Xin chào',
                        style: TextStyle(fontSize: 20, height: 28 / 20, color: Color(0xFF262626)),
                      ),
                      Container(height: 4),
                      const Text(
                        'Phòng 101',
                        style: TextStyle(fontSize: 12, height: 16 / 12, color: Color(0xFF262626)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
