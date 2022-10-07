import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project1/Module/room_item.dart';
import 'package:project1/View/contact_screen.dart';

class ListMessage extends StatefulWidget {
  const ListMessage({super.key});

  @override
  State<ListMessage> createState() => _ListMessageState();
}

class _ListMessageState extends State<ListMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.1,
        toolbarHeight: 48,
        backgroundColor: Colors.white,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
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
        color: const Color(0xFFF5F5F5),
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: RoomDA.listRoom.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactScreen(),
                    ));
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(12),
                ),
                child: Row(
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
                            'Phòng ${RoomDA.listRoom[index].name}',
                            style: const TextStyle(
                              fontSize: 16,
                              height: 24 / 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF262626),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            child: const Text(
                              'tin nhắn mới',
                              style: TextStyle(
                                fontSize: 14,
                                height: 22 / 14,
                                color: Color(0xFF8C8C8C),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF40A9FF)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
