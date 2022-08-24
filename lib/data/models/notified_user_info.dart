class NotifiedUserInfo {
  NotifiedUserInfo({
    this.id,
    this.receiverId,
    this.senderId,
    this.type,
    this.description,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.sender,
  });

  int? id;
  int? receiverId;
  int? senderId;
  int? type;
  String? description;
  int? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;
  Sender? sender;

  factory NotifiedUserInfo.fromJson(Map<String, dynamic> json) =>
      NotifiedUserInfo(
        id: json["id"] == null ? null : json["id"],
        receiverId: json["receiver_id"] == null ? null : json["receiver_id"],
        senderId: json["sender_id"] == null ? null : json["sender_id"],
        type: json["type"] == null ? null : json["type"],
        description: json["description"] == null ? null : json["description"],
        isRead: json["is_read"] == null ? null : json["is_read"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "receiver_id": receiverId == null ? null : receiverId,
        "sender_id": senderId == null ? null : senderId,
        "type": type == null ? null : type,
        "description": description == null ? null : description,
        "is_read": isRead == null ? null : isRead,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "sender": sender == null ? null : sender!.toJson(),
      };
}

class Sender {
  Sender({
    this.id,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? avatar;

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        avatar: json["avatar"] == null ? null : json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "avatar": avatar == null ? null : avatar,
      };
}
