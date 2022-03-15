class BusinessMediaResponse {
  BusinessMediaResponse({
    this.id,
    this.media,
    this.type,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String media;
  int type;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  factory BusinessMediaResponse.fromJson(Map<String, dynamic> json) =>
      BusinessMediaResponse(
        id: json["id"] == null ? null : json["id"],
        media: json["media"] == null ? null : json["media"],
        type: json["type"] == null ? null : json["type"],
        userId: json["user_id"] == null ? null : json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "media": media == null ? null : media,
        "type": type == null ? null : type,
        "user_id": userId == null ? null : userId,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
