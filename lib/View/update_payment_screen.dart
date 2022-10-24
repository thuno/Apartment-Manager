import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project1/Firebase/database_store.dart';
import 'package:project1/Module/payment_infor_item.dart';

class UpdatePayment extends StatefulWidget {
  const UpdatePayment({super.key});

  @override
  State<UpdatePayment> createState() => _UpdatePaymentState();
}

class _UpdatePaymentState extends State<UpdatePayment> with TickerProviderStateMixin {
  final TextEditingController editName = TextEditingController();
  final TextEditingController editStk = TextEditingController();
  String? bank;
  bool isChange = false;
  bool isLoading = false;
  PaymentItem paymentItem = PaymentItem();
  AnimationController? controller;
  bool isShowDelete = false;

  @override
  void initState() {
    PaymentDA.getListPayment().then((_) async {
      if (PaymentDA.listPayment.isNotEmpty) {
        paymentItem = PaymentDA.listPayment.first;
        var paths = await FireBaseDA.getFiles(paymentItem.qrPhoto);
        if (paths.isNotEmpty) {
          paymentItem.qrPhotoLink = paths.single;
        }
        bank = paymentItem.bank;
        editName.text = paymentItem.userName!;
        editStk.text = paymentItem.stk!;
        setState(() {});
      }
    });
    super.initState();
  }

  Future<void> saveData() async {
    try {
      setState(() {
        isLoading = true;
        controller = AnimationController(
          vsync: this,
          duration: const Duration(seconds: 1),
        )..addListener(() {
            if (mounted && isLoading) {
              setState(() {});
            }
          });
        controller!.repeat();
      });
      if (paymentItem.id == null) {
        if (paymentItem.qrPhoto != null) {
          await FireBaseDA.putFile(paymentItem.qrPhoto!, folder: 'Payment');
          paymentItem.qrPhoto = 'Payment/${paymentItem.qrPhoto!.split('/').last}';
        }
        await PaymentDA.add(paymentItem);
      } else {
        await PaymentDA.edit(paymentItem);
      }
      setState(() {
        controller!.removeListener(() {});
        isLoading = false;
        isChange = false;
        controller?.removeListener(() {});
        if (ScaffoldMessenger.of(context).mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
            'Lưu thông tin thanh toán thành công',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          )));
        }
      });
    } catch (e) {
      if (ScaffoldMessenger.of(context).mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          'Lưu thông tin thanh toán không thành công',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          isShowDelete = false;
        });
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F5F8),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 48,
          backgroundColor: Colors.white,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
          centerTitle: true,
          title: const Text(
            'Thông tin thanh toán',
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
                if (isChange) {
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
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'Ngân hàng thụ hưởng',
                    style: TextStyle(
                      fontSize: 16,
                      height: 24 / 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF394960),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      String? result = await showModalBottomSheet(
                        context: context,
                        isDismissible: false,
                        enableDrag: false,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return const ShowListBank();
                        },
                      );
                      if (result != null && result != paymentItem.bank) {
                        setState(() {
                          bank = result;
                          paymentItem.bank = bank;
                          isChange = true;
                        });
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF394960),
                        ),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            bank ?? 'Chọn ngân hàng',
                            style: const TextStyle(
                              fontSize: 14,
                              height: 22 / 14,
                              color: Color(0xFF394960),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF394960),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Text(
                    'Tên chủ tài khoản',
                    style: TextStyle(
                      fontSize: 16,
                      height: 24 / 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF394960),
                    ),
                  ),
                  Container(
                    height: 64,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Focus(
                      onFocusChange: (value) {
                        if (!value && editName.text.isNotEmpty && paymentItem.userName != editName.text) {
                          paymentItem.userName = editName.text;
                          isChange = true;
                        }
                      },
                      child: TextFormField(
                        controller: editName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'VD: Nguyễn Văn A',
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          height: 24 / 16,
                          color: Color(0xFF394960),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Số tài khoản',
                    style: TextStyle(
                      fontSize: 16,
                      height: 24 / 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF394960),
                    ),
                  ),
                  Container(
                    height: 64,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Focus(
                      onFocusChange: (value) {
                        if (!value && editStk.text.isNotEmpty && paymentItem.stk != editStk.text) {
                          paymentItem.stk = editStk.text;
                          isChange = true;
                        }
                      },
                      child: TextFormField(
                        controller: editStk,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'VD: 0369696999',
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          height: 24 / 16,
                          color: Color(0xFF394960),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Ảnh QR Code',
                    style: TextStyle(
                      fontSize: 16,
                      height: 24 / 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF394960),
                    ),
                  ),
                  const SizedBox(height: 16),
                  paymentItem.qrPhoto == null
                      ? InkWell(
                          onTap: () async {
                            FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
                            if (result != null) {
                              setState(() {
                                paymentItem.qrPhoto = result.paths.single;
                                isChange = true;
                              });
                            }
                          },
                          child: Row(
                            children: [
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
                        )
                      : GestureDetector(
                          onLongPress: isShowDelete
                              ? null
                              : () {
                                  setState(() {
                                    isShowDelete = true;
                                  });
                                },
                          child: Stack(
                            children: [
                              Image.network(
                                paymentItem.qrPhotoLink ?? paymentItem.qrPhoto!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.file(
                                    File(paymentItem.qrPhoto!),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset('lib/Assets/Rectangle 127.png');
                                    },
                                  );
                                },
                              ),
                              if (isShowDelete)
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        paymentItem.qrPhoto = null;
                                        isChange = true;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[100],
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        size: 20,
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
            Builder(builder: (context) {
              bool isEnable = false;
              if (editName.text.isNotEmpty && bank != null && editStk.text.isNotEmpty) {
                isEnable = true;
              }
              return Container(
                color: Colors.white,
                width: double.infinity,
                child: InkWell(
                  onTap: isEnable ? saveData : null,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: isEnable ? const Color(0xFF1890FF) : const Color(0xFFF5F5F5),
                    ),
                    child: isLoading
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
        ),
      ),
    );
  }
}

class ShowListBank extends StatefulWidget {
  const ShowListBank({super.key});

  @override
  State<ShowListBank> createState() => _ShowListBankState();
}

class _ShowListBankState extends State<ShowListBank> {
  List<String> listSearch = [];

  @override
  void initState() {
    listSearch = PaymentDA.listBank;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0.1,
              toolbarHeight: 96,
              backgroundColor: Colors.white,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
              centerTitle: true,
              title: const Text(
                'Ngân hàng thụ hưởng',
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
                padding: const EdgeInsets.only(top: 14),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close_sharp,
                    size: 20,
                    color: Color(0xFF4B6281),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm',
                      prefixIcon: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: const Icon(Icons.search),
                      ),
                      prefixIconConstraints: const BoxConstraints(),
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      isDense: true,
                    ),
                    onChanged: (value) {
                      setState(() {
                        listSearch =
                            PaymentDA.listBank.where((e) => e.toLowerCase().contains(value.toLowerCase())).toList();
                      });
                    },
                  ),
                ),
              ),
            ),
            body: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: listSearch.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context, listSearch[index]);
                  },
                  child: Container(
                    padding: index == 0
                        ? const EdgeInsets.fromLTRB(8, 0, 16, 8)
                        : const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.5),
                      ),
                    ),
                    child: Text(
                      listSearch[index],
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 23 / 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF262626),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
