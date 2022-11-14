import '../Firebase/database_store.dart';
import 'bill_item.dart';
import 'guest_infor_item.dart';
import 'user_item.dart';

class RoomItem {
  String? id;
  String? name;
  int? numberUser;
  bool? payementStatus;
  int? deposit;
  String? dateStart;
  String? guestId;
  String? lastBillId;
  BillItem? lastBill;

  RoomItem({
    this.id,
    this.name,
    this.numberUser,
    this.payementStatus,
    this.guestId,
    this.deposit,
    this.dateStart,
    this.lastBillId,
    this.lastBill,
  });

  static RoomItem fromJson(Map<String, dynamic> json) {
    return RoomItem(
      id: json['ID'],
      name: json['Name'],
      numberUser: json['NumberUser'] ?? 0,
      payementStatus: json['PayementStatus'] ?? false,
      guestId: json['GuestID'],
      deposit: json['Deposit'],
      dateStart: json['DateStart'],
      lastBillId: json['LastBillID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'NumberUser': numberUser,
      'PayementStatus': payementStatus,
      'GuestID': guestId,
      'Deposit': deposit,
      'DateStart': dateStart,
      'LastBillID': lastBillId,
    };
  }
}

class RoomDA {
  static String collection = "Room";
  static List<RoomItem> listRoom = [];

  static Future<RoomItem> getRoomInfor(String id) async {
    var resut = await FireBaseDA.getDocData(collection, id);
    var roomItem = RoomItem.fromJson(resut);
    roomItem.id = id;
    return roomItem;
  }

  static Future<void> getListRoom() async {
    var listData = await FireBaseDA.getColData(collection);
    listRoom = listData.map((e) => RoomItem.fromJson(e)).toList();
    await GuestInforDA.getListGuestInfor();
  }

  static Future<void> addRoom(RoomItem newRoom) async {
    var newID = await FireBaseDA.add(collection, newRoom.toJson());
    newRoom.id = newID;
    listRoom.add(newRoom);
  }

  static Future<void> editRoom(RoomItem roomItem) async {
    await FireBaseDA.edit(collection, roomItem.id!, roomItem.toJson());
    listRoom[listRoom.indexWhere((element) => element.id == roomItem.id)] = roomItem;
  }

  static Future<void> deleteRoom(RoomItem roomItem) async {
    await FireBaseDA.delete(collection, roomItem.id!);
    String? accountId = UserDA.listAccount.firstWhere((e) => e.roomId == roomItem.id, orElse: () => UserItem()).id;
    if (accountId != null) {
      await UserDA.deleteUser(accountId);
    }
    await FireBaseDA.deleteCol(collection + roomItem.name!);
    if (roomItem.guestId != null) {
      await GuestInforDA.deleteInfor(GuestInforDA.guestInforList.firstWhere((e) => e.id == roomItem.guestId));
      await FireBaseDA.deleteFile(roomItem.name);
    }
    listRoom.removeWhere((element) => element.id == roomItem.id);
  }
}
