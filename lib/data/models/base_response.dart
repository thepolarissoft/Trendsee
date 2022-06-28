// // To parse this JSON data, do
// //
// //     final baseresponse = baseresponseFromJson(jsonString);

// import 'dart:convert';

// Baseresponse baseresponseFromJson(String str) =>
//     Baseresponse.fromJson(json.decode(str));

// String baseresponseToJson(Baseresponse data) => json.encode(data.toJsonData());

//  class Baseresponse {
//   Baseresponse({
//     this.status,
//     this.statuscode,
//     this.msg,
//   });

//   int status;
//   int statuscode;
//   String msg;

//   factory Baseresponse.fromJson(Map<String, dynamic> json) => Baseresponse(
//         status: json["status"] == null ? null : json["status"],
//         statuscode: json["statuscode"] == null ? null : json["statuscode"],
//         msg: json["msg"] == null ? null : json["msg"],
//       );

//   Map<String, dynamic> toJsonData() => {
//         "status": status == null ? null : status,
//         "statuscode": statuscode == null ? null : statuscode,
//         "msg": msg == null ? null : msg,
//       };
// }

// To parse this JSON data, do
//
//     final baseresponse = baseresponseFromJson(jsonString);

// BaseresponseTest baseresponseFromJson(String str) =>
//     BaseresponseTest.fromJson(json.decode(str));

// String baseresponseToJson(BaseresponseTest data) =>
//     json.encode(data.toJsonData());

class Baseresponse {
  Baseresponse(Map<String, dynamic> fullJson) {
    parsing(fullJson);
  }
  int status;
  int statuscode;
  String msg;
  bool isThisFirstBusinessWithThisEmail;

  Map<String, dynamic> toJsonData() => {
        "status": status == null ? null : status,
        "statuscode": statuscode == null ? null : statuscode,
        "msg": msg == null ? null : msg,
        "is_this_first_business_with_this_email":
            isThisFirstBusinessWithThisEmail == null
                ? null
                : isThisFirstBusinessWithThisEmail,
      };

  parsing(Map<String, dynamic> json) {
    status = json["status"];
    statuscode = json["statuscode"];
    msg = json["msg"];
    isThisFirstBusinessWithThisEmail =
        json["is_this_first_business_with_this_email"];
  }

  // factory Baseresponse.fromJson(Map<String, dynamic> json) => Baseresponse(
  //       status: json["status"] == null ? null : json["status"],
  //       statuscode: json["statuscode"] == null ? null : json["statuscode"],
  //       msg: json["msg"] == null ? null : json["msg"],
  //     );
}
