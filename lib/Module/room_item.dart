import 'package:project1/Firebase/database_store.dart';

class RoomItem {
  String? id;
  String? name;
  int? numberUser;
  String? password;
  int? roomCost;
  int? electricity;
  int? oldElectricNumber;
  int? newElectricNumber;
  int? water;
  int? oldWaterNumber;
  int? newWaterNumber;
  int? internet;
  int? otherService;
  int? vehicle;
  bool? payementStatus;
  int? deposit;
  String? dateStart;
  String? guestId;
  late int totalBill;

  RoomItem({
    this.id,
    this.name,
    this.numberUser,
    this.password,
    this.roomCost,
    this.oldElectricNumber,
    this.newElectricNumber,
    this.electricity,
    this.oldWaterNumber,
    this.newWaterNumber,
    this.water,
    this.internet,
    this.otherService,
    this.vehicle,
    this.payementStatus,
    this.guestId,
  }) {
    totalBill = roomCost! +
        electricity! * (newElectricNumber! - oldElectricNumber!) +
        water! * (newWaterNumber! - oldWaterNumber!) +
        internet! +
        otherService! +
        vehicle!;
  }

  static RoomItem fromJson(Map<String, dynamic> json) {
    return RoomItem(
      id: json['ID'],
      name: json['Name'],
      numberUser: json['NumberUser'] ?? 0,
      password: json['Password'],
      roomCost: json['RoomCost'],
      oldElectricNumber: json['OldElectricNumber'],
      newElectricNumber: json['NewElectricNumber'],
      electricity: json['electricity'],
      oldWaterNumber: json['OldWaterNumber'],
      newWaterNumber: json['NewWaterNumber'],
      water: json['Water'],
      internet: json['Internet'],
      otherService: json['OtherService'],
      vehicle: json['Vehicle'],
      payementStatus: json['PayementStatus'] ?? false,
      guestId: json['GuestID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'NumberUser': numberUser,
      'Password': password,
      'RoomCost': roomCost,
      'OldElectricNumber': oldElectricNumber,
      'NewElectricNumber': newElectricNumber,
      'electricity': electricity,
      'OldWaterNumber': oldWaterNumber,
      'NewWaterNumber': newWaterNumber,
      'Water': water,
      'Internet': internet,
      'OtherService': otherService,
      'Vehicle': vehicle,
      'PayementStatus': payementStatus,
      'GuestID': guestId,
    };
  }
}

class RoomDA {
  static String collection = "Room";
  static List<RoomItem> listRoom = [];
  static RoomItem? roomAccount;
  static RoomItem defaultRoom = RoomItem(
    roomCost: 6000000,
    oldElectricNumber: 3824,
    newElectricNumber: 4012,
    electricity: 4000,
    oldWaterNumber: 1298,
    newWaterNumber: 1303,
    water: 30000,
    internet: 100000,
    otherService: 100000,
    vehicle: 0,
  );

  static Future<void> getRoomAccount(String id) async {
    var resut = await FireBaseDA.getDocData(collection, id);
    roomAccount = RoomItem.fromJson(resut);
    roomAccount!.id = id;
  }

  static Future<void> getListRoom() async {
    var listData = await FireBaseDA.getColData(collection);
    listRoom = listData.map((e) => RoomItem.fromJson(e)).toList();
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

  static Future<void> deleteRoom(String roomId) async {
    await FireBaseDA.delete(collection, roomId);
    listRoom.removeWhere((element) => element.id == roomId);
  }
}
