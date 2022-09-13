import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentScreen extends StatefulWidget {
  final bool isPage;
  const PaymentScreen({this.isPage = true, super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List listImg = [];

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
            for (var img in listImg)
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Image.network(img),
              ),
          ],
        ),
      ),
    );
  }
}
