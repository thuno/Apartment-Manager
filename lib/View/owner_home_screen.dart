import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:project1/Module/income_item.dart';
import 'package:project1/Module/room_item.dart';
import 'package:project1/View/payment_status_screen.dart';
import 'package:project1/View/update_cost_screen.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  final oCcy = NumberFormat("#,##0", "en_US");
  final ScrollController scrollController = ScrollController();
  List<RoomItem> listRoomPaid = [];
  IncomeItem? incomeLastMonth;

  String convertNumber(int number) {
    if (number < 10) {
      return '0$number';
    } else {
      return '$number';
    }
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

  final Stream<DateTime> _now = (() {
    late final StreamController<DateTime> controller;
    controller = StreamController<DateTime>(
      sync: true,
      onListen: () async {
        Future<void> listenTimeChage() async {
          await Future<void>.delayed(const Duration(seconds: 1));
          controller.add(DateTime.now());
          listenTimeChage();
        }

        await listenTimeChage();
      },
    );
    return controller.stream;
  })();

  Future<void> getIncomeHistory() async {
    await IncomeDA.getHistory();
    setState(() {
      incomeLastMonth = IncomeDA.history.last;
    });
  }

  @override
  void initState() {
    getIncomeHistory();
    listRoomPaid = RoomDA.listRoom.where((e) => e.payementStatus ?? false).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int? totalIncome;
    if (incomeLastMonth != null) {
      totalIncome =
          (incomeLastMonth!.electric! + incomeLastMonth!.water! + incomeLastMonth!.room! + incomeLastMonth!.service!);
    }
    var listIncomeType = [
      {
        "money": oCcy.format(totalIncome ?? 0),
        "title": 'Tổng doanh thu ${incomeLastMonth?.name ?? ("tháng ${DateTime.now().month})}")}',
        "percent": '100%',
      },
      {
        "money": oCcy.format(incomeLastMonth?.room ?? 0),
        "title": 'Tiền phòng',
        "percent": '${((incomeLastMonth?.room ?? 0) * 100 / (totalIncome ?? 1)).round()}%',
      },
      {
        "money": oCcy.format(incomeLastMonth?.electric ?? 0),
        "title": 'Tiền điện',
        "percent": '${((incomeLastMonth?.electric ?? 0) * 100 / (totalIncome ?? 1)).round()}%',
      },
      {
        "money": oCcy.format(incomeLastMonth?.water ?? 0),
        "title": 'Tiền nước',
        "percent": '${((incomeLastMonth?.water ?? 0) * 100 / (totalIncome ?? 1)).round()}%',
      },
      {
        "money": oCcy.format(incomeLastMonth?.service ?? 0),
        "title": 'Phí dịch vụ khác',
        "percent": '${((incomeLastMonth?.service ?? 0) * 100 / (totalIncome ?? 1)).round()}%',
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
            Positioned(
              top: 124,
              right: 20,
              child: StreamBuilder(
                initialData: DateTime.now(),
                stream: _now,
                builder: (context, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${convertNumber(snapshot.data!.hour)}:${convertNumber(snapshot.data!.minute)}:${convertNumber(snapshot.data!.second)}',
                        style: const TextStyle(
                            fontSize: 38, height: 48 / 38, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(
                          '${convertWeekDay(snapshot.data!.weekday)},${convertNumber(snapshot.data!.day)}/${convertNumber(snapshot.data!.month)}/${snapshot.data!.year}',
                          style: const TextStyle(fontSize: 12, height: 16 / 12, color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              ),
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
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentStatus()));
                        },
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
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateCost()));
                        },
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
                        child: CircularProgressIndicator(
                          backgroundColor: (listRoomPaid.length / RoomDA.listRoom.length) > 0.9
                              ? const Color(0xFF84ED9C)
                              : const Color(0xFFFCF2EF),
                          color: (listRoomPaid.length / RoomDA.listRoom.length) > 0.9
                              ? const Color(0xFF33BC58)
                              : const Color(0xFFF94033),
                          strokeWidth: 40,
                          value: listRoomPaid.length / RoomDA.listRoom.length,
                        ),
                      ),
                      Center(
                        child: Text(
                          '${listRoomPaid.length}/${RoomDA.listRoom.length}',
                          style: const TextStyle(
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
                Text(
                  'Tính đến ngày ${convertNumber(DateTime.now().day)}/${convertNumber(DateTime.now().month)}/${DateTime.now().year}',
                  style: const TextStyle(
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
