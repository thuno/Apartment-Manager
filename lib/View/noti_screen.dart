import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project1/Module/noti_item.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({super.key});

  @override
  State<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  List<NotifyItem> notifyList = [NotifyItem()];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.1,
          toolbarHeight: notifyList.isNotEmpty ? 104 : 56,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Thông báo',
            style: TextStyle(
              fontSize: 16,
              height: 24 / 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF262626),
            ),
          ),
          actions: notifyList.isNotEmpty
              ? [
                  Container(
                    height: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 6, right: 16),
                    child: const InkWell(
                      child: Text(
                        'Tuỳ chọn',
                        style: TextStyle(
                          fontSize: 14,
                          height: 22 / 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF366AE2),
                        ),
                      ),
                    ),
                  )
                ]
              : null,
          bottom: notifyList.isNotEmpty
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    height: 32,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F5F8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: 'Tìm kiếm thông báo',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF6E87AA),
                            size: 16,
                          ),
                          prefixIconConstraints: BoxConstraints(minWidth: 40),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10)),
                      style: TextStyle(fontSize: 14, height: 22 / 14),
                    ),
                  ),
                )
              : null,
        ),
        body: notifyList.isNotEmpty
            ? ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: const Text(
                      'Hôm nay',
                      style: TextStyle(
                        fontSize: 16,
                        height: 22 / 16,
                        color: Color(0xFF1C2430),
                      ),
                    ),
                  ),
                  ...List.generate(2, (index) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      color: const Color(0xFFEDF2FD),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.only(right: 12),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFEDF2FD),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: SvgPicture.asset('lib/Assets/settings.svg'),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hệ thống',
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 22 / 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1C2430),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 4, bottom: 8),
                                  child: const Text(
                                    'Phiên bản mới đã được cập nhật! Chúng tôi luôn đem trải nghiệm tốt nhất đến bạn',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 22 / 14,
                                      color: Color(0xFF4B6281),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Vừa xong',
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 16 / 12,
                                    color: Color(0xFF366AE2),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SvgPicture.asset('lib/Assets/trash-can.svg')
                        ],
                      ),
                    );
                  }),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: const Text(
                      'Cũ hơn',
                      style: TextStyle(
                        fontSize: 16,
                        height: 22 / 16,
                        color: Color(0xFF1C2430),
                      ),
                    ),
                  ),
                  ...List.generate(5, (index) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.only(right: 12),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFEDF2FD),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: SvgPicture.asset('lib/Assets/settings.svg'),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hóa đơn',
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 22 / 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1C2430),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 4, bottom: 8),
                                  child: const Text(
                                    'Đã có hóa đơn tiền phòng tháng này !',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 22 / 14,
                                      color: Color(0xFF4B6281),
                                    ),
                                  ),
                                ),
                                const Text(
                                  '17:15',
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 16 / 12,
                                    color: Color(0xFF6E87AA),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SvgPicture.asset('lib/Assets/trash-can.svg')
                        ],
                      ),
                    );
                  }),
                ],
              )
            : Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('lib/Assets/noti screen.svg'),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          'Bạn chưa có thông báo mới',
                          style: TextStyle(
                            fontSize: 20,
                            height: 28 / 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1C2430),
                          ),
                        ),
                      ),
                      const Text(
                        'Chúng tôi sẽ thông báo các tin quan trọng cách nhanh chóng. Bạn nhớ theo dõi nhé!',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          height: 24 / 16,
                          color: Color(0xFF4B6281),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
