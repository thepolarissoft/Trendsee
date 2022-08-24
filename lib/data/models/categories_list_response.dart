// To parse this JSON data, do
//
//     final categoriesListResponse = categoriesListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/category_response.dart';

CategoriesListResponse categoriesListResponseFromJson(String str) =>
    CategoriesListResponse.fromJson(json.decode(str));

String categoriesListResponseToJson(CategoriesListResponse data) =>
    json.encode(data.toJson());

class CategoriesListResponse extends Baseresponse {
  // CategoriesListResponse({
  //   int status,
  //   int statuscode,
  //   String msg,
  //   this.category,
  // }) : super(status: status, statuscode: statuscode, msg: msg);

  List<CategoryResponse>? category;

  // factory CategoriesListResponse.fromJson(Map<String, dynamic> json) =>
  //     CategoriesListResponse(
  //       status: json["status"] == null ? null : json["status"],
  //       statuscode: json["statuscode"] == null ? null : json["statuscode"],
  //       msg: json["msg"] == null ? null : json["msg"],
  //       category: json["category"] == null
  //           ? null
  //           : List<CategoryResponse>.from(
  //               json["category"].map((x) => CategoryResponse.fromJson(x))),
  //     );

  CategoriesListResponse.fromJson(Map<String, dynamic> json) : super(json) {
    category = json["category"] == null
        ? null
        : List<CategoryResponse>.from(
            json["category"].map((x) => CategoryResponse.fromJson(x)));
  }

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "statuscode": statuscode == null ? null : statuscode,
        "msg": msg == null ? null : msg,
        "category": category == null
            ? null
            : List<dynamic>.from(category!.map((x) => x.toJson())),
      };
}
