import '../Firebase/database_store.dart';

class MessageHistoryItem {
  String? id;
  List<MessageItem> listMessage;

  MessageHistoryItem({this.id, this.listMessage = const []});

  static MessageHistoryItem fromJson(Map<String, dynamic> json) {
    return MessageHistoryItem(
      listMessage: [for (var e in json['Message'] ?? []) MessageItem.fromJson(e)],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Message': [for (var e in listMessage) e.toJson()],
    };
  }
}

class MessageItem {
  String? message;
  String? time;
  String? userId;

  MessageItem({this.userId, this.time, this.message});

  static MessageItem fromJson(Map<String, dynamic> json) {
    return MessageItem(
      userId: json['UserID'],
      time: json['Time'],
      message: json['Message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': userId,
      'Time': time,
      'Message': message,
    };
  }
}

class MessageDA {
  static String collection = "Message";

  static Future<MessageHistoryItem> getMessHistory(String messageID) async {
    var result = await FireBaseDA.getDocData(collection, messageID);
    MessageHistoryItem messHistory = MessageHistoryItem.fromJson(result);
    messHistory.id = messageID;
    return messHistory;
  }

  static Future<void> addMessHistory(MessageHistoryItem messHistory) async {
    var newID = await FireBaseDA.add(collection, messHistory.toJson());
    messHistory.id = newID;
  }

  static Future<void> deleteMessHistory(String messageID) async {
    await FireBaseDA.delete(collection, messageID);
  }
}
