import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController messEdit = TextEditingController();
  final FocusNode messFocus = FocusNode();

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
            'Liên hệ',
            style: TextStyle(
              fontSize: 16,
              height: 24 / 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF262626),
            ),
          ),
        ),
        body: Container(
          color: const Color(0xFFF2F5F8),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: messFocus.hasFocus ? CrossAxisAlignment.end : CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 16, bottom: messFocus.hasFocus ? 8 : 0),
                      child: SvgPicture.asset('lib/Assets/image.svg'),
                    ),
                    Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: messFocus.hasFocus ? 60 : 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F5F8),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFFE5EAF0),
                          ),
                        ),
                        child: Focus(
                          onFocusChange: (value) {
                            setState(() {});
                          },
                          child: TextField(
                            controller: messEdit,
                            focusNode: messFocus,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nhập tin nhắn...',
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                            textAlignVertical: messFocus.hasFocus ? TextAlignVertical.top : TextAlignVertical.center,
                            expands: true,
                            maxLines: null,
                            minLines: null,
                            style: const TextStyle(fontSize: 14, height: 22 / 14),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8, bottom: messFocus.hasFocus ? 8 : 0),
                      child: InkWell(
                        onTap: () {},
                        child: SvgPicture.asset('lib/Assets/send-message.svg'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
