// To parse this JSON data, do
//
//     final graphLikeResponse = graphLikeResponseFromJson(jsonString);

import 'dart:convert';

GraphResponse graphLikeResponseFromJson(String str) =>
    GraphResponse.fromJson(json.decode(str));

String graphLikeResponseToJson(GraphResponse data) =>
    json.encode(data.toJson());

class GraphResponse {
  GraphResponse({
    this.status,
    this.statuscode,
    this.msg,
    this.data,
  });

  int status;
  int statuscode;
  String msg;
  GraphInfo data;

  factory GraphResponse.fromJson(Map<String, dynamic> json) => GraphResponse(
        status: json["status"] == null ? null : json["status"],
        statuscode: json["statuscode"] == null ? null : json["statuscode"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : GraphInfo.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "statuscode": statuscode == null ? null : statuscode,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data.toJson(),
      };
}

class GraphInfo {
  GraphInfo({
    this.month,
    this.conditionFrom,
    this.conditionTo,
    this.value,
  });

  List<String> month;
  List<String> conditionFrom;
  List<DateTime> conditionTo;
  List<int> value;

  factory GraphInfo.fromJson(Map<String, dynamic> json) => GraphInfo(
        month: json["month"] == null
            ? null
            : List<String>.from(json["month"].map((x) => x)),
        conditionFrom: json["conditionFrom"] == null
            ? null
            : List<String>.from(json["conditionFrom"].map((x) => x)),
        conditionTo: json["conditionTo"] == null
            ? null
            : List<DateTime>.from(
                json["conditionTo"].map((x) => DateTime.parse(x))),
        value: json["value"] == null
            ? null
            : List<int>.from(json["value"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "month": month == null ? null : List<dynamic>.from(month.map((x) => x)),
        "conditionFrom": conditionFrom == null
            ? null
            : List<dynamic>.from(conditionFrom.map((x) => x)),
        "conditionTo": conditionTo == null
            ? null
            : List<dynamic>.from(conditionTo.map((x) => x.toIso8601String())),
        "value": value == null ? null : List<dynamic>.from(value.map((x) => x)),
      };
}
