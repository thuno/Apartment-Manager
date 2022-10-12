import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project1/Firebase/database_store.dart';
import 'package:project1/Module/guest_infor_item.dart';
import 'package:project1/Module/room_item.dart';
import 'package:project1/View/Lease_screen.dart';
import 'package:project1/View/bill_detail_screen.dart';
import 'package:project1/View/bill_history_screen.dart';
import 'package:project1/View/change_password_screen.dart';
import 'package:project1/View/contact_screen.dart';

import '../Module/bill_item.dart';

class GuestHomeScreen extends StatefulWidget {
  final RoomItem? roomItem;
  const GuestHomeScreen({super.key, this.roomItem});

  @override
  State<GuestHomeScreen> createState() => _GuestHomeScreenState();
}

class _GuestHomeScreenState extends State<GuestHomeScreen> {
  final oCcy = NumberFormat("#,##0", "en_US");
  DateTime lastMonth = DateTime(DateTime.now().year, DateTime.now().month, 0);
  int payDay = 1;
  bool isLoading = false;
  int status = 0;

  @override
  void initState() {
    payDay = int.parse(widget.roomItem!.dateStart!.split("/").first);
    super.initState();
  }

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
                          Text(
                            'Phòng ${widget.roomItem!.name}',
                            style: const TextStyle(fontSize: 12, height: 16 / 12, color: Color(0xFF262626)),
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
                  InkWell(
                    onTap: isLoading
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                            });
                            FireBaseDA.getFiles('${widget.roomItem!.name}/contract').then(
                              (value) async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GuestLeaseScreen(paths: value),
                                    ));
                                setState(() {
                                  isLoading = false;
                                });
                              },
                            );
                          },
                    child: SizedBox(
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
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BillHistoryScreen(
                              paymentStatus: status,
                              roomName: widget.roomItem!.name,
                              payDay: payDay,
                            ),
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
                    onTap: () async {
                      await GuestInforDA.getInfor(widget.roomItem!.guestId!).then(
                        (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactScreen(
                                guestInfor: value,
                              ),
                            )),
                      );
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePaswword(),
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
                  ),
                ],
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection(RoomDA.collection).doc(widget.roomItem!.id).snapshots(),
                builder: (context, snapshot) {
                  RoomItem? freshRoomItem;
                  // 0 là trạng thái đã thanh toán
                  if (snapshot.hasData) {
                    freshRoomItem = RoomItem.fromJson(snapshot.data!.data()!);
                    if (!freshRoomItem.payementStatus!) {
                      if (payDay - DateTime.now().day < 0) {
                        // 2 là trạng thái thanh toán muộn
                        status = 2;
                      } else {
                        status = 1;
                      }
                    }
                  }
                  return Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hạn nộp $payDay/${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}/${DateTime.now().year}',
                              style: const TextStyle(
                                fontSize: 12,
                                height: 16 / 12,
                                color: Color(0xFF6E87AA),
                              ),
                            ),
                            Builder(builder: (context) {
                              return Text(
                                status == 0
                                    ? 'Đã thanh toán'
                                    : status == 2
                                        ? 'Trễ hạn'
                                        : 'Chưa thanh toán',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 16 / 12,
                                  color: status == 0
                                      ? const Color(0xFF33BC58)
                                      : status == 2
                                          ? const Color(0xFFF94033)
                                          : const Color(0xFF6E87AA),
                                ),
                              );
                            }),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Tiền phòng tháng ${lastMonth.month < 10 ? "0${lastMonth.month}" : lastMonth.month}/${lastMonth.year}',
                            style: const TextStyle(
                              fontSize: 16,
                              height: 24 / 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1C2430),
                            ),
                          ),
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection(BillDA.collection + widget.roomItem!.name!)
                                .doc(widget.roomItem!.lastBillId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              String totalBill = '0';
                              BillItem billItem = BillItem();
                              if (snapshot.hasData) {
                                billItem = BillItem.fromJson(snapshot.data!.data()!);
                                totalBill = oCcy.format(billItem.totalBill);
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                          text: totalBill,
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
                                                  billItem: billItem, paymentStatus: status, payDay: 10),
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
                              );
                            }),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
