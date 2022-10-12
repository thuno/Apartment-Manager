import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project1/Module/user_item.dart';

class ChangePaswword extends StatefulWidget {
  const ChangePaswword({super.key});

  @override
  State<ChangePaswword> createState() => _ChangePaswwordState();
}

class _ChangePaswwordState extends State<ChangePaswword> with TickerProviderStateMixin {
  final TextEditingController editOldPass = TextEditingController();
  final FocusNode focusOldPass = FocusNode();
  String errorPass = '';
  bool showOldPass = false;
  final TextEditingController editNewPass = TextEditingController();
  final FocusNode focusNewPass = FocusNode();
  String errorNewPass = '';
  bool showNewPass = false;
  final TextEditingController editRepeatPass = TextEditingController();
  final FocusNode focusRepeatPass = FocusNode();
  String errorRepeat = '';
  bool showRepeatPass = false;
  AnimationController? controller;
  bool isLoading = false;
  bool isChange = false;

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
          elevation: 0.1,
          toolbarHeight: 48,
          backgroundColor: Colors.white,
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
            'Đổi mật khẩu ',
            style: TextStyle(
              fontSize: 16,
              height: 24 / 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF262626),
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 56,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: errorPass == ''
                          ? focusOldPass.hasFocus
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
                    controller: editOldPass,
                    onChanged: (value) {
                      setState(() {
                        errorPass = '';
                      });
                    },
                    focusNode: focusOldPass,
                    obscureText: !showOldPass,
                    decoration: InputDecoration(
                      hintText: 'Mật khẩu cũ',
                      isDense: true,
                      contentPadding: const EdgeInsets.all(16),
                      border: InputBorder.none,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            showOldPass = !showOldPass;
                          });
                        },
                        child: Icon(
                          showOldPass ? Icons.visibility : Icons.visibility_off,
                          color: const Color(0xFF6E87AA),
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 22 / 16,
                    ),
                  ),
                ),
              ),
              Text(
                errorPass,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFE00000),
                ),
              ),
              Container(
                height: 56,
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: errorNewPass == ''
                          ? focusNewPass.hasFocus
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
                    controller: editNewPass,
                    onChanged: (value) {
                      setState(() {
                        errorNewPass = '';
                      });
                    },
                    focusNode: focusNewPass,
                    obscureText: !showNewPass,
                    decoration: InputDecoration(
                      hintText: 'Mật khẩu mới',
                      isDense: true,
                      contentPadding: const EdgeInsets.all(16),
                      border: InputBorder.none,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            showNewPass = !showNewPass;
                          });
                        },
                        child: Icon(
                          showNewPass ? Icons.visibility : Icons.visibility_off,
                          color: const Color(0xFF6E87AA),
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 22 / 16,
                    ),
                  ),
                ),
              ),
              Text(
                errorNewPass,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFE00000),
                ),
              ),
              Container(
                height: 56,
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: errorRepeat == ''
                          ? focusRepeatPass.hasFocus
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
                    controller: editRepeatPass,
                    onChanged: (value) {
                      setState(() {
                        errorRepeat = '';
                      });
                    },
                    focusNode: focusRepeatPass,
                    obscureText: !showRepeatPass,
                    decoration: InputDecoration(
                      hintText: 'Xác nhận lại mật khẩu',
                      isDense: true,
                      contentPadding: const EdgeInsets.all(16),
                      border: InputBorder.none,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            showRepeatPass = !showRepeatPass;
                          });
                        },
                        child: Icon(
                          showRepeatPass ? Icons.visibility : Icons.visibility_off,
                          color: const Color(0xFF6E87AA),
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 22 / 16,
                    ),
                  ),
                ),
              ),
              Text(
                errorRepeat,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFE00000),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: isLoading
                        ? null
                        : () async {
                            try {
                              setState(() {
                                if (editOldPass.text.isEmpty) {
                                  errorPass = 'Nhập mật khẩu cũ';
                                } else if (editOldPass.text != UserDA.user!.password) {
                                  errorPass = 'Mật khẩu không đúng';
                                }
                                if (editNewPass.text.isEmpty) {
                                  errorNewPass = 'Nhập mật khẩu mới';
                                } else {
                                  if (editNewPass.text != editRepeatPass.text) {
                                    errorRepeat = 'Mật khẩu xác nhận không trùng khớp';
                                  }
                                }
                              });
                              if (errorPass.isEmpty && errorNewPass.isEmpty && errorRepeat.isEmpty) {
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
                                UserDA.user!.password = editNewPass.text;
                                await UserDA.editUser(UserDA.user!).then((_) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (ScaffoldMessenger.of(context).mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        content: Text(
                                      'Thay đổi mật khẩu thành công',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    )));
                                  }
                                });
                              }
                            } catch (e) {
                              if (ScaffoldMessenger.of(context).mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text(
                                  'Thay đổi mật khẩu  không thành công',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                )));
                              }
                            }
                          },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF366AE2),
                        borderRadius: BorderRadius.circular(8),
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
                          : const Text(
                              'Đăng nhập',
                              style: TextStyle(fontSize: 14, height: 22 / 14, color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
