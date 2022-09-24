class UserItem {
  int? id;
  String? name;
  String? avatar;
  int? role;

  UserItem({this.id, this.name, this.avatar, this.role});

  Map<String, dynamic> toJson() {
    return {};
  }
}
