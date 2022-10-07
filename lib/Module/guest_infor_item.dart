import '../Firebase/database_store.dart';

class GuestInforItem {
  String? id;
  String? name;
  String? birthday;
  String? address;
  String? ccNumber;
  List<String>? photos;
  String? contractPhoto;

  GuestInforItem({this.id, this.name, this.birthday, this.address, this.ccNumber, this.photos, this.contractPhoto});

  static GuestInforItem fromJson(Map<String, dynamic> json) {
    return GuestInforItem(
      id: json['ID'],
      name: json['Name'],
      birthday: json['BirthDay'],
      address: json['Address'],
      ccNumber: json['CCCD'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'BirthDay': birthday,
      'Address': address,
      'CCCD': ccNumber,
    };
  }
}

class GuestInforDA {
  static String collection = "GuestInfor";

  static Future<GuestInforItem> getInfor(String guestID) async {
    var result = await FireBaseDA.getDocData(collection, guestID);
    GuestInforItem guestInfor = GuestInforItem.fromJson(result);
    guestInfor.id = guestID;
    return guestInfor;
  }

  static Future<void> addInfor(GuestInforItem guestInfor) async {
    var newID = await FireBaseDA.add(collection, guestInfor.toJson());
    guestInfor.id = newID;
  }

  static Future<void> editInfor(GuestInforItem guestInfor) async {
    await FireBaseDA.edit(collection, guestInfor.id!, guestInfor.toJson());
  }

  static Future<void> deleteInfor(String guestID) async {
    await FireBaseDA.delete(collection, guestID);
  }
}
