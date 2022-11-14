import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../Module/income_item.dart';
import 'income_details_screen.dart';
import 'update_payment_screen.dart';

class ListIncomeScreen extends StatefulWidget {
  const ListIncomeScreen({super.key});

  @override
  State<ListIncomeScreen> createState() => _ListIncomeScreenState();
}

class _ListIncomeScreenState extends State<ListIncomeScreen> {
  final oCcy = NumberFormat("#,##0 VNĐ", "en_US");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.1,
        toolbarHeight: 48,
        backgroundColor: Colors.white,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
        centerTitle: true,
        title: const Text(
          'Doanh thu',
          style: TextStyle(
            fontSize: 16,
            height: 24 / 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF262626),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 4, right: 8),
            child: InkWell(
              onTap: () async {
                await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return Container();
                  },
                );
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  'lib/Assets/filter.svg',
                  color: const Color(0xFF4B6281),
                  width: 18,
                  height: 18,
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpdatePayment(),
                    ));
              },
              child: DottedBorder(
                color: const Color(0xFF1890FF),
                radius: const Radius.circular(8),
                padding: const EdgeInsets.symmetric(vertical: 8),
                borderType: BorderType.RRect,
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add,
                        color: Color(0xFF1890FF),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        child: const Text(
                          'Cập nhật phương thức thanh toán',
                          style: TextStyle(
                            fontSize: 14,
                            height: 22 / 14,
                            color: Color(0xFF1890FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              itemCount: IncomeDA.history.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IncomeDetailsScreen(incomeItem: IncomeDA.history[index]),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF597EF7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SvgPicture.asset(
                            'lib/Assets/payment.svg',
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              IncomeDA.history[index].name!.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 14,
                                height: 22 / 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF262626),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          oCcy.format(IncomeDA.history[index].total),
                          style: const TextStyle(
                            fontSize: 16,
                            height: 24 / 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2EB553),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
