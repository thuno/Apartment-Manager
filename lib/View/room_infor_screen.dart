import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:project1/Firebase/database_store.dart';
import 'package:project1/Module/guest_infor_item.dart';
import 'package:project1/Module/room_item.dart';
import 'package:project1/Module/user_item.dart';

class RoomInfor extends StatefulWidget {
  final RoomItem? roomItem;
  const RoomInfor({super.key, this.roomItem});

  static bool isChange = false;

  @override
  State<RoomInfor> createState() => _RoomInforState();
}

class _RoomInforState extends State<RoomInfor> {
  int currentTab = 0;
  GuestInforItem guestInfor = GuestInforItem(photos: [], contractPhotos: []);
  RoomItem roomItem = RoomItem();

  Future<void> getGuestInfor() async {
    var result = GuestInforDA.guestInforList.firstWhere((e) => e.id == widget.roomItem!.guestId);
    var photos = await FireBaseDA.getFiles(widget.roomItem!.name);
    result.photos = photos;
    var contractPhotos = await FireBaseDA.getFiles('${widget.roomItem!.name}/contract');
    result.contractPhotos = contractPhotos;
    setState(() {
      guestInfor = result;
    });
  }

  @override
  void initState() {
    RoomInfor.isChange = false;
    roomItem = RoomItem.fromJson(widget.roomItem!.toJson());
    roomItem.id = widget.roomItem!.id;
    if (widget.roomItem?.guestId != null) {
      getGuestInfor();
    }
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
                if (RoomInfor.isChange) {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                        child: IntrinsicHeight(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Bạn có chắc chắn muốn thoát',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      height: 24 / 18,
                                      color: Color(0xFF262626)),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 12),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF2F5F8),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Text(
                                              'Ở lại',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  height: 20 / 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF6E87AA)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF366AE2),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Text(
                                              'Thoát',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  height: 20 / 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  Navigator.pop(context);
                }
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
            color: const Color(0xFFF5F5F5),
            child: currentTab == 0
                ? CommonInforTab(
                    roomItem: roomItem,
                    guestInfor: guestInfor,
                    resetData: () {
                      setState(() {
                        guestInfor = GuestInforItem(
                          photos: [],
                          contractPhotos: [],
                        );
                      });
                    },
                  )
                : LeaseTab(
                    guestInfor: guestInfor,
                  )),
      ),
    );
  }
}

// tab Thông tin chung
class CommonInforTab extends StatefulWidget {
  final RoomItem? roomItem;
  final GuestInforItem? guestInfor;
  final Function? resetData;
  const CommonInforTab({super.key, this.roomItem, this.guestInfor, this.resetData});

  @override
  State<CommonInforTab> createState() => _CommonInforTabState();
}

class _CommonInforTabState extends State<CommonInforTab> with TickerProviderStateMixin {
  final oCcy = NumberFormat("#,##0 (VNĐ)", "en_US");
  final TextEditingController userName = TextEditingController();
  final TextEditingController birthDay = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController cccdNumber = TextEditingController();
  final TextEditingController deposit = TextEditingController();
  final TextEditingController numberUser = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  AnimationController? controller;
  bool isSaving = false;

  Future<void> saveGuestInfor() async {
    FocusScope.of(context).unfocus();
    try {
      setState(() {
        controller = AnimationController(
          vsync: this,
          duration: const Duration(seconds: 1),
        )..addListener(() {
            if (mounted && isSaving) {
              setState(() {});
            }
          });
        controller!.repeat();
        isSaving = true;
      });
      if (widget.guestInfor?.id != null) {
        await GuestInforDA.editInfor(widget.guestInfor!);
      } else {
        await GuestInforDA.addInfor(widget.guestInfor!);
        await UserDA.addAccount(UserItem(
          roomId: widget.roomItem!.id,
          accName: widget.roomItem!.name,
          password: widget.roomItem!.name,
          userName: widget.roomItem!.name,
          role: 1,
        ));
      }
      for (var path in widget.guestInfor!.photos!.where((e) => !e.contains(widget.roomItem!.name!))) {
        await FireBaseDA.putFile(path, folder: widget.roomItem!.name);
      }
      for (var path in widget.guestInfor!.contractPhotos!.where((e) => !e.contains(widget.roomItem!.name!))) {
        await FireBaseDA.putFile(path, folder: '${widget.roomItem!.name}/contract');
      }
      widget.roomItem!.guestId = widget.guestInfor!.id;
      await RoomDA.editRoom(widget.roomItem!).then((value) {
        setState(() {
          isSaving = false;
          RoomInfor.isChange = false;
          controller?.removeListener(() {});
        });
        var newRoomItem = RoomItem.fromJson(widget.roomItem!.toJson());
        newRoomItem.id = widget.roomItem!.id;
        RoomDA.listRoom[RoomDA.listRoom.indexWhere((e) => e.id == widget.roomItem!.id)] = newRoomItem;
        if (ScaffoldMessenger.of(context).mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
            'Lưu thông tin khách thuê phòng thành công',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          )));
        }
      });
    } catch (e) {
      if (ScaffoldMessenger.of(context).mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          'Lưu thông tin khách thuê phòng không hành công',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        )));
      }
    }
  }

  @override
  void initState() {
    userName.text = widget.guestInfor?.name ?? '';
    birthDay.text = widget.guestInfor?.birthday ?? '';
    address.text = widget.guestInfor?.address ?? '';
    cccdNumber.text = widget.guestInfor?.ccNumber ?? '';
    deposit.text = oCcy.format(widget.roomItem?.deposit ?? 0);
    numberUser.text = widget.roomItem?.numberUser?.toString() ?? '0';
    startDate.text = widget.roomItem?.dateStart ?? '';

    super.initState();
  }

  @override
  void didUpdateWidget(covariant CommonInforTab oldWidget) {
    if (oldWidget.guestInfor != widget.guestInfor) {
      userName.text = widget.guestInfor?.name ?? '';
      birthDay.text = widget.guestInfor?.birthday ?? '';
      address.text = widget.guestInfor?.address ?? '';
      cccdNumber.text = widget.guestInfor?.ccNumber ?? '';
      deposit.text = oCcy.format(widget.roomItem?.deposit ?? 0);
      numberUser.text = widget.roomItem?.numberUser?.toString() ?? '0';
      startDate.text = widget.roomItem?.dateStart ?? '';
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            children: [
              // button reset
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        UserItem roomAccount = UserDA.listAccount
                            .firstWhere((e) => e.roomId == widget.roomItem?.id, orElse: () => UserItem());
                        if (roomAccount.password != null && roomAccount.password != roomAccount.accName) {
                          roomAccount.password = roomAccount.accName;
                          UserDA.editUser(roomAccount);
                        }
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
                      onTap: () async {
                        if (widget.roomItem?.guestId != null) {
                          widget.roomItem!.guestId = null;
                          await RoomDA.editRoom(widget.roomItem!);
                          await GuestInforDA.deleteInfor(widget.guestInfor!);
                          await FireBaseDA.deleteFile(widget.roomItem!.name);
                          await UserDA.deleteUser(
                              UserDA.listAccount.firstWhere((e) => e.roomId == widget.roomItem!.id).id!);
                          widget.resetData!();
                        }
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
                child: Focus(
                  onFocusChange: (value) {
                    if (!value && widget.guestInfor?.name != userName.text) {
                      widget.guestInfor!.name = userName.text;
                      RoomInfor.isChange = true;
                    }
                  },
                  child: TextFormField(
                    controller: userName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Họ và tên',
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 24 / 16,
                    ),
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
                  color: Colors.grey[200],
                ),
                child: TextFormField(
                  controller: birthDay,
                  readOnly: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'dd/mm/yyyy',
                    suffixIcon: const Icon(Icons.calendar_month),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    height: 24 / 16,
                  ),
                  onTap: () async {
                    var initDate = DateTime.now();
                    if (widget.guestInfor!.birthday != null) {
                      var split = widget.guestInfor!.birthday!.split("/");
                      initDate = DateTime(int.parse(split.last), int.parse(split[1]), int.parse(split.first));
                    }
                    var result = await showDatePicker(
                        context: context,
                        initialDate: initDate,
                        firstDate: DateTime(initDate.year - 50),
                        lastDate: DateTime(initDate.year + 50));
                    if (result != null) {
                      var stringValue =
                          "${result.day < 10 ? "0${result.day}/" : "${result.day}/"}${result.month < 10 ? "0${result.month}" : "${result.month}"}/${result.year}";
                      if (widget.guestInfor?.birthday != stringValue) {
                        birthDay.text = stringValue;
                        widget.guestInfor!.birthday = stringValue;
                        RoomInfor.isChange = true;
                      }
                    }
                  },
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
                child: Focus(
                  onFocusChange: (value) {
                    if (!value && widget.guestInfor?.address != address.text) {
                      widget.guestInfor!.address = address.text;
                      RoomInfor.isChange = true;
                    }
                  },
                  child: TextFormField(
                    controller: address,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'số nhà, Phường, Quận, Thành Phố',
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 24 / 16,
                    ),
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
                child: Focus(
                  onFocusChange: (value) {
                    if (!value && widget.guestInfor?.ccNumber != cccdNumber.text) {
                      widget.guestInfor!.ccNumber = cccdNumber.text;
                      RoomInfor.isChange = true;
                    }
                  },
                  child: TextFormField(
                    controller: cccdNumber,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'VD: 098412413213',
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 24 / 16,
                    ),
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
                  for (var path in widget.guestInfor?.photos ?? [])
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        path,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.file(
                            File(path),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset('lib/Assets/Rectangle 127.png');
                            },
                          );
                        },
                      ),
                    ),
                  InkWell(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.image);
                      if (result != null) {
                        setState(() {
                          widget.guestInfor!.photos = result.paths.cast<String>();
                          RoomInfor.isChange = true;
                        });
                      }
                    },
                    child: DottedBorder(
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
                child: Focus(
                  onFocusChange: (value) {
                    if (value) {
                      deposit.selection = TextSelection(
                          baseOffset: deposit.text.replaceAll(" (VNĐ)", "").length,
                          extentOffset: deposit.text.replaceAll(" (VNĐ)", "").length);
                    } else {
                      var newValue = int.tryParse(deposit.text.replaceAll(' (VNĐ)', '').replaceAll(',', ''));
                      if (newValue == null) {
                        deposit.text = oCcy.format(widget.roomItem?.deposit ?? 0);
                      } else if (widget.roomItem!.deposit != newValue) {
                        widget.roomItem!.deposit = newValue;
                        RoomInfor.isChange = true;
                      }
                    }
                  },
                  child: TextFormField(
                    controller: deposit,
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
                    ),
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
                  color: Colors.grey[200],
                ),
                child: TextFormField(
                  controller: startDate,
                  readOnly: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'dd/mm/yyyy',
                    suffixIcon: const Icon(Icons.calendar_month),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    height: 24 / 16,
                  ),
                  onTap: () async {
                    var initDate = DateTime.now();
                    if (widget.roomItem!.dateStart != null) {
                      var split = widget.roomItem!.dateStart!.split("/");
                      initDate = DateTime(int.parse(split.last), int.parse(split[1]), int.parse(split.first));
                    }
                    var result = await showDatePicker(
                        context: context,
                        initialDate: initDate,
                        firstDate: DateTime(initDate.year - 50),
                        lastDate: DateTime(initDate.year + 50));
                    if (result != null) {
                      var stringValue =
                          "${result.day < 10 ? "0${result.day}/" : "${result.day}/"}${result.month < 10 ? "0${result.month}" : "${result.month}"}/${result.year}";
                      if (widget.roomItem!.dateStart != stringValue) {
                        startDate.text = stringValue;
                        widget.roomItem!.dateStart = stringValue;
                        RoomInfor.isChange = true;
                      }
                    }
                  },
                ),
              ),
              // input số người thuê
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: const Text(
                  'Số người',
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
                child: Focus(
                  onFocusChange: (value) {
                    if (!value && widget.roomItem!.numberUser != int.parse(numberUser.text)) {
                      widget.roomItem!.numberUser = int.parse(numberUser.text);
                      RoomInfor.isChange = true;
                    }
                  },
                  child: TextFormField(
                    controller: numberUser,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'VD: 3',
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 24 / 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // button Lưu
        Builder(builder: (context) {
          bool isEnable = false;
          if (RoomInfor.isChange) {
            isEnable = userName.text.isNotEmpty &&
                address.text.isNotEmpty &&
                birthDay.text.isNotEmpty &&
                cccdNumber.text.isNotEmpty &&
                numberUser.text.isNotEmpty &&
                deposit.text.isNotEmpty &&
                startDate.text.isNotEmpty &&
                widget.guestInfor!.photos!.isNotEmpty;
          }
          return Container(
            color: Colors.white,
            width: double.infinity,
            child: InkWell(
              onTap: isEnable ? saveGuestInfor : null,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isEnable ? const Color(0xFF1890FF) : const Color(0xFFF5F5F5),
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
                        'Lưu',
                        style: TextStyle(
                          fontSize: 14,
                          height: 22 / 14,
                          color: isEnable ? Colors.white : const Color(0xFF8C8C8C),
                        ),
                      ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class MoneyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String convertText = '';
    try {
      final oCcy = NumberFormat("#,##0", "en_US");
      convertText = oCcy.format(int.tryParse(newValue.text.replaceAll(",", "").replaceAll(" (VNĐ)", "")));
      // ignore: empty_catches
    } catch (e) {}
    var convertValue = TextEditingValue(
        selection: TextSelection(baseOffset: convertText.length, extentOffset: convertText.length),
        text: '$convertText (VNĐ)');
    return convertValue;
  }
}

// tab Hợp đồng thuê nhà
class LeaseTab extends StatefulWidget {
  final GuestInforItem? guestInfor;
  const LeaseTab({super.key, this.guestInfor});

  @override
  State<LeaseTab> createState() => _LeaseTabState();
}

class _LeaseTabState extends State<LeaseTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (var path in widget.guestInfor!.contractPhotos ?? [])
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Image.network(
              path,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.file(File(path), fit: BoxFit.cover);
              },
            ),
          ),
        Center(
          child: InkWell(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true);
              if (result != null) {
                setState(() {
                  widget.guestInfor!.contractPhotos!.addAll([...result.paths.cast<String>()]);
                  RoomInfor.isChange = true;
                });
              }
            },
            child: DottedBorder(
              borderType: BorderType.RRect,
              color: const Color(0xFF1890FF),
              radius: const Radius.circular(8),
              child: Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.add,
                  size: 44,
                  color: Color(0xFF1890FF),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
