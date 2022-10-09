import 'package:project1/Module/message_item.dart';

import '../Firebase/database_store.dart';

class GuestInforItem {
  String? id;
  String? name;
  String? birthday;
  String? address;
  String? ccNumber;
  List<String>? photos;
  String? contractPhoto;
  String? messageId;

  GuestInforItem(
      {this.id,
      this.name,
      this.birthday,
      this.address,
      this.ccNumber,
      this.photos,
      this.contractPhoto,
      this.messageId});

  static GuestInforItem fromJson(Map<String, dynamic> json) {
    return GuestInforItem(
      id: json['ID'],
      name: json['Name'],
      birthday: json['BirthDay'],
      address: json['Address'],
      ccNumber: json['CCCD'],
      messageId: json['MessageID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'BirthDay': birthday,
      'Address': address,
      'CCCD': ccNumber,
      'MessageID': messageId,
    };
  }
}

class GuestInforDA {
  static String collection = "GuestInfor";
  static List<GuestInforItem> guestInforList = [];

  static Future<void> getListGuestInfor() async {
    var listData = await FireBaseDA.getColData(collection);
    guestInforList = listData.map((e) => GuestInforItem.fromJson(e)).toList();
  }

  static Future<GuestInforItem> getInfor(String guestID) async {
    var result = await FireBaseDA.getDocData(collection, guestID);
    GuestInforItem guestInfor = GuestInforItem.fromJson(result);
    guestInfor.id = guestID;
    return guestInfor;
  }

  static Future<void> addInfor(GuestInforItem guestInfor) async {
    var historyMessage = MessageHistoryItem();
    await MessageDA.addMessHistory(historyMessage);
    guestInfor.messageId = historyMessage.id;
    var newID = await FireBaseDA.add(collection, guestInfor.toJson());
    guestInfor.id = newID;
    guestInforList.add(guestInfor);
  }

  static Future<void> editInfor(GuestInforItem guestInfor) async {
    await FireBaseDA.edit(collection, guestInfor.id!, guestInfor.toJson());
    guestInforList[guestInforList.indexWhere((e) => e.id == guestInfor.id)] = guestInfor;
  }

  static Future<void> deleteInfor(GuestInforItem guestInfor) async {
    await FireBaseDA.delete(collection, guestInfor.id!);
    guestInforList.removeWhere((e) => e.id == guestInfor.id);
    if (guestInfor.messageId != null) {
      MessageDA.deleteMessHistory(guestInfor.messageId!);
    }
  }
}
