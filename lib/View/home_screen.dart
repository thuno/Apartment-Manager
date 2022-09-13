import 'package:flutter/material.dart';
import 'package:project1/View/bill_detail_screen.dart';
import 'package:project1/View/bill_history_screen.dart';
import 'package:project1/View/contact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: double.infinity,
      color: const Color(0xFFF2F5F8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('lib/Assets/Home screen.png'),
                Positioned(
                  left: 16,
                  top: 32,
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
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 84,
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Image.asset('lib/Assets/Approval.png'),
                        ),
                        const Text(
                          'Họp đồng thuê phòng',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 22 / 14,
                            color: Color(0xFF262626),
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BillHistoryScreen(),
                          ));
                    },
                    child: SizedBox(
                      width: 84,
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Image.asset('lib/Assets/calendar.png'),
                          ),
                          const Text(
                            'Lịch sử tiền phòng',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              height: 22 / 14,
                              color: Color(0xFF262626),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContactScreen(),
                          ));
                    },
                    child: SizedBox(
                      width: 84,
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Image.asset('lib/Assets/chat.png'),
                          ),
                          const Text(
                            'Liên hệ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              height: 22 / 14,
                              color: Color(0xFF262626),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 84,
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Image.asset('lib/Assets/Silver.png'),
                        ),
                        const Text(
                          'Đổi mật khẩu',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 22 / 14,
                            color: Color(0xFF262626),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Hạn nộp 10/8/2022',
                        style: TextStyle(
                          fontSize: 12,
                          height: 16 / 12,
                          color: Color(0xFF6E87AA),
                        ),
                      ),
                      Text(
                        'Sắp hết hạn',
                        style: TextStyle(
                          fontSize: 12,
                          height: 16 / 12,
                          color: Color(0xFF6E87AA),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      'Tiền phòng tháng 8/2022',
                      style: TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1C2430),
                      ),
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Số tiền: ',
                          style: TextStyle(
                            fontSize: 14,
                            height: 22 / 14,
                            color: Color(0xFF4B6281),
                          ),
                        ),
                        TextSpan(
                          text: '6,850,000',
                          style: TextStyle(
                            fontSize: 20,
                            height: 28 / 20,
                            color: Color(0xFF2EB553),
                          ),
                        ),
                        TextSpan(
                          text: ' VNĐ',
                          style: TextStyle(
                            fontSize: 14,
                            height: 22 / 14,
                            color: Color(0xFF4B6281),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 28),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BillDetailsScreen(),
                            ));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Xem chi tiết',
                            style: TextStyle(
                              fontSize: 14,
                              height: 22 / 14,
                              color: Color(0xFF366AE2),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 4, top: 2),
                            child: const Icon(
                              Icons.chevron_right,
                              size: 16,
                              color: Color(0xFF366AE2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
