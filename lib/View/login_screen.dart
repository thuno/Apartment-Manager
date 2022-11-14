import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Module/room_item.dart';
import '../Module/user_item.dart';
import 'guest_navigation_screen.dart';
import 'owner_navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _editRoom = TextEditingController();
  final FocusNode _focusRoom = FocusNode();
  final TextEditingController _editPass = TextEditingController();
  final FocusNode _focusPass = FocusNode();
  String roomError = '';
  String passError = '';
  bool isLoading = false;
  AnimationController? controller;
  bool saveLogin = true;

  @override
  void initState() {
    // lấy danh sách các tài khoản tồn tại trên firebase
    UserDA.getListAccount();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // biến lưu kích tước màn hìn đt
    Size scr = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        // unfocus textfield
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: scr.width,
          child: Stack(
            children: [
              Positioned.fill(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0.16 * scr.height),
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(
                            fontSize: 38, height: 48 / 38, fontWeight: FontWeight.w600, color: Color(0xFF1C2430)),
                      ),
                    ),
                    Container(
                      height: 56,
                      margin: const EdgeInsets.only(top: 24, bottom: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: roomError == ''
                                ? _focusRoom.hasFocus
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
                          controller: _editRoom,
                          onChanged: (value) {
                            setState(() {
                              roomError = '';
                            });
                          },
                          focusNode: _focusRoom,
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
                    Text(
                      roomError,
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
                            color: passError == ''
                                ? _focusPass.hasFocus
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
                          controller: _editPass,
                          onChanged: (value) {
                            setState(() {
                              passError = '';
                            });
                          },
                          focusNode: _focusPass,
                          decoration: const InputDecoration(
                            hintText: 'Mật khẩu',
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
                    Text(
                      passError,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFE00000),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: saveLogin,
                          onChanged: (v) {
                            setState(() {
                              saveLogin = !saveLogin;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const Text(
                          'Ghi nhớ đăng nhập',
                          style: TextStyle(fontSize: 14, height: 22 / 14, color: Color(0xFF394960)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 16,
                right: 16,
                child: InkWell(
                  onTap: isLoading
                      ? null
                      : () async {
                          var validAcc = UserDA.listAccount.where((user) => user.accName == _editRoom.text);
                          if (validAcc.isEmpty) {
                            setState(() {
                              roomError = "Tài khoản không tồn tại";
                            });
                          } else {
                            var user = validAcc.single;
                            if (user.password != _editPass.text) {
                              setState(() {
                                passError = "Mật khẩu không hợp lệ";
                              });
                            } else {
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

                              if (saveLogin) {
                                SharedPreferences store = await _prefs;
                                // lưu id của người dùng ở lần đăng nhập này & thời gian đăng nhập
                                await store.setString('timer', DateTime.now().toString());
                                await store.setString('userID', user.roomId!);
                              }
                              UserDA.user = UserDA.listAccount.firstWhere(
                                (e) => e.roomId == user.roomId,
                                orElse: () => UserItem(),
                              );
                              // role = 0 là guest, role = 1 là admin
                              if (user.role == 0) {
                                await RoomDA.getListRoom().then(
                                  (value) => Navigator.pushReplacement(
                                      context, MaterialPageRoute(builder: (context) => const OwnerNavigationScreen())),
                                );
                              } else {
                                await RoomDA.getRoomInfor(user.roomId!).then((value) => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GuestNavigationScreen(
                                          roomItem: value,
                                        ),
                                      ),
                                    ));
                              }
                              controller?.removeListener(() {});
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
            ],
          ),
        ),
      ),
    );
  }
}
