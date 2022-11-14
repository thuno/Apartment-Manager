import '../Firebase/database_store.dart';

class BillItem {
  String? id;
  String? name;
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
  late int totalBill;

  BillItem({
    this.id,
    this.name,
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
  }) {
    try {
      totalBill = roomCost! +
          electricity! * (newElectricNumber! - oldElectricNumber!) +
          water! * (newWaterNumber! - oldWaterNumber!) +
          internet! +
          otherService! +
          vehicle!;
    } catch (e) {
      totalBill = 0;
    }
  }

  static BillItem fromJson(Map<String, dynamic> json) {
    return BillItem(
      id: json['ID'],
      name: json['Name'],
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
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
    };
  }
}

class BillDA {
  static String collection = "Bill";
  static List<BillItem> listBill = [];
  static BillItem defaultBill = BillItem(
    roomCost: 6000000,
    oldElectricNumber: 0,
    newElectricNumber: 0,
    electricity: 4000,
    oldWaterNumber: 0,
    newWaterNumber: 0,
    water: 30000,
    internet: 100000,
    otherService: 100000,
    vehicle: 0,
  );

  static Future<BillItem> getBillInfor(String id, String roomName) async {
    var resut = await FireBaseDA.getDocData(collection + roomName, id);
    var billItem = BillItem.fromJson(resut);
    billItem.id = id;
    return billItem;
  }

  static Future<void> getListBill(String roomName) async {
    var listData = await FireBaseDA.getColData(collection + roomName);
    listBill = listData.map((e) => BillItem.fromJson(e)).toList();
  }

  static Future<void> addBill(BillItem newBill, String roomName) async {
    var newID = await FireBaseDA.add(collection + roomName, newBill.toJson());
    newBill.id = newID;
    listBill.add(newBill);
  }

  static Future<void> editBill(BillItem billItem, String roomName) async {
    await FireBaseDA.edit(collection + roomName, billItem.id!, billItem.toJson());
    listBill[listBill.indexWhere((element) => element.id == billItem.id)] = billItem;
  }

  static Future<void> deleteBill(String billId, String roomName) async {
    await FireBaseDA.delete(collection + roomName, billId);
    listBill.removeWhere((element) => element.id == billId);
  }
}
