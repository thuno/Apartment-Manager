import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project1/View/room_infor_screen.dart';

class MangeHouse extends StatefulWidget {
  const MangeHouse({super.key});

  @override
  State<MangeHouse> createState() => _MangeHouseState();
}

class _MangeHouseState extends State<MangeHouse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 48,
        backgroundColor: Colors.white,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
        centerTitle: true,
        title: const Text(
          'Quản lý nhà',
          style: TextStyle(
            fontSize: 16,
            height: 24 / 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF262626),
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFF2F5F8),
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('lib/Assets/Image demo.png'),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Phòng 101',
                              style: TextStyle(
                                fontSize: 16,
                                height: 24 / 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF262626),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              child: const Text(
                                'Bắt đầu thuê từ: 20/01/2020',
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 22 / 14,
                                  color: Color(0xFF8C8C8C),
                                ),
                              ),
                            ),
                          ],
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
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        SvgPicture.asset('lib/Assets/user-multiple.svg'),
                        Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: const Text(
                            'Số người: 3',
                            style: TextStyle(
                              fontSize: 14,
                              height: 22 / 14,
                              color: Color(0xFF262626),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        SvgPicture.asset('lib/Assets/deposit.svg'),
                        Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: const Text(
                            'Tiền cọc: 3,000,000 VNĐ',
                            style: TextStyle(
                              fontSize: 14,
                              height: 22 / 14,
                              color: Color(0xFF262626),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RoomInfor()));
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFE6F7FF),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        'Xem chi tiết',
                        style: TextStyle(
                          fontSize: 14,
                          height: 22 / 14,
                          color: Color(0xFF1890FF),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
        ),
      ),
    );
  }
}
