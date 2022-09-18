import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentStatus extends StatefulWidget {
  const PaymentStatus({super.key});

  @override
  State<PaymentStatus> createState() => _PaymentStatusState();
}

class _PaymentStatusState extends State<PaymentStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 56,
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
        title: Column(
          children: [
            const Text(
              'Trạng thái thanh toán',
              style: TextStyle(
                fontSize: 16,
                height: 24 / 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF262626),
              ),
            ),
            Text(
              'Dữ liệu tiền phòng tháng ${DateTime.now().month}',
              style: const TextStyle(
                fontSize: 12,
                height: 16 / 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF262626),
              ),
            ),
          ],
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
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
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
                      const Expanded(
                        child: Text(
                          'Phòng 101',
                          style: TextStyle(
                            fontSize: 16,
                            height: 22 / 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF262626),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Row(
                          children: [
                            const Text(
                              'Đã thanh toán',
                              style: TextStyle(
                                fontSize: 16,
                                height: 22 / 16,
                                color: Color(0xFF595959),
                              ),
                            ),
                            Transform.scale(
                              scale: 28 / 32,
                              child: Checkbox(
                                value: false,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                onChanged: (value) {},
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 12),
                          child: SvgPicture.asset('lib/Assets/user-multiple.svg'),
                        ),
                        const Text(
                          'Số người: 3',
                          style: TextStyle(
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
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: SvgPicture.asset(
                          'lib/Assets/money.svg',
                          width: 24,
                          height: 24,
                          color: const Color(0xFF366AE2),
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
                                fontSize: 14,
                                height: 22 / 14,
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
                    ],
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
    ;
  }
}
