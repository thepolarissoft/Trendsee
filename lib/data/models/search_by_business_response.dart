// To parse this JSON data, do
//
//     final searchByBusinessResponse = searchByBusinessResponseFromJson(jsonString);

import 'dart:convert';

import 'package:trendoapp/data/models/verified_user_response.dart';

SearchByBusinessResponse searchByBusinessResponseFromJson(String str) => SearchByBusinessResponse.fromJson(json.decode(str));

String searchByBusinessResponseToJson(SearchByBusinessResponse data) => json.encode(data.toJson());

class SearchByBusinessResponse {
    SearchByBusinessResponse({
        this.status,
        this.statuscode,
        this.msg,
        this.place,
    });

    final int? status;
    final int? statuscode;
    final String? msg;
    final Place? place;

    factory SearchByBusinessResponse.fromJson(Map<String, dynamic> json) => SearchByBusinessResponse(
        status: json["status"] == null ? null : json["status"],
        statuscode: json["statuscode"] == null ? null : json["statuscode"],
        msg: json["msg"] == null ? null : json["msg"],
        place: json["place"] == null ? null : Place.fromJson(json["place"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "statuscode": statuscode == null ? null : statuscode,
        "msg": msg == null ? null : msg,
        "place": place == null ? null : place!.toJson(),
    };
}

class Place {
    Place({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    final int ?currentPage;
    final List<VerifiedUserResponse>? data;
    final String? firstPageUrl;
    final int ?from;
    final int? lastPage;
    final String ?lastPageUrl;
    final List<Link> ?links;
    final dynamic nextPageUrl;
    final String? path;
    final int? perPage;
    final String ?prevPageUrl;
    final int ?to;
    final int ?total;

    factory Place.fromJson(Map<String, dynamic> json) => Place(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null ? null : List<VerifiedUserResponse>.from(json["data"].map((x) => VerifiedUserResponse.fromJson(x))),
        firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
        links: json["links"] == null ? null : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"] == null ? null : json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "links": links == null ? null : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl == null ? null : prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
    };
}

class BusinessMedia {
    BusinessMedia({
        this.id,
        this.media,
        this.type,
        this.userId,
        this.createdAt,
        this.updatedAt,
    });

    final int? id;
    final String ?media;
    final int ?type;
    final int ?userId;
    final DateTime ?createdAt;
    final DateTime ?updatedAt;

    factory BusinessMedia.fromJson(Map<String, dynamic> json) => BusinessMedia(
        id: json["id"] == null ? null : json["id"],
        media: json["media"] == null ? null : json["media"],
        type: json["type"] == null ? null : json["type"],
        userId: json["user_id"] == null ? null : json["user_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "media": media == null ? null : media,
        "type": type == null ? null : type,
        "user_id": userId == null ? null : userId,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}

class Category {
    Category({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
    });

    final int? id;
    final String? name;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}

class Link {
    Link({
        this.url,
        this.label,
        this.active,
    });

    final String? url;
    final String? label;
    final bool ?active;

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"] == null ? null : json["label"],
        active: json["active"] == null ? null : json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label == null ? null : label,
        "active": active == null ? null : active,
    };
}


// // To parse this JSON data, do
// //
// //     final searchByBusinessResponse = searchByBusinessResponseFromJson(jsonString);

// import 'dart:convert';

// import 'package:trendoapp/data/models/base_response.dart';
// import 'package:trendoapp/data/models/pagination_response.dart';
// import 'package:trendoapp/data/models/verified_user_response.dart';

// SearchByBusinessResponse searchByBusinessResponseFromJson(String str) =>
//     SearchByBusinessResponse.fromJson(json.decode(str));

// // String searchByBusinessResponseToJson(SearchByBusinessResponse data) =>
// //     json.encode(data.toJson());

// class SearchByBusinessResponse extends Baseresponse {
//   // SearchByBusinessResponse({
//   //   int status,
//   //   int statuscode,
//   //   String msg,
//   //   this.place,
//   // }) : super(status: status, statuscode: statuscode, msg: msg);

//   BusinessPlaceResponse? place;

//   SearchByBusinessResponse.fromJson(Map<String, dynamic> json) : super(json) {
//     place = json["place"] == null
//         ? null
//         : BusinessPlaceResponse.fromJson(json["place"]);
//   }

//   Map<String, dynamic> toJson() => {
//         "status": status == null ? null : status,
//         "statuscode": statuscode == null ? null : statuscode,
//         "msg": msg == null ? null : msg,
//         "place": place == null ? null : place!.toJson(),
//       };
// }

// class BusinessPlaceResponse extends PaginationResponse {
//   BusinessPlaceResponse({
//     int? currentPage,
//     this.data,
//     String? firstPageUrl,
//     int? from,
//     int? lastPage,
//     String? lastPageUrl,
//     List<Link>? links,
//     dynamic nextPageUrl,
//     String? path,
//     int? perPage,
//     dynamic prevPageUrl,
//     int? to,
//     int? total,
//   }) : super(
//             currentPage: currentPage,
//             firstPageUrl: firstPageUrl,
//             from: from,
//             lastPage: lastPage,
//             lastPageUrl: lastPageUrl,
//             links: links,
//             nextPageUrl: nextPageUrl,
//             path: path,
//             perPage: perPage,
//             prevPageUrl: prevPageUrl,
//             to: to,
//             total: total);

//   List<VerifiedUserResponse>? data;

//   factory BusinessPlaceResponse.fromJson(Map<String, dynamic> json) =>
//       BusinessPlaceResponse(
//         data: json["data"] == null
//             ? null
//             : List<VerifiedUserResponse>.from(
//                 json["data"].map((x) => VerifiedUserResponse.fromJson(x))),
       
//       );
// }
