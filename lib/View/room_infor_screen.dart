import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoomInfor extends StatefulWidget {
  const RoomInfor({super.key});

  @override
  State<RoomInfor> createState() => _RoomInforState();
}

class _RoomInforState extends State<RoomInfor> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 96,
          backgroundColor: Colors.white,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
          centerTitle: true,
          title: const Text(
            'Thông tin phòng trọ',
            style: TextStyle(
              fontSize: 16,
              height: 24 / 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF262626),
            ),
          ),
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          currentTab = 0;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 4),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: currentTab == 0 ? const Color(0xFF1890FF) : const Color(0xFFF5F5F5),
                        ),
                        child: Text(
                          'Thông tin chung',
                          style: TextStyle(
                            fontSize: 14,
                            height: 22 / 14,
                            color: currentTab == 0 ? const Color(0xFFE6F7FF) : const Color(0xFFBFBFBF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          currentTab = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: currentTab == 1 ? const Color(0xFF1890FF) : const Color(0xFFF5F5F5),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        alignment: Alignment.center,
                        child: Text(
                          'Hợp đồng thuê nhà',
                          style: TextStyle(
                            fontSize: 14,
                            height: 22 / 14,
                            color: currentTab == 1 ? const Color(0xFFE6F7FF) : const Color(0xFFBFBFBF),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
            color: const Color(0xFFF5F5F5), child: currentTab == 0 ? const CommonInforTab() : const LeaseTab()),
      ),
    );
  }
}

// tab Thông tin chung
class CommonInforTab extends StatefulWidget {
  const CommonInforTab({super.key});

  @override
  State<CommonInforTab> createState() => _CommonInforTabState();
}

class _CommonInforTabState extends State<CommonInforTab> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController userName = TextEditingController();
  final TextEditingController birthDay = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController cccdNumber = TextEditingController();
  final TextEditingController deposit = TextEditingController();
  final TextEditingController numberUser = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  // button reset
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: DottedBorder(
                            color: const Color(0xFF1890FF),
                            radius: const Radius.circular(8),
                            borderType: BorderType.RRect,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset('lib/Assets/reload.svg'),
                                  Container(
                                    margin: const EdgeInsets.only(left: 4),
                                    child: const Text(
                                      'Đặt lại mật khẩu',
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
                      const SizedBox(width: 8),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: DottedBorder(
                            color: const Color(0xFF1890FF),
                            radius: const Radius.circular(8),
                            borderType: BorderType.RRect,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset('lib/Assets/delete.svg'),
                                  Container(
                                    margin: const EdgeInsets.only(left: 4),
                                    child: const Text(
                                      'Đặt lại dữ liệu phòng',
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
                    ],
                  ),
                  // input người đại diện phòng
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: const Text(
                      'Người đại diện',
                      style: TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF394960),
                      ),
                    ),
                  ),
                  Container(
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: TextFormField(
                      controller: userName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Nguyễn Văn A',
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                      ),
                    ),
                  ),
                  // input ngày sinh
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: const Text(
                      'Ngày sinh',
                      style: TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF394960),
                      ),
                    ),
                  ),
                  Container(
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: TextFormField(
                      controller: birthDay,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: '02/02/1998',
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                      ),
                    ),
                  ),
                  // input địa chỉ thường trú
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: const Text(
                      'Địa chỉ thường trú',
                      style: TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF394960),
                      ),
                    ),
                  ),
                  Container(
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: TextFormField(
                      controller: address,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Kiến An - Hải Phòng',
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                      ),
                    ),
                  ),
                  // input số cccd
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: const Text(
                      'Số CMND/CCCD',
                      style: TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF394960),
                      ),
                    ),
                  ),
                  Container(
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: TextFormField(
                      controller: address,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: '098412413213',
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                      ),
                    ),
                  ),
                  // add ảnh cccd
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: const Text(
                      'Ảnh CMND/CCCD',
                      style: TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF394960),
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset('lib/Assets/Rectangle 127.png'),
                      ),
                      DottedBorder(
                        borderType: BorderType.RRect,
                        color: const Color(0xFF1890FF),
                        radius: const Radius.circular(8),
                        child: Container(
                          width: 64,
                          height: 64,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.add,
                            size: 40,
                            color: Color(0xFF1890FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // input tiền cọc
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: const Text(
                      'Tiền cọc',
                      style: TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF394960),
                      ),
                    ),
                  ),
                  Container(
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: TextFormField(
                      controller: deposit,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: '3,000,000 (VNĐ)',
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                      ),
                    ),
                  ),
                  // input ngày bắt đầu thuê
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: const Text(
                      'Ngày bắt đầu thuê',
                      style: TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF394960),
                      ),
                    ),
                  ),
                  Container(
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: '20/01/2020',
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                      ),
                    ),
                  ),
                  // input số người thuê
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: const Text(
                      'Ngày bắt đầu thuê',
                      style: TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF394960),
                      ),
                    ),
                  ),
                  Container(
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: TextFormField(
                      controller: numberUser,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: '3',
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // button Lưu
          Container(
            color: Colors.white,
            width: double.infinity,
            child: InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFF5F5F5),
                ),
                child: const Text(
                  'Lưu',
                  style: TextStyle(
                    fontSize: 14,
                    height: 22 / 14,
                    color: Color(0xFF8C8C8C),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// tab Hợp đồng thuê nhà
class LeaseTab extends StatefulWidget {
  const LeaseTab({super.key});

  @override
  State<LeaseTab> createState() => _LeaseTabState();
}

class _LeaseTabState extends State<LeaseTab> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
