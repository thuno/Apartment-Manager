import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:project1/Module/room_item.dart';

class UpdateCost extends StatefulWidget {
  const UpdateCost({super.key});

  @override
  State<UpdateCost> createState() => _UpdateCostState();
}

class _UpdateCostState extends State<UpdateCost> {
  final oCcy = NumberFormat("#,##0 (VNĐ)", "en_US");
  final TextEditingController editRoomCost = TextEditingController();
  final TextEditingController editOldElectric = TextEditingController();
  final TextEditingController editNewElectric = TextEditingController();
  final TextEditingController editOldWater = TextEditingController();
  final TextEditingController editNewWater = TextEditingController();
  final TextEditingController editInternet = TextEditingController();
  final TextEditingController editOtherService = TextEditingController();
  final TextEditingController editVehicle = TextEditingController();
  int totalCost = 0;

  List<RoomItem> listRoom = [
    RoomItem(
      id: '101',
      roomCost: 6000000,
      oldElectricNumber: 3824,
      newElectricNumber: 4012,
      electricity: 4000,
      oldWaterNumber: 1298,
      newWaterNumber: 1303,
      water: 30000,
      internet: 100000,
      otherService: 100000,
      vehicle: 0,
    ),
    RoomItem(
      id: '102',
      roomCost: 6000000,
      oldElectricNumber: 3824,
      newElectricNumber: 4012,
      electricity: 4000,
      oldWaterNumber: 1298,
      newWaterNumber: 1303,
      water: 30000,
      internet: 100000,
      otherService: 100000,
      vehicle: 0,
    ),
    RoomItem(
      id: '103',
      roomCost: 6000000,
      oldElectricNumber: 3824,
      newElectricNumber: 4012,
      electricity: 4000,
      oldWaterNumber: 1298,
      newWaterNumber: 1303,
      water: 30000,
      internet: 100000,
      otherService: 100000,
      vehicle: 0,
    ),
    RoomItem(
      id: '104',
      roomCost: 6000000,
      oldElectricNumber: 3824,
      newElectricNumber: 4012,
      electricity: 4000,
      oldWaterNumber: 1298,
      newWaterNumber: 1303,
      water: 30000,
      internet: 100000,
      otherService: 100000,
      vehicle: 0,
    ),
    RoomItem(
      id: '201',
      roomCost: 6000000,
      oldElectricNumber: 3824,
      newElectricNumber: 4012,
      electricity: 4000,
      oldWaterNumber: 1298,
      newWaterNumber: 1303,
      water: 30000,
      internet: 100000,
      otherService: 100000,
      vehicle: 0,
    ),
    RoomItem(
      id: '202',
      roomCost: 6000000,
      oldElectricNumber: 3824,
      newElectricNumber: 4012,
      electricity: 4000,
      oldWaterNumber: 1298,
      newWaterNumber: 1303,
      water: 30000,
      internet: 100000,
      otherService: 100000,
      vehicle: 0,
    ),
    RoomItem(
      id: '203',
      roomCost: 6000000,
      oldElectricNumber: 3824,
      newElectricNumber: 4012,
      electricity: 4000,
      oldWaterNumber: 1298,
      newWaterNumber: 1303,
      water: 30000,
      internet: 100000,
      otherService: 100000,
      vehicle: 0,
    ),
    RoomItem(
      id: '204',
      roomCost: 6000000,
      oldElectricNumber: 3824,
      newElectricNumber: 4012,
      electricity: 4000,
      oldWaterNumber: 1298,
      newWaterNumber: 1303,
      water: 30000,
      internet: 100000,
      otherService: 100000,
      vehicle: 0,
    ),
    RoomItem(
      id: '301',
      roomCost: 6000000,
      oldElectricNumber: 3824,
      newElectricNumber: 4012,
      electricity: 4000,
      oldWaterNumber: 1298,
      newWaterNumber: 1303,
      water: 30000,
      internet: 100000,
      otherService: 100000,
      vehicle: 0,
    ),
  ];
  int currentIndex = 0;

  void selectRoom() {
    editRoomCost.text = oCcy.format(listRoom[currentIndex].roomCost);
    editOldElectric.text = '${listRoom[currentIndex].oldElectricNumber}';
    editNewElectric.text = '${listRoom[currentIndex].newElectricNumber}';
    editOldWater.text = '${listRoom[currentIndex].oldWaterNumber}';
    editNewWater.text = '${listRoom[currentIndex].newWaterNumber}';
    editInternet.text = oCcy.format(listRoom[currentIndex].internet);
    editOtherService.text = oCcy.format(listRoom[currentIndex].otherService);
    editVehicle.text = oCcy.format(listRoom[currentIndex].vehicle);
  }

  void calcTotalCost() {
    totalCost = listRoom[currentIndex].roomCost! +
        listRoom[currentIndex].electricity! *
            (listRoom[currentIndex].newElectricNumber! - listRoom[currentIndex].oldElectricNumber!) +
        listRoom[currentIndex].water! *
            (listRoom[currentIndex].newWaterNumber! - listRoom[currentIndex].oldWaterNumber!) +
        listRoom[currentIndex].internet! +
        listRoom[currentIndex].otherService! +
        listRoom[currentIndex].vehicle!;
  }

  @override
  void initState() {
    selectRoom();
    calcTotalCost();
    super.initState();
  }

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
            'Cập nhật tiền phòng',
            style: TextStyle(
              fontSize: 16,
              height: 24 / 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF262626),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: listRoom.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                        selectRoom();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: currentIndex == index ? const Color(0xFFE6F7FF) : const Color(0xFFF5F5F5),
                      ),
                      child: Text(
                        listRoom[index].id!,
                        style: TextStyle(
                          fontSize: 12,
                          height: 16 / 12,
                          color: currentIndex == index ? const Color(0xFF1890FF) : const Color(0xFFBFBFBF),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 12),
              ),
            ),
          ),
        ),
        body: Container(
          color: const Color(0xFFF2F5F8),
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: const Text(
                  'Tiền phòng',
                  style: TextStyle(
                    fontSize: 16,
                    height: 24 / 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF394960),
                  ),
                ),
              ),
              // input giá phòng
              Container(
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                clipBehavior: Clip.hardEdge,
                child: Focus(
                  onFocusChange: (value) {
                    if (value) {
                      editRoomCost.selection = TextSelection(
                          baseOffset: editRoomCost.text.replaceAll(" (VNĐ)", "").length,
                          extentOffset: editRoomCost.text.replaceAll(" (VNĐ)", "").length);
                    }
                  },
                  child: TextFormField(
                    controller: editRoomCost,
                    keyboardType: TextInputType.number,
                    inputFormatters: [MoneyFormatter()],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 24 / 16,
                      color: Color(0xFF394960),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: const Text(
                  'Tiền điện',
                  style: TextStyle(
                    fontSize: 16,
                    height: 24 / 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF394960),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    // input số điện tháng trước
                    Expanded(
                      child: TextFormField(
                        controller: editOldElectric,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: const Text(
                            'Số điện cũ',
                            style: TextStyle(fontSize: 18),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          height: 24 / 16,
                          color: Color(0xFF394960),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // input số điện tháng này
                    Expanded(
                      child: TextFormField(
                        controller: editNewElectric,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: const Text(
                            'Số điện mới',
                            style: TextStyle(fontSize: 18),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          height: 24 / 16,
                          color: Color(0xFF394960),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // input tính ra số tiền điện
              TextFormField(
                decoration: InputDecoration(
                  label: const Text(
                    'Thành tiền',
                    style: TextStyle(fontSize: 18),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFE6EAF0),
                ),
                enabled: false,
                initialValue: oCcy.format(listRoom[currentIndex].electricity! *
                    (listRoom[currentIndex].newElectricNumber! - listRoom[currentIndex].oldElectricNumber!)),
                style: const TextStyle(
                  fontSize: 16,
                  height: 24 / 16,
                  color: Color(0xFF6E87AA),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: const Text(
                  'Tiền nước',
                  style: TextStyle(
                    fontSize: 16,
                    height: 24 / 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF394960),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    // input số nước tháng trước
                    Expanded(
                      child: TextFormField(
                        controller: editOldWater,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: const Text(
                            'Số nước cũ',
                            style: TextStyle(fontSize: 18),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          height: 24 / 16,
                          color: Color(0xFF394960),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // input số nước tháng này
                    Expanded(
                      child: TextFormField(
                        controller: editNewWater,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: const Text(
                            'Số nước mới',
                            style: TextStyle(fontSize: 18),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          height: 24 / 16,
                          color: Color(0xFF394960),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // input tính ra số tiền nước
              TextFormField(
                decoration: InputDecoration(
                  label: const Text(
                    'Thành tiền',
                    style: TextStyle(fontSize: 18),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFE6EAF0),
                ),
                enabled: false,
                initialValue: oCcy.format(listRoom[currentIndex].water! *
                    (listRoom[currentIndex].newWaterNumber! - listRoom[currentIndex].oldWaterNumber!)),
                style: const TextStyle(
                  fontSize: 16,
                  height: 24 / 16,
                  color: Color(0xFF6E87AA),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: const Text(
                  'Tiền Internet',
                  style: TextStyle(
                    fontSize: 16,
                    height: 24 / 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF394960),
                  ),
                ),
              ),
              // input giá internet
              Container(
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                clipBehavior: Clip.hardEdge,
                child: Focus(
                  onFocusChange: (value) {
                    if (value) {
                      editInternet.selection = TextSelection(
                          baseOffset: editRoomCost.text.replaceAll(" (VNĐ)", "").length,
                          extentOffset: editRoomCost.text.replaceAll(" (VNĐ)", "").length);
                    }
                  },
                  child: TextFormField(
                    controller: editInternet,
                    keyboardType: TextInputType.number,
                    inputFormatters: [MoneyFormatter()],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 24 / 16,
                      color: Color(0xFF394960),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: const Text(
                  'Phí dịch vụ',
                  style: TextStyle(
                    fontSize: 16,
                    height: 24 / 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF394960),
                  ),
                ),
              ),
              // input giá dịch vụ
              Container(
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                clipBehavior: Clip.hardEdge,
                child: Focus(
                  onFocusChange: (value) {
                    if (value) {
                      editOtherService.selection = TextSelection(
                          baseOffset: editRoomCost.text.replaceAll(" (VNĐ)", "").length,
                          extentOffset: editRoomCost.text.replaceAll(" (VNĐ)", "").length);
                    }
                  },
                  child: TextFormField(
                    controller: editOtherService,
                    keyboardType: TextInputType.number,
                    inputFormatters: [MoneyFormatter()],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 24 / 16,
                      color: Color(0xFF394960),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: const Text(
                  'Xe đạp điện',
                  style: TextStyle(
                    fontSize: 16,
                    height: 24 / 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF394960),
                  ),
                ),
              ),
              // input giá xe đạp điện
              Container(
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                clipBehavior: Clip.hardEdge,
                child: Focus(
                  onFocusChange: (value) {
                    if (value) {
                      editVehicle.selection = TextSelection(
                          baseOffset: editRoomCost.text.replaceAll(" (VNĐ)", "").length,
                          extentOffset: editRoomCost.text.replaceAll(" (VNĐ)", "").length);
                    }
                  },
                  child: TextFormField(
                    controller: editVehicle,
                    keyboardType: TextInputType.number,
                    inputFormatters: [MoneyFormatter()],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 24 / 16,
                      color: Color(0xFF394960),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 116,
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    SvgPicture.asset('lib/Assets/money.svg'),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 12),
                        child: const Text(
                          'Thành tiền (VNĐ)',
                          style: TextStyle(
                            fontSize: 16,
                            height: 22 / 16,
                            color: Color(0xFF262626),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      oCcy.format(totalCost).replaceAll(" (VNĐ)", ""),
                      style: const TextStyle(
                        fontSize: 20,
                        height: 28 / 20,
                        color: Color(0xFF039732),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF366AE2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Lưu và tiếp tục',
                    style: TextStyle(fontSize: 14, height: 22 / 14, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MoneyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final oCcy = NumberFormat("#,##0", "en_US");
    var convertText = oCcy.format(int.tryParse(newValue.text.replaceAll(",", "").replaceAll(" (VNĐ)", "")));
    var convertValue = TextEditingValue(
        selection: TextSelection(baseOffset: convertText.length, extentOffset: convertText.length),
        text: '$convertText (VNĐ)');
    return convertValue;
  }
}
