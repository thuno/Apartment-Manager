import '../Firebase/database_store.dart';

class IncomeItem {
  String? id;
  String? name;
  int? electric;
  int? water;
  int? room;
  int? service;

  IncomeItem({this.id, this.name, this.electric, this.water, this.room, this.service});

  static IncomeItem fromJson(Map<String, dynamic> json) {
    return IncomeItem(
      id: json['ID'],
      name: json['Name'],
      electric: json['Electric'],
      water: json['Water'],
      room: json['Room'],
      service: json['Service'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Electric': electric,
      'Water': water,
      'Room': room,
      'Service': service,
    };
  }
}

class IncomeDA {
  static String collection = 'Income';
  static List<IncomeItem> history = [];

  static Future<void> getHistory() async {
    var listData = await FireBaseDA.getColData(collection);
    history = listData.map((e) => IncomeItem.fromJson(e)).toList();
  }

  static Future<void> add(IncomeItem incomeItem) async {
    var newID = await FireBaseDA.add(collection, incomeItem.toJson());
    incomeItem.id = newID;
    history.add(incomeItem);
  }

  static Future<void> edit(IncomeItem incomeItem) async {
    await FireBaseDA.edit(collection, incomeItem.id!, incomeItem.toJson());
    history[history.indexWhere((element) => element.id == incomeItem.id)] = incomeItem;
  }

  static Future<void> delete(String incomId) async {
    await FireBaseDA.delete(collection, incomId);
    history.removeWhere((element) => element.id == incomId);
  }
}
