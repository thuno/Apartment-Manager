import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project1/Module/message_item.dart';
import 'package:project1/Module/room_item.dart';
import 'package:project1/Module/user_item.dart';
import 'package:project1/View/contact_screen.dart';

import '../Module/guest_infor_item.dart';

class ListMessage extends StatefulWidget {
  const ListMessage({super.key});

  @override
  State<ListMessage> createState() => _ListMessageState();
}

class _ListMessageState extends State<ListMessage> {
  @override
  Widget build(BuildContext context) {
    List<RoomItem> listRoomContact = RoomDA.listRoom.where((e) => e.guestId != null).toList();
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
        child: listRoomContact.isEmpty
            ? const Center(
                child: Text(
                  'Tất cả các phòng đều đang trống!',
                  style: TextStyle(
                    fontSize: 20,
                    height: 28 / 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6E87AA),
                  ),
                ),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: listRoomContact.length,
                itemBuilder: (context, index) {
                  var guestInfor =
                      GuestInforDA.guestInforList.firstWhere((e) => e.id == listRoomContact[index].guestId);
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactScreen(guestInfor: guestInfor),
                          ));
                    },
                    child: MessageStatusTile(
                      title: listRoomContact[index].name,
                      guestInfor: guestInfor,
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class MessageStatusTile extends StatefulWidget {
  final String? title;
  final GuestInforItem? guestInfor;
  const MessageStatusTile({super.key, this.title, this.guestInfor});

  @override
  State<MessageStatusTile> createState() => _MessageStatusTileState();
}

class _MessageStatusTileState extends State<MessageStatusTile> {
  MessageHistoryItem messHistory = MessageHistoryItem(
    listMessage: [],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(12),
      ),
      child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection(MessageDA.collection).doc(widget.guestInfor!.messageId).snapshots(),
          builder: (context, snapshot) {
            bool isNew = false;
            if (snapshot.hasData) {
              var result = MessageHistoryItem.fromJson(snapshot.data!.data()!).listMessage;
              messHistory.listMessage = result;
              if (result.isNotEmpty) {
                isNew = !messHistory.listMessage.last.isSeen && messHistory.listMessage.last.userId != UserDA.user!.id;
              }
            }
            return Row(
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
                        'Phòng ${widget.title}',
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
                          messHistory.listMessage.isEmpty ? '' : messHistory.listMessage.last.message!,
                          style: TextStyle(
                            fontSize: 14,
                            height: 22 / 14,
                            fontWeight: isNew ? FontWeight.w600 : FontWeight.w400,
                            color: const Color(0xFF8C8C8C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: isNew ? const Color(0xFF40A9FF) : Colors.transparent),
                ),
              ],
            );
          }),
    );
  }
}
