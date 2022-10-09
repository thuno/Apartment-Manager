import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:project1/Module/room_item.dart';
import 'package:project1/View/room_infor_screen.dart';
import 'package:project1/View/update_cost_screen.dart';

import '../Module/user_item.dart';

class MangeHouse extends StatefulWidget {
  const MangeHouse({super.key});

  @override
  State<MangeHouse> createState() => _MangeHouseState();
}

class _MangeHouseState extends State<MangeHouse> {
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 48,
        backgroundColor: Colors.white,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
        centerTitle: true,
        title: const Text(
          'Quản lý nhà',
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
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () async {
                await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return const DialogCreateRoom();
                  },
                );
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.add,
                  color: Color(0xFF4B6281),
                  size: 22,
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: const Color(0xFFF2F5F8),
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: RoomDA.listRoom.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              RoomDA.listRoom[index].name!,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 24 / 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF262626),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              child: Text(
                                RoomDA.listRoom[index].dateStart == null
                                    ? "Phòng trống"
                                    : 'Bắt đầu thuê từ: ${RoomDA.listRoom[index].dateStart}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  height: 22 / 14,
                                  color: Color(0xFF8C8C8C),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return DialogCreateRoom(
                                isAdd: false,
                                roomItem: RoomDA.listRoom[index],
                              );
                            },
                          );
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: const Icon(Icons.mode_edit_outlined, color: Color(0xFF1890FF)),
                        ),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () async {
                          await showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                insetPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                child: IntrinsicHeight(
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                    margin: const EdgeInsets.symmetric(horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                                          child: Text(
                                            'Bạn có chắc chắn muốn xóa thông tin phòng ${RoomDA.listRoom[index].name}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              height: 22 / 16,
                                              color: Color(0xFF262626),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFFF2F5F8),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: const Text(
                                                    'Thoát',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        height: 20 / 14,
                                                        fontWeight: FontWeight.w500,
                                                        color: Color(0xFF6E87AA)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  await RoomDA.deleteRoom(RoomDA.listRoom[index]).then(
                                                    (value) {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFF366AE2),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: const Text(
                                                    'Xác nhận',
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
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red[300],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        SvgPicture.asset('lib/Assets/user-multiple.svg'),
                        Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: Text(
                            'Số người: ${RoomDA.listRoom[index].numberUser}',
                            style: const TextStyle(
                              fontSize: 14,
                              height: 22 / 14,
                              color: Color(0xFF262626),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        SvgPicture.asset('lib/Assets/deposit.svg'),
                        Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: Text(
                            'Tiền cọc: ${oCcy.format(RoomDA.listRoom[index].deposit ?? 0)} VNĐ',
                            style: const TextStyle(
                              fontSize: 14,
                              height: 22 / 14,
                              color: Color(0xFF262626),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RoomInfor(
                                    roomItem: RoomDA.listRoom[index],
                                  )));
                      setState(() {});
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFE6F7FF),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        'Xem chi tiết',
                        style: TextStyle(
                          fontSize: 14,
                          height: 22 / 14,
                          color: Color(0xFF1890FF),
                        ),
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
      bottomNavigationBar: RoomDA.listRoom.isEmpty
          ? null
          : InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpdateCost(),
                    ));
              },
              child: Container(
                height: 40,
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF366AE2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Cập nhật tiền phòng',
                  style: TextStyle(fontSize: 14, height: 22 / 14, color: Colors.white),
                ),
              ),
            ),
    );
  }
}

class DialogCreateRoom extends StatefulWidget {
  final bool isAdd;
  final RoomItem? roomItem;
  const DialogCreateRoom({super.key, this.isAdd = true, this.roomItem});

  @override
  State<DialogCreateRoom> createState() => _DialogCreateRoomState();
}

class _DialogCreateRoomState extends State<DialogCreateRoom> {
  final TextEditingController editName = TextEditingController();
  final FocusNode focusNode = FocusNode();
  String errorText = '';

  @override
  void initState() {
    editName.text = widget.roomItem?.name ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: IntrinsicHeight(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isAdd ? 'Tạo phòng mới' : 'Sửa tên phòng',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600, height: 22 / 16, color: Color(0xFF262626)),
              ),
              Container(
                height: 56,
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F5F8),
                  border: Border.all(
                      width: 1.5,
                      color: errorText == ''
                          ? focusNode.hasFocus
                              ? const Color(0xFF1890FF)
                              : const Color(0xFFE5EAF0)
                          : const Color(0xFFE00000)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Focus(
                  onFocusChange: (value) {
                    setState(() {});
                  },
                  child: TextFormField(
                    controller: editName,
                    onChanged: (value) {
                      setState(() {
                        errorText = '';
                      });
                    },
                    focusNode: focusNode,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Số phòng',
                      isDense: true,
                      contentPadding: EdgeInsets.all(16),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 22 / 16,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Text(
                  errorText,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFE00000),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F5F8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Thoát',
                        style: TextStyle(
                            fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w500, color: Color(0xFF6E87AA)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () async {
                      if (editName.text == '') {
                        setState(() {
                          errorText = "Số phòng không được để trống";
                        });
                      } else {
                        if (widget.isAdd) {
                          RoomItem newRoom = RoomItem.fromJson(RoomDA.defaultRoom.toJson());
                          newRoom.name = editName.text;
                          await RoomDA.addRoom(newRoom).then((value) => Navigator.pop(context));
                        } else {
                          if (editName.text != widget.roomItem?.name) {
                            widget.roomItem!.name = editName.text;
                            await RoomDA.editRoom(widget.roomItem!).then((_) => Navigator.pop(context));
                          }
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF366AE2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Xác nhận',
                        style:
                            TextStyle(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
