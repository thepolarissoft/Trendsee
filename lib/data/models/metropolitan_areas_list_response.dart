import 'dart:convert';

import 'package:trendoapp/data/models/base_response.dart';

MetropolitanAreasListResponse metropolitanAreasListResponseFromJson(
        String str) =>
    MetropolitanAreasListResponse.fromJson(json.decode(str));

String metropolitanAreasListResponseToJson(
        MetropolitanAreasListResponse data) =>
    json.encode(data.toJson());

class MetropolitanAreasListResponse extends Baseresponse {
  // MetropolitanAreasListResponse({
  //   int status,
  //   int statuscode,
  //   String msg,
  //   this.metropolitanAreas,
  // }) : super(status: status, statuscode: statuscode, msg: msg);

  List<MetropolitanAreaInfo>? metropolitanAreas;

  MetropolitanAreasListResponse.fromJson(Map<String, dynamic> json)
      : super(json) {
    metropolitanAreas = json["metropolitan_areas"] == null
        ? null
        : List<MetropolitanAreaInfo>.from(json["metropolitan_areas"]
            .map((x) => MetropolitanAreaInfo.fromJson(x)));
  }

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "statuscode": statuscode == null ? null : statuscode,
        "msg": msg == null ? null : msg,
        "metropolitan_areas": metropolitanAreas == null
            ? null
            : List<dynamic>.from(metropolitanAreas!.map((x) => x.toJson())),
      };
}

class MetropolitanAreaInfo {
  MetropolitanAreaInfo({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.cities,
    this.metropolitanAreaId,
  });

  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<MetropolitanCityInfo>? cities;
  int? metropolitanAreaId;

  factory MetropolitanAreaInfo.fromJson(Map<String, dynamic> json) =>
      MetropolitanAreaInfo(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        cities: json["cities"] == null
            ? null
            : List<MetropolitanCityInfo>.from(
                json["cities"].map((x) => MetropolitanCityInfo.fromJson(x))),
        metropolitanAreaId: json["metropolitan_area_id"] == null
            ? null
            : json["metropolitan_area_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "cities": cities == null
            ? null
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
        "metropolitan_area_id":
            metropolitanAreaId == null ? null : metropolitanAreaId,
      };
}

class MetropolitanCityInfo {
  MetropolitanCityInfo({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.metropolitanAreaId,
  });
  int? id;
  String? name="";
  DateTime? createdAt;
  DateTime? updatedAt;
  int? metropolitanAreaId;

  factory MetropolitanCityInfo.fromJson(Map<String, dynamic> json) =>
      MetropolitanCityInfo(
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
