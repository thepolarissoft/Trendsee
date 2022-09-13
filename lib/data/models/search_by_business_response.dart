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

    final int? currentPage;
    final List<VerifiedUserResponse>? data;
    final String? firstPageUrl;
    final int? from;
    final int? lastPage;
    final String? lastPageUrl;
    final List<Link>? links;
    final String? nextPageUrl;
    final String? path;
    final int? perPage;
    final dynamic prevPageUrl;
    final int? to;
    final int? total;

    factory Place.fromJson(Map<String, dynamic> json) => Place(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null ? null : List<VerifiedUserResponse>.from(json["data"].map((x) => VerifiedUserResponse.fromJson(x))),
        firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
        links: json["links"] == null ? null : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"] == null ? null : json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
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
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
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
    final String? media;
    final int? type;
    final int? userId;
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

    final int ?id;
    final String? name;
    final DateTime? createdAt;
    final DateTime ?updatedAt;

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

class Feed {
    Feed({
        this.id,
        this.title,
        this.description,
        this.categoryId,
        this.userId,
        this.businessUserId,
        this.totalLikes,
        this.totalComments,
        this.totalShares,
        this.createdAt,
        this.updatedAt,
        this.isDeleted,
        this.latitude,
        this.longitude,
        this.locationName,
        this.categories,
        this.isLiked,
        this.images,
        this.category,
        this.metropolitanArea,
        this.city,
        this.user,
        this.businessUser,
    });

    final int? id;
    final String? title;
    final String? description;
    final int?categoryId;
    final int?userId;
    final int?businessUserId;
    final int?totalLikes;
    final int?totalComments;
    final int?totalShares;
    final DateTime?createdAt;
    final DateTime?updatedAt;
    final int? isDeleted;
    final String? latitude;
    final String? longitude;
    final String? locationName;
    final List<Category>? categories;
    final int? isLiked;
    final List<dynamic> ?images;
    final Category ?category;
    final dynamic metropolitanArea;
    final dynamic city;
    final User? user;
    final BusinessUser? businessUser;

    factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        businessUserId: json["business_user_id"] == null ? null : json["business_user_id"],
        totalLikes: json["total_likes"] == null ? null : json["total_likes"],
        totalComments: json["total_comments"] == null ? null : json["total_comments"],
        totalShares: json["total_shares"] == null ? null : json["total_shares"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        locationName: json["location_name"] == null ? null : json["location_name"],
        categories: json["categories"] == null ? null : List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        isLiked: json["is_liked"] == null ? null : json["is_liked"],
        images: json["images"] == null ? null : List<dynamic>.from(json["images"].map((x) => x)),
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        metropolitanArea: json["metropolitan_area"],
        city: json["city"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        businessUser: json["business_user"] == null ? null : BusinessUser.fromJson(json["business_user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "category_id": categoryId == null ? null : categoryId,
        "user_id": userId == null ? null : userId,
        "business_user_id": businessUserId == null ? null : businessUserId,
        "total_likes": totalLikes == null ? null : totalLikes,
        "total_comments": totalComments == null ? null : totalComments,
        "total_shares": totalShares == null ? null : totalShares,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "is_deleted": isDeleted == null ? null : isDeleted,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "location_name": locationName == null ? null : locationName,
        "categories": categories == null ? null : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "is_liked": isLiked == null ? null : isLiked,
        "images": images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "category": category == null ? null : category!.toJson(),
        "metropolitan_area": metropolitanArea,
        "city": city,
        "user": user == null ? null : user!.toJson(),
        "business_user": businessUser == null ? null : businessUser!.toJson(),
    };
}

class BusinessUser {
    BusinessUser({
        this.id,
        this.businessName,
        this.businessAddress,
        this.firstName,
        this.lastName,
        this.isOnline,
        this.username,
        this.isMobile,
        this.cmCategoryIds,
    });

    final int ?id;
    final String ?businessName;
    final String ?businessAddress;
    final String ?firstName;
    final String ?lastName;
    final int? isOnline;
    final String? username;
    final int ?isMobile;
    final String ?cmCategoryIds;

    factory BusinessUser.fromJson(Map<String, dynamic> json) => BusinessUser(
        id: json["id"] == null ? null : json["id"],
        businessName: json["business_name"] == null ? null : json["business_name"],
        businessAddress: json["business_address"] == null ? null : json["business_address"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        isOnline: json["is_online"] == null ? null : json["is_online"],
        username: json["username"] == null ? null : json["username"],
        isMobile: json["is_mobile"] == null ? null : json["is_mobile"],
        cmCategoryIds: json["cm_category_ids"] == null ? null : json["cm_category_ids"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "business_name": businessName == null ? null : businessName,
        "business_address": businessAddress == null ? null : businessAddress,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "is_online": isOnline == null ? null : isOnline,
        "username": username == null ? null : username,
        "is_mobile": isMobile == null ? null : isMobile,
        "cm_category_ids": cmCategoryIds == null ? null : cmCategoryIds,
    };
}

class User {
    User({
        this.id,
        this.firstName,
        this.lastName,
        this.avatar,
        this.username,
    });

    final int? id;
    final String ?firstName;
    final String ?lastName;
    final String ?avatar;
    final String ?username;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        username: json["username"] == null ? null : json["username"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "avatar": avatar == null ? null : avatar,
        "username": username == null ? null : username,
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
