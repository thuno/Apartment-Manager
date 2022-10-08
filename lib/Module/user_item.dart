import 'package:project1/Firebase/database_store.dart';

class UserItem {
  String? id;
  String? accName;
  String? userName;
  String? password;
  String? avatar;
  String? roomId;
  int? role;

  UserItem({this.id, this.accName, this.userName, this.password, this.avatar, this.role, this.roomId});

  static UserItem fromJson(Map<String, dynamic> json) {
    return UserItem(
      id: json['ID'],
      roomId: json['RoomID'],
      accName: json['AccountName'],
      userName: json['UserName'],
      password: json['Password'],
      avatar: json['Avatar'],
      role: json['Permission'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'RoomID': roomId,
      'AccountName': accName,
      'UserName': userName,
      'Password': password,
      'Avatar': avatar,
      'Permission': role,
    };
  }
}

class UserDA {
  static String collection = 'User';
  static UserItem? admin;
  static List<UserItem> listAccount = [];

  static Future<void> getListAccount() async {
    var listData = await FireBaseDA.getColData(collection);
    listAccount = listData.map((e) => UserItem.fromJson(e)).toList();
    admin = listAccount.firstWhere((e) => e.role == 0, orElse: () => UserItem());
  }

  static Future<void> addAccount(UserItem newAcc) async {
    var newID = await FireBaseDA.add(collection, newAcc.toJson());
    newAcc.id = newID;
    listAccount.add(newAcc);
  }

  static Future<void> editUser(UserItem userItem) async {
    await FireBaseDA.edit(collection, userItem.id!, userItem.toJson());
    listAccount[listAccount.indexWhere((element) => element.id == userItem.id)] = userItem;
  }

  static Future<void> deleteUser(String id) async {
    await FireBaseDA.delete(collection, id);
    listAccount.removeWhere((e) => e.id == id);
  }
}
