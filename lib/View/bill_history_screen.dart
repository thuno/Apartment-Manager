import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:project1/Module/bill_item.dart';
import 'package:project1/View/bill_detail_screen.dart';

class BillHistoryScreen extends StatefulWidget {
  final String? roomName;
  final int paymentStatus;
  final int payDay;
  const BillHistoryScreen({super.key, this.roomName, this.paymentStatus = 0, this.payDay = 10});

  @override
  State<BillHistoryScreen> createState() => _BillHistoryScreenState();
}

class _BillHistoryScreenState extends State<BillHistoryScreen> {
  final oCcy = NumberFormat("#,##0", "en_US");
  List<BillItem> listBll = [];

  @override
  void initState() {
    BillDA.getListBill(widget.roomName!).then((_) {
      setState(() {
        listBll = BillDA.listBill;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 48,
        backgroundColor: Colors.transparent,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
        leading: Container(
          height: double.infinity,
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 12),
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
        title: const Text(
          'Lịch sử tiền phòng',
          style: TextStyle(
            fontSize: 16,
            height: 24 / 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF262626),
          ),
        ),
        actions: [
          Container(
            height: double.infinity,
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 12),
            margin: const EdgeInsets.only(right: 16),
            child: InkWell(
              child: SvgPicture.asset(
                'lib/Assets/filter.svg',
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFF2F5F8),
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: listBll.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hạn nộp ${widget.payDay}/${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}/${DateTime.now().year}',
                        style: const TextStyle(
                          fontSize: 12,
                          height: 16 / 12,
                          color: Color(0xFF6E87AA),
                        ),
                      ),
                      Text(
                        widget.paymentStatus == 0
                            ? 'Đã thanh toán'
                            : widget.paymentStatus == 2
                                ? 'Trễ hạn'
                                : 'Chưa thanh toán',
                        style: const TextStyle(
                          fontSize: 12,
                          height: 16 / 12,
                          color: Color(0xFF6E87AA),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Tiền phòng tháng ${listBll[index].name}',
                      style: const TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1C2430),
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Số tiền: ',
                          style: TextStyle(
                            fontSize: 14,
                            height: 22 / 14,
                            color: Color(0xFF4B6281),
                          ),
                        ),
                        TextSpan(
                          text: oCcy.format(listBll[index].totalBill),
                          style: const TextStyle(
                            fontSize: 20,
                            height: 28 / 20,
                            color: Color(0xFF2EB553),
                          ),
                        ),
                        const TextSpan(
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
                            builder: (context) => BillDetailsScreen(
                              billItem: listBll[index],
                              paymentStatus: index == (listBll.length - 1) ? widget.paymentStatus : 0,
                              payDay: widget.payDay,
                            ),
                          ),
                        );
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
