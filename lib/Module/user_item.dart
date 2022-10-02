import 'package:project1/Firebase/database_store.dart';

class UserItem {
  String? id;
  String? accName;
  String? userName;
  String? password;
  String? avatar;
  int? role;

  UserItem({this.id, this.accName, this.userName, this.password, this.avatar, this.role});

  static UserItem fromJson(Map<String, dynamic> json) {
    return UserItem(
      id: json['ID'],
      accName: json['AccountName'],
      userName: json['UserName'],
      password: json['Password'],
      avatar: json['Avatar'],
      role: json['Permission'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
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
    await FireBaseDA.add(collection, newAcc.toJson());
  }
}
