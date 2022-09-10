import 'package:flutter/material.dart';
import 'package:project1/View/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _editRoom = TextEditingController();
  final FocusNode _roomFocus = FocusNode();
  final TextEditingController _editPass = TextEditingController();
  final FocusNode _passFocus = FocusNode();
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double scrH = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.only(top: 0.18 * scrH),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Đăng nhập',
                  style:
                      TextStyle(fontSize: 38, height: 48 / 38, fontWeight: FontWeight.w600, color: Color(0xFF1C2430)),
                ),
                Container(
                  height: 56,
                  margin: const EdgeInsets.only(top: 24),
                  child: TextFormField(
                    focusNode: _roomFocus,
                    controller: _editRoom,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Số phòng',
                      isDense: true,
                      contentPadding: EdgeInsets.all(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color(0xFFE5EAF0)),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 22 / 16,
                    ),
                  ),
                ),
                Container(
                  height: 56,
                  margin: const EdgeInsets.only(top: 20, bottom: 12),
                  child: TextFormField(
                    focusNode: _passFocus,
                    controller: _editPass,
                    // validator: (value) {},
                    decoration: const InputDecoration(
                      hintText: 'Mật khẩu',
                      isDense: true,
                      contentPadding: EdgeInsets.all(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color(0xFFE5EAF0)),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 22 / 16,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (v) {},
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
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
                        child: const Text(
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
      ),
    );
  }
}
