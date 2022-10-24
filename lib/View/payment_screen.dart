import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project1/Module/payment_infor_item.dart';

import '../Firebase/database_store.dart';

class PaymentScreen extends StatefulWidget {
  final bool isPage;
  const PaymentScreen({this.isPage = true, super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<PaymentItem> listPayment = [];

  @override
  void initState() {
    PaymentDA.getListPayment().then((_) async {
      listPayment = PaymentDA.listPayment;
      for (var paymentItem in listPayment) {
        var paths = await FireBaseDA.getFiles(paymentItem.qrPhoto);
        paymentItem.qrPhotoLink = paths.single;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 48,
        backgroundColor: Colors.transparent,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
        leading: widget.isPage
            ? null
            : Container(
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
          'Thanh toán',
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
        child: ListView(
          children: [
            const Text(
              'Chuyển khoản vào STK hoặc Quét QR Code',
              style: TextStyle(
                fontSize: 16,
                height: 24 / 16,
                color: Color(0xFF6E87AA),
              ),
              maxLines: 2,
            ),
            for (var payment in listPayment)
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Ngân hàng thụ hưởng: ',
                          style: TextStyle(
                            fontSize: 14,
                            height: 22 / 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF262626),
                          ),
                        ),
                        Text(
                          payment.bank!,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 22 / 14,
                            color: Color(0xFF262626),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          const Text(
                            'Tên chủ tài khoản: ',
                            style: TextStyle(
                              fontSize: 14,
                              height: 22 / 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF262626),
                            ),
                          ),
                          Text(
                            payment.userName!,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 22 / 14,
                              color: Color(0xFF262626),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Số tài khoản: ',
                          style: TextStyle(
                            fontSize: 14,
                            height: 22 / 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF262626),
                          ),
                        ),
                        Text(
                          payment.stk!,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 22 / 14,
                            color: Color(0xFF262626),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (payment.qrPhotoLink != null) Image.network(payment.qrPhotoLink!),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
