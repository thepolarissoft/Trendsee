class CityModel {
  CityModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.metropolitanAreaId,
  });

  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? metropolitanAreaId;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        metropolitanAreaId: json["metropolitan_area_id"] == null
            ? null
            : json["metropolitan_area_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "metropolitan_area_id":
            metropolitanAreaId == null ? null : metropolitanAreaId,
      };
}
