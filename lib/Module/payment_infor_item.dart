import '../Firebase/database_store.dart';

class PaymentItem {
  String? id;
  String? userName;
  String? bank;
  String? qrPhoto;
  String? stk;

  PaymentItem({this.id, this.userName, this.bank, this.qrPhoto, this.stk});

  static PaymentItem fromJson(Map<String, dynamic> json) {
    return PaymentItem(
      id: json['ID'],
      userName: json['UserName'],
      bank: json['Bank'],
      qrPhoto: json['QRPhoto'],
      stk: json['STK'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserName': userName,
      'Bank': bank,
      'QRPhoto': qrPhoto,
      'STK': stk,
    };
  }
}

class PaymentDA {
  static String collection = 'Payment';
  static List<PaymentItem> listPayment = [];

  static Future<void> getListPayment() async {
    var listData = await FireBaseDA.getColData(collection);
    listPayment = listData.map((e) => PaymentItem.fromJson(e)).toList();
  }

  static Future<void> add(PaymentItem paymentItem) async {
    var newID = await FireBaseDA.add(collection, paymentItem.toJson());
    paymentItem.id = newID;
    listPayment.add(paymentItem);
  }

  static Future<void> edit(PaymentItem paymentItem) async {
    await FireBaseDA.edit(collection, paymentItem.id!, paymentItem.toJson());
    listPayment[listPayment.indexWhere((element) => element.id == paymentItem.id)] = paymentItem;
  }

  static Future<void> delete(String paymentId) async {
    await FireBaseDA.delete(collection, paymentId);
    listPayment.removeWhere((element) => element.id == paymentId);
  }

  static List<String> listBank = [
    '(AGRIBANK) Nông nghiệp và Phát triển Nông thôn Việt Nam',
    '(BIDV) Đầu tư và Phát triển Việt Nam',
    '(VIETINBANK) Công Thương Việt Nam',
    '(VPBANK) Việt Nam Thịnh Vượng',
    '(ABBANK) An Bình',
    '(ACB) Á Châu',
    '(BAC A) Bắc Á',
    '(CBBANK) Ngân hàng Xây dựng',
    '(CIMB) CIMB Bank Việt Nam',
    '(DONG A BANK) Đông Á',
    '(EXIMBANK) Xuất Nhập Khẩu',
    '(GPBANK) Dầu khí toàn cầu',
    '(HD BANK) Phát triển TP.HCM',
    '(HSBC) TNHH MTV HSBC Việt Nam',
    '(KIEN LONG BANK) Kiên Long',
    '(LIEN VIET POST BANK) Bưu điện Liên Việt',
    '(MB) Quân đội',
    '(MSB - MARITIME BANK) Hàng Hải',
    '(NAM A BANK) Nam Á',
    '(OCB) Phương Đông',
    '(OCEANBANK) Đại Dương',
    '(PGBANK) Xăng dầu Petrolimex',
    '(SACOMBANK) Sài Gòn thương tín',
    '(SAiGONBANK) Sài Gòn công thương',
    '(SCB) Sài Gòn',
    '(SHINHAN) Shinhan Bank Việt Nam',
    '(TPBANK) Tiên phong',
    '(VIB) Quốc tế',
    '(TECHCOMBANK) Kỹ thương Việt Nam',
  ];
}
