import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project1/Module/guest_infor_item.dart';
import 'package:project1/Module/message_item.dart';
import 'package:project1/Module/user_item.dart';

class ContactScreen extends StatefulWidget {
  final GuestInforItem? guestInfor;
  const ContactScreen({super.key, this.guestInfor});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController messEdit = TextEditingController();
  final FocusNode messFocus = FocusNode();
  List<MessageItem> listMessage = [];

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
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(MessageDA.collection)
                .doc(widget.guestInfor!.messageId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                listMessage = MessageHistoryItem.fromJson(snapshot.data!.data()!).listMessage;
              }
              return Container(
                color: const Color(0xFFF2F5F8),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: ListView.builder(
                          itemCount: listMessage.length,
                          itemBuilder: (context, index) {
                            return listMessage[index].userId == UserDA.user!.id
                                ? Container(
                                    margin: EdgeInsets.only(bottom: 16, left: MediaQuery.of(context).size.width * 0.2),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(bottom: 8),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF1890FF),
                                            border: Border.all(color: const Color(0xFFBAE7FF)),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            listMessage[index].message!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              height: 22 / 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          listMessage[index].time!,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 16 / 12,
                                            color: Color(0xFF6E87AA),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(bottom: 16, right: MediaQuery.of(context).size.width * 0.2),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 32,
                                          height: 32,
                                          margin: const EdgeInsets.only(right: 12, top: 2),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child:
                                              index == 0 || listMessage[index].userId != listMessage[index - 1].userId
                                                  ? Image.asset('lib/Assets/Image demo.png')
                                                  : null,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(bottom: 8),
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(color: const Color(0xFFBAE7FF)),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  listMessage[index].message!,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    height: 22 / 14,
                                                    color: Color(0xFF4B6281),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                listMessage[index].time!,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  height: 16 / 12,
                                                  color: Color(0xFF6E87AA),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        ),
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
                                  textAlignVertical:
                                      messFocus.hasFocus ? TextAlignVertical.top : TextAlignVertical.center,
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
                              onTap: () {
                                if (messEdit.text.isNotEmpty) {
                                  FirebaseFirestore.instance.runTransaction((transaction) async {
                                    DocumentSnapshot freshSnap = await transaction.get(snapshot.data!.reference);
                                    var now = DateTime.now();
                                    listMessage.add(MessageItem(
                                      message: messEdit.text,
                                      userId: UserDA.user!.id,
                                      time:
                                          '${now.day < 10 ? "0${now.day}" : now.day}/${now.month < 10 ? "0${now.month}" : now.month}/${now.year} • ${now.hour < 10 ? "0${now.hour}" : now.hour}:${now.minute < 10 ? "0${now.minute}" : now.minute}',
                                    ));
                                    transaction.set(
                                        freshSnap.reference, MessageHistoryItem(listMessage: listMessage).toJson());
                                    messEdit.text = '';
                                  });
                                }
                              },
                              child: SvgPicture.asset('lib/Assets/send-message.svg'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
