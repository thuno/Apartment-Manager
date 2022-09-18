import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var listIncomeType = [
      {
        "money": '136.000.000',
        "title": 'Tổng doanh thu tháng 7',
        "percent": '100%',
      },
      {
        "money": '80.000.000',
        "title": 'Tiền phòng',
        "percent": '70%',
      },
      {
        "money": '30.000.000',
        "title": 'Tiền điện',
        "percent": '15%',
      },
      {
        "money": '10.000.000',
        "title": 'Tiền nước',
        "percent": '10%',
      },
      {
        "money": '8.000.000',
        "title": 'Phí dịch vụ khác',
        "percent": '7%',
      },
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        toolbarHeight: 320,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
        flexibleSpace: Stack(
          children: [
            Positioned(
              top: -20,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 290,
                width: double.infinity,
                child: Image.asset(
                  'lib/Assets/sun.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 252,
              left: 0,
              right: 0,
              child: Container(
                height: 40,
                width: double.infinity,
                color: const Color(0xFFF2F5F8),
              ),
            ),
            Positioned(
              top: 48,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
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
                            'Đoàn Đức',
                            style: TextStyle(
                                fontSize: 14, height: 22 / 14, fontWeight: FontWeight.w700, color: Colors.white),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            child: const Text(
                              'Xin chào',
                              style: TextStyle(fontSize: 14, height: 16 / 14, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: SvgPicture.asset(
                        'lib/Assets/bell-fill.svg',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              top: 124,
              right: 20,
              child: Oclock(),
            ),
            Positioned(
              top: 220,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 16),
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            SvgPicture.asset('lib/Assets/salary.svg'),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: const Text(
                                'Trạng thái thanh toán',
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 24 / 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF394960),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            SvgPicture.asset('lib/Assets/time.svg'),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: const Text(
                                'Cập nhật tiền phòng',
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 24 / 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF394960),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 180,
                  width: 180,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Transform.scale(
                        scale: 0.7,
                        child: const CircularProgressIndicator(
                          backgroundColor: Color(0xFFFAF1EE),
                          color: Color(0xFFF94033),
                          strokeWidth: 40,
                          value: 12 / 20,
                        ),
                      ),
                      const Center(
                        child: Text(
                          '12/20',
                          style: TextStyle(
                            fontSize: 22,
                            height: 28 / 22,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF262626),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  child: const Text(
                    'Số phòng đã hoàn thành thanh toán',
                    style: TextStyle(
                      fontSize: 16,
                      height: 24 / 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF262626),
                    ),
                  ),
                ),
                const Text(
                  'Tính đến ngày 07/08/2022',
                  style: TextStyle(
                    fontSize: 14,
                    height: 22 / 14,
                    color: Color(0xFF595959),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                for (var element in listIncomeType)
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF40A9FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SvgPicture.asset(
                            'lib/Assets/coins.svg',
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                element['money']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 22 / 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF262626),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                child: Text(
                                  element['title']!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    height: 16 / 12,
                                    color: Color(0xFF8C8C8C),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFEBFAEF),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: const Color(0xFFB3EBC5),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'lib/Assets/rise.svg',
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 4),
                                child: Text(
                                  element['percent']!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 16 / 14,
                                    color: Color(0xFF2EB553),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Oclock extends StatefulWidget {
  const Oclock({super.key});

  @override
  State<Oclock> createState() => _OclockState();
}

class _OclockState extends State<Oclock> {
  DateTime _now = DateTime.now();

  @override
  void setState(VoidCallback fn) {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _now = DateTime.now();
        });
      }
    });
    super.setState(fn);
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _now = DateTime.now();
        });
      }
    });
    super.initState();
  }

  String convertWeekDay(int number) {
    String value = '';
    switch (number) {
      case 1:
        value = 'Thứ 2';
        break;
      case 2:
        value = 'Thứ 3';
        break;
      case 3:
        value = 'Thứ 4';
        break;
      case 4:
        value = 'Thứ 5';
        break;
      case 5:
        value = 'Thứ 6';
        break;
      case 6:
        value = 'Thứ 7';
        break;
      case 7:
        value = 'Chủ nhật';
        break;
      default:
        break;
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${_now.hour}:${_now.minute}:${_now.second}',
              style: const TextStyle(fontSize: 38, height: 48 / 38, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Text(
                '${convertWeekDay(_now.weekday)},${_now.day}/${_now.month}/${_now.year}',
                style: const TextStyle(fontSize: 12, height: 16 / 12, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
