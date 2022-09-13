import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BillDetailsScreen extends StatefulWidget {
  const BillDetailsScreen({super.key});

  @override
  State<BillDetailsScreen> createState() => _BillDetailsScreenState();
}

class _BillDetailsScreenState extends State<BillDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 86,
        backgroundColor: Colors.transparent,
        leading: Container(
          height: double.infinity,
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 16),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.chevron_left,
              size: 24,
              color: Color(0xFF4B6281),
            ),
          ),
        ),
        centerTitle: true,
        title: Column(
          children: [
            const Text(
              'Chi tiết tiền phòng tháng 8',
              style: TextStyle(
                fontSize: 16,
                height: 24 / 16,
                color: Color(0xFF1C2430),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: const Text(
                'Tính đến ngày 31/8/2022',
                style: TextStyle(
                  fontSize: 14,
                  height: 22 / 14,
                  color: Color(0xFF4B6281),
                ),
              ),
            )
          ],
        ),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFEDF2FD),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.only(right: 12),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF366AE2),
                  ),
                  child: SvgPicture.asset('lib/Assets/c-info.svg'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ngày nộp tiền 10/09/2022',
                      style: TextStyle(
                        fontSize: 12,
                        height: 16 / 12,
                        color: Color(0xFF4D7AE5),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: const Text(
                        'Sắp hết hạn',
                        style: TextStyle(
                          fontSize: 16,
                          height: 24 / 16,
                          color: Color(0xFF366AE2),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 28),
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chi tiết tiền phòng',
                  style: TextStyle(
                    fontSize: 16,
                    height: 24 / 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1890FF),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Tiền phòng',
                        style: TextStyle(
                          fontSize: 14,
                          height: 22 / 14,
                          color: Color(0xFF6E87AA),
                        ),
                      ),
                      Text(
                        '6,000,000',
                        style: TextStyle(
                          fontSize: 14,
                          height: 22 / 14,
                          color: Color(0xFF394960),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Tiền điện',
                      style: TextStyle(
                        fontSize: 14,
                        height: 22 / 14,
                        color: Color(0xFF6E87AA),
                      ),
                    ),
                    Text(
                      '650,000',
                      style: TextStyle(
                        fontSize: 14,
                        height: 22 / 14,
                        color: Color(0xFF394960),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Tiền nước',
                        style: TextStyle(
                          fontSize: 14,
                          height: 22 / 14,
                          color: Color(0xFF6E87AA),
                        ),
                      ),
                      Text(
                        '100,000',
                        style: TextStyle(
                          fontSize: 14,
                          height: 22 / 14,
                          color: Color(0xFF394960),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Internet',
                      style: TextStyle(
                        fontSize: 14,
                        height: 22 / 14,
                        color: Color(0xFF6E87AA),
                      ),
                    ),
                    Text(
                      '100,000',
                      style: TextStyle(
                        fontSize: 14,
                        height: 22 / 14,
                        color: Color(0xFF394960),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Xe đạp điện (nếu có)',
                        style: TextStyle(
                          fontSize: 14,
                          height: 22 / 14,
                          color: Color(0xFF6E87AA),
                        ),
                      ),
                      Text(
                        '0',
                        style: TextStyle(
                          fontSize: 14,
                          height: 22 / 14,
                          color: Color(0xFF394960),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Tổng cộng',
                      style: TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF6E87AA),
                      ),
                    ),
                    Text(
                      '6,850,000',
                      style: TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF394960),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
        child: Container(
          height: 40,
          width: double.infinity,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF366AE2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Thanh toán',
            style: TextStyle(fontSize: 14, height: 22 / 14, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
