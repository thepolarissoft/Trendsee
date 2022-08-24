// // To parse this JSON data, do
// //
// //     final baseresponse = baseresponseFromJson(jsonString);

// // BaseresponseTest baseresponseFromJson(String str) =>
// //     BaseresponseTest.fromJson(json.decode(str));

// // String baseresponseToJson(BaseresponseTest data) =>
// //     json.encode(data.toJsonData());

// abstract class BaseresponseTest {
//   // BaseresponseTest({
//   //   this.status,
//   //   this.statuscode,
//   //   this.msg,
//   // });

//   BaseresponseTest(Map<String, dynamic> fullJson) {
//     parsing(fullJson);
//   }

//   int status;
//   int statuscode;
//   String msg;

//   // factory BaseresponseTest.fromJson(Map<String, dynamic> json) => BaseresponseTest(
//   //       status: json["status"] == null ? null : json["status"],
//   //       statuscode: json["statuscode"] == null ? null : json["statuscode"],
//   //       msg: json["msg"] == null ? null : json["msg"],
//   //     );

//   // Map<String, dynamic> toJsonData() => {
//   //       "status": status == null ? null : status,
//   //       "statuscode": statuscode == null ? null : statuscode,
//   //       "msg": msg == null ? null : msg,
//   //     };

//   //  Map<String, dynamic> toJson() => {
//   //       "status": status,
//   //       "statuscode": statuscode,
//   //       "msg": msg,
//   //     };

//   parsing(Map<String, dynamic> json) {
//     status = json["status"];
//     statuscode = json["statuscode"];
//     msg = json["msg"];
//   }
// }

import 'dart:convert';

BaseresponseTest baseresponseFromJson(String str) =>
    BaseresponseTest.fromJson(json.decode(str));

String baseresponseToJson(BaseresponseTest data) => json.encode(data.toJsonData());

class BaseresponseTest {
  BaseresponseTest({
    this.status,
    this.statuscode,
    this.msg,
  });

  int? status;
  int? statuscode;
  String? msg;

  factory BaseresponseTest.fromJson(Map<String, dynamic> json) => BaseresponseTest(
        status: json["status"] == null ? null : json["status"],
        statuscode: json["statuscode"] == null ? null : json["statuscode"],
        msg: json["msg"] == null ? null : json["msg"],
      );

  Map<String, dynamic> toJsonData() => {
        "status": status == null ? null : status,
        "statuscode": statuscode == null ? null : statuscode,
        "msg": msg == null ? null : msg,
      };
}
