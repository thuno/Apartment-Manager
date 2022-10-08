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

class _UpdateCostState extends State<UpdateCost> with TickerProviderStateMixin {
  final oCcy = NumberFormat("#,##0 (VNĐ)", "en_US");
  final TextEditingController editRoomCost = TextEditingController();
  final TextEditingController editOldElectric = TextEditingController();
  final TextEditingController editNewElectric = TextEditingController();
  final TextEditingController editElectricCost = TextEditingController();
  final TextEditingController editTotalElectric = TextEditingController();
  final TextEditingController editOldWater = TextEditingController();
  final TextEditingController editNewWater = TextEditingController();
  final TextEditingController editWaterCost = TextEditingController();
  final TextEditingController editTotalWater = TextEditingController();
  final TextEditingController editInternet = TextEditingController();
  final TextEditingController editOtherService = TextEditingController();
  final TextEditingController editVehicle = TextEditingController();
  AnimationController? controller;
  int totalCost = 0;
  bool isSaving = false;
  bool isChange = false;

  int currentIndex = 0;

  void selectRoom() {
    editRoomCost.text = oCcy.format(RoomDA.listRoom[currentIndex].roomCost);
    editOldElectric.text = '${RoomDA.listRoom[currentIndex].oldElectricNumber}';
    editNewElectric.text = '${RoomDA.listRoom[currentIndex].newElectricNumber}';
    editElectricCost.text = '${RoomDA.listRoom[currentIndex].electricity! / 1000}'.replaceAll(".0", "");
    editTotalElectric.text = oCcy.format(RoomDA.listRoom[currentIndex].electricity! *
        (RoomDA.listRoom[currentIndex].newElectricNumber! - RoomDA.listRoom[currentIndex].oldElectricNumber!));
    editOldWater.text = '${RoomDA.listRoom[currentIndex].oldWaterNumber}';
    editNewWater.text = '${RoomDA.listRoom[currentIndex].newWaterNumber}';
    editWaterCost.text = '${RoomDA.listRoom[currentIndex].water! / 1000}'.replaceAll(".0", "");
    editTotalWater.text = oCcy.format(RoomDA.listRoom[currentIndex].water! *
        (RoomDA.listRoom[currentIndex].newWaterNumber! - RoomDA.listRoom[currentIndex].oldWaterNumber!));
    editInternet.text = oCcy.format(RoomDA.listRoom[currentIndex].internet);
    editOtherService.text = oCcy.format(RoomDA.listRoom[currentIndex].otherService);
    editVehicle.text = oCcy.format(RoomDA.listRoom[currentIndex].vehicle);
    totalCost = RoomDA.listRoom[currentIndex].totalBill;
  }

  void calcTotalCost() {
    totalCost = formatMoney(editRoomCost.text)! +
        (double.tryParse(editElectricCost.text)! * 1000).toInt() *
            (formatMoney(editNewElectric.text)! - formatMoney(editOldElectric.text)!) +
        (double.tryParse(editWaterCost.text)! * 1000).toInt() *
            (formatMoney(editNewWater.text)! - formatMoney(editOldWater.text)!) +
        formatMoney(editInternet.text)! +
        formatMoney(editOtherService.text)! +
        formatMoney(editVehicle.text)!;
  }

  int? formatMoney(String text) {
    return int.tryParse(text.replaceAll(' (VNĐ)', '').replaceAll(',', ''));
  }

  Future<void> saveData() async {
    setState(() {
      isSaving = true;
      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      )..addListener(() {
          if (mounted && isSaving) {
            setState(() {});
          }
        });
      controller!.repeat();
    });
    await RoomDA.editRoom(RoomDA.listRoom[currentIndex]).then((value) {
      setState(() {
        controller!.removeListener(() {});
        isSaving = false;
        isChange = false;
        controller?.removeListener(() {});
      });
    });
  }

  @override
  void initState() {
    selectRoom();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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
          toolbarHeight: RoomDA.listRoom.isEmpty ? 48 : 96,
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
                itemCount: RoomDA.listRoom.length,
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
                        RoomDA.listRoom[index].name!,
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
            physics: const BouncingScrollPhysics(),
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
                    } else {
                      var newValue = formatMoney(editRoomCost.text);
                      setState(() {
                        if (newValue != null) {
                          if (newValue != RoomDA.listRoom[currentIndex].roomCost) {
                            RoomDA.listRoom[currentIndex].roomCost = newValue;
                            calcTotalCost();
                            isChange = true;
                          }
                        } else {
                          editRoomCost.text = oCcy.format(RoomDA.listRoom[currentIndex].roomCost);
                        }
                      });
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
                      child: Focus(
                        onFocusChange: (value) {
                          if (!value) {
                            var newValue = int.tryParse(editOldElectric.text);
                            setState(() {
                              if (newValue != null) {
                                if (newValue != RoomDA.listRoom[currentIndex].oldElectricNumber) {
                                  RoomDA.listRoom[currentIndex].oldElectricNumber = newValue;
                                  calcTotalCost();
                                  isChange = true;
                                  editTotalElectric.text = oCcy.format(
                                      (double.tryParse(editElectricCost.text)! * 1000).toInt() *
                                          (int.tryParse(editNewElectric.text)! - newValue));
                                }
                              } else {
                                editOldElectric.text = '${RoomDA.listRoom[currentIndex].oldElectricNumber}';
                              }
                            });
                          }
                        },
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
                    ),
                    const SizedBox(width: 12),
                    // input số điện tháng này
                    Expanded(
                      child: Focus(
                        onFocusChange: (value) {
                          if (!value) {
                            var newValue = int.tryParse(editNewElectric.text);
                            setState(() {
                              if (newValue != null) {
                                if (newValue != RoomDA.listRoom[currentIndex].newElectricNumber) {
                                  RoomDA.listRoom[currentIndex].newElectricNumber = newValue;
                                  calcTotalCost();
                                  isChange = true;
                                  editTotalElectric.text = oCcy.format(
                                      (double.tryParse(editElectricCost.text)! * 1000).toInt() *
                                          (newValue - int.tryParse(editOldElectric.text)!));
                                }
                              } else {
                                editNewElectric.text = '${RoomDA.listRoom[currentIndex].newElectricNumber}';
                              }
                            });
                          }
                        },
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
                    ),
                  ],
                ),
              ),
              // input tính ra số tiền điện
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 60,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 12),
                    child: Focus(
                      onFocusChange: (value) {
                        if (!value) {
                          var newValue = double.tryParse(editElectricCost.text);
                          setState(() {
                            if (newValue != null) {
                              if ((newValue * 1000).toInt() != RoomDA.listRoom[currentIndex].electricity) {
                                RoomDA.listRoom[currentIndex].electricity = (newValue * 1000).toInt();
                                calcTotalCost();
                                isChange = true;
                                editTotalElectric.text = oCcy.format((newValue * 1000).toInt() *
                                    (int.tryParse(editNewElectric.text)! - int.tryParse(editOldElectric.text)!));
                              }
                            } else {
                              editElectricCost.text =
                                  '${RoomDA.listRoom[currentIndex].electricity! / 1000}'.replaceAll(".0", "");
                            }
                          });
                        }
                      },
                      child: TextFormField(
                        controller: editElectricCost,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          isDense: true,
                          suffixText: 'k/số',
                          label: Text(
                            'Giá điện',
                            style: TextStyle(fontSize: 18),
                          ),
                          suffixIconConstraints: BoxConstraints(minWidth: 60),
                          contentPadding: EdgeInsets.fromLTRB(8, 24, 8, 8),
                        ),
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.bottom,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 24 / 16,
                          color: Color(0xFF6E87AA),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        color: const Color(0xFFE6EAF0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 16, top: 8),
                              child: const Text(
                                'Thành tiền',
                                style: TextStyle(fontSize: 14, height: 16 / 14, color: Color(0xFF6E87AA)),
                              ),
                            ),
                            TextFormField(
                              controller: editTotalElectric,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(0xFFE6EAF0),
                                isDense: true,
                                contentPadding: EdgeInsets.fromLTRB(16, 4, 16, 8),
                              ),
                              enabled: false,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 24 / 16,
                                color: Color(0xFF6E87AA),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
                      child: Focus(
                        onFocusChange: (value) {
                          if (!value) {
                            var newValue = int.tryParse(editOldWater.text);
                            setState(() {
                              if (newValue != null) {
                                if (newValue != RoomDA.listRoom[currentIndex].oldWaterNumber) {
                                  RoomDA.listRoom[currentIndex].oldWaterNumber = newValue;
                                  calcTotalCost();
                                  isChange = true;
                                  editTotalWater.text = oCcy.format(
                                      (double.tryParse(editWaterCost.text)! * 1000).toInt() *
                                          (int.tryParse(editNewWater.text)! - newValue));
                                }
                              } else {
                                editOldWater.text = '${RoomDA.listRoom[currentIndex].oldWaterNumber}';
                              }
                            });
                          }
                        },
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
                    ),
                    const SizedBox(width: 12),
                    // input số nước tháng này
                    Expanded(
                      child: Focus(
                        onFocusChange: (value) {
                          if (!value) {
                            var newValue = int.tryParse(editNewWater.text);
                            setState(() {
                              if (newValue != null) {
                                if (newValue != RoomDA.listRoom[currentIndex].newWaterNumber) {
                                  RoomDA.listRoom[currentIndex].newWaterNumber = newValue;
                                  calcTotalCost();
                                  isChange = true;
                                  editTotalWater.text = oCcy.format(
                                      (double.tryParse(editWaterCost.text)! * 1000).toInt() *
                                          (newValue - int.tryParse(editOldWater.text)!));
                                }
                              } else {
                                editNewWater.text = '${RoomDA.listRoom[currentIndex].newWaterNumber}';
                              }
                            });
                          }
                        },
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
                    ),
                  ],
                ),
              ),
              // input tính ra số tiền nước
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 60,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 12),
                    child: Focus(
                      onFocusChange: (value) {
                        if (!value) {
                          var newValue = int.tryParse(editNewWater.text);
                          setState(() {
                            if (newValue != null) {
                              if ((newValue * 1000).toInt() != RoomDA.listRoom[currentIndex].newWaterNumber) {
                                RoomDA.listRoom[currentIndex].newWaterNumber = (newValue * 1000).toInt();
                                calcTotalCost();
                                isChange = true;
                                editTotalWater.text = oCcy.format((newValue * 1000).toInt() *
                                    (int.tryParse(editNewWater.text)! - int.tryParse(editOldWater.text)!));
                              }
                            } else {
                              editWaterCost.text =
                                  '${RoomDA.listRoom[currentIndex].water! / 1000}'.replaceAll(".0", "");
                            }
                          });
                        }
                      },
                      child: TextFormField(
                        controller: editWaterCost,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          isDense: true,
                          suffixText: 'k/m3',
                          label: Text(
                            'Giá nước',
                            style: TextStyle(fontSize: 18),
                          ),
                          suffixIconConstraints: BoxConstraints(minWidth: 60),
                          contentPadding: EdgeInsets.fromLTRB(8, 24, 8, 8),
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 24 / 16,
                          color: Color(0xFF6E87AA),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        color: const Color(0xFFE6EAF0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 16, top: 8),
                              child: const Text(
                                'Thành tiền',
                                style: TextStyle(fontSize: 14, height: 16 / 14, color: Color(0xFF6E87AA)),
                              ),
                            ),
                            TextFormField(
                              controller: editTotalWater,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Color(0xFFE6EAF0),
                                  isDense: true,
                                  contentPadding: EdgeInsets.fromLTRB(16, 4, 16, 8)),
                              enabled: false,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 24 / 16,
                                color: Color(0xFF6E87AA),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
                          baseOffset: editInternet.text.replaceAll(" (VNĐ)", "").length,
                          extentOffset: editInternet.text.replaceAll(" (VNĐ)", "").length);
                    } else {
                      var newValue = formatMoney(editInternet.text);
                      setState(() {
                        if (newValue != null) {
                          if (newValue != RoomDA.listRoom[currentIndex].internet) {
                            RoomDA.listRoom[currentIndex].internet = newValue;
                            calcTotalCost();
                            isChange = true;
                          }
                        } else {
                          editInternet.text = oCcy.format(RoomDA.listRoom[currentIndex].internet);
                        }
                      });
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
                          baseOffset: editOtherService.text.replaceAll(" (VNĐ)", "").length,
                          extentOffset: editOtherService.text.replaceAll(" (VNĐ)", "").length);
                    } else {
                      var newValue = formatMoney(editOtherService.text);
                      setState(() {
                        if (newValue != null) {
                          if (newValue != RoomDA.listRoom[currentIndex].otherService) {
                            RoomDA.listRoom[currentIndex].otherService = newValue;
                            calcTotalCost();
                            isChange = true;
                          }
                        } else {
                          editOtherService.text = oCcy.format(RoomDA.listRoom[currentIndex].otherService);
                        }
                      });
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
                          baseOffset: editVehicle.text.replaceAll(" (VNĐ)", "").length,
                          extentOffset: editVehicle.text.replaceAll(" (VNĐ)", "").length);
                    } else {
                      var newValue = formatMoney(editVehicle.text);
                      setState(() {
                        if (newValue != null) {
                          if (newValue != RoomDA.listRoom[currentIndex].vehicle) {
                            RoomDA.listRoom[currentIndex].vehicle = newValue;
                            calcTotalCost();
                            isChange = true;
                          }
                        } else {
                          editVehicle.text = oCcy.format(RoomDA.listRoom[currentIndex].vehicle);
                        }
                      });
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
        bottomNavigationBar: RoomDA.listRoom.isEmpty
            ? null
            : Container(
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
                      onTap: isSaving && isChange ? null : saveData,
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: isChange ? const Color(0xFF1890FF) : const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: isSaving
                            ? SizedBox(
                                height: 24,
                                width: 24,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: CircularProgressIndicator(
                                    value: controller!.value,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                'Lưu và tiếp tục',
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 22 / 14,
                                  color: isChange ? Colors.white : const Color(0xFF8C8C8C),
                                ),
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
