// To parse this JSON data, do
//
//     final timeZoneResponse = timeZoneResponseFromJson(jsonString);

import 'dart:convert';

TimeZoneResponse timeZoneResponseFromJson(String str) =>
    TimeZoneResponse.fromJson(json.decode(str));

String timeZoneResponseToJson(TimeZoneResponse data) =>
    json.encode(data.toJson());

class TimeZoneResponse {
  TimeZoneResponse({
    this.timeZone,
  });

  List<TimezoneInfo>? timeZone;

  factory TimeZoneResponse.fromJson(Map<String, dynamic> json) =>
      TimeZoneResponse(
        timeZone: json["items"] == null
            ? null
            : List<TimezoneInfo>.from(
                json["items"].map((x) => TimezoneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": timeZone == null
            ? null
            : List<dynamic>.from(timeZone!.map((x) => x.toJson())),
      };
}

class TimezoneInfo {
  TimezoneInfo({
    this.value,
    this.abbr,
    this.offset,
    this.isdst,
    this.text,
    this.utc,
  });

  String? value;
  String? abbr;
  double? offset;
  bool? isdst;
  String? text;
  List<String>? utc;

  factory TimezoneInfo.fromJson(Map<String, dynamic> json) => TimezoneInfo(
        value: json["value"] == null ? null : json["value"],
        abbr: json["abbr"] == null ? null : json["abbr"],
        offset: json["offset"] == null ? null : json["offset"].toDouble(),
        isdst: json["isdst"] == null ? null : json["isdst"],
        text: json["text"] == null ? null : json["text"],
        utc: json["utc"] == null
            ? null
            : List<String>.from(json["utc"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "value": value == null ? null : value,
        "abbr": abbr == null ? null : abbr,
        "offset": offset == null ? null : offset,
        "isdst": isdst == null ? null : isdst,
        "text": text == null ? null : text,
        "utc": utc == null ? null : List<dynamic>.from(utc!.map((x) => x)),
      };
}
