import 'package:trendoapp/data/models/business_media_response.dart';
import 'package:trendoapp/data/models/category_response.dart';
import 'package:trendoapp/data/models/feed_response.dart';

class VerifiedUserResponse {
  VerifiedUserResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    // this.otp,
    this.dob,
    this.userType,
    this.isApproved,
    this.isActive,
    this.businessName,
    this.businessAddress,
    this.businessPhone,
    this.businessWebsite,
    this.isOnline,
    this.isMobile,
    this.advertiseMedia,
    this.latitude,
    this.longitude,
    this.cityId,
    this.cityName,
    this.metropolitanAreaId,
    this.metropolitanArea,
    this.contact,
    this.isVerified,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.isFollow,
    // this.category,
    this.categories,
    this.feed,
    this.totalFeeds,
    this.totalFollowers,
    this.isLiked,
    this.isDisliked,
    this.businessMedia,
    this.totalLikes,
    this.totalViews,
    this.totalClick,
    this.allowNotification,
    this.locationName,
    this.businessLatitude,
    this.businessLongitude,
  });

  int id;
  String firstName;
  String lastName;
  String username;
  String email;
  // dynamic otp;
  DateTime dob;
  int userType;
  int isApproved;
  int isActive;
  String businessName;
  String businessAddress;
  String businessPhone;
  String businessWebsite;
  int isOnline;
  int isMobile;
  String advertiseMedia;
  String latitude;
  String longitude;
  int cityId;
  String cityName;
  int metropolitanAreaId;
  String metropolitanArea;
  String contact;
  int isVerified;
  String avatar;
  DateTime createdAt;
  DateTime updatedAt;
  bool isChecked = false;
  int isFollow;
  // CategoryResponse category;
  List<CategoryResponse> categories;
  List<FeedResponse> feed;
  int totalFeeds;
  int totalFollowers;
  int isLiked;
  int isDisliked;
  List<BusinessMediaResponse> businessMedia;
  int totalLikes;
  int totalViews;
  int totalClick;
  int allowNotification;
  String locationName;
  String businessLatitude;
  String businessLongitude;

  factory VerifiedUserResponse.fromJson(Map<String, dynamic> json) =>
      VerifiedUserResponse(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        // otp: json["otp"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        userType: json["user_type"] == null ? null : json["user_type"],
        isApproved: json["is_approved"] == null ? null : json["is_approved"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        businessName:
            json["business_name"] == null ? null : json["business_name"],
        businessAddress:
            json["business_address"] == null ? null : json["business_address"],
        businessPhone:
            json["business_phone"] == null ? null : json["business_phone"],
        businessWebsite:
            json["business_website"] == null ? null : json["business_website"],
        isOnline: json["is_online"] == null ? null : json["is_online"],
        isMobile: json["is_mobile"] == null ? null : json["is_mobile"],
        advertiseMedia:
            json["advertise_media"] == null ? null : json["advertise_media"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        cityName: json["city_name"] == null ? null : json["city_name"],
        metropolitanAreaId: json["metropolitan_area_id"] == null
            ? null
            : json["metropolitan_area_id"],
        metropolitanArea: json["metropolitan_area"] == null
            ? null
            : json["metropolitan_area"],
        //  metropolitanArea: json["metropolitan_area"] == null
        //     ? null
        //     : MetropolitanAreaInfo.fromJson(json["metropolitan_area"]),
        contact: json["contact"] == null ? null : json["contact"],
        isVerified: json["is_verified"] == null ? null : json["is_verified"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isFollow: json["is_follow"] == null ? null : json["is_follow"],
        // category: json["category"] == null
        //     ? null
        //     : CategoryResponse.fromJson(json["category"]),
        categories: json["categories"] == null
            ? null
            : List<CategoryResponse>.from(
                json["categories"].map((x) => CategoryResponse.fromJson(x))),
        feed: json["feed"] == null
            ? null
            : List<FeedResponse>.from(
                json["feed"].map((x) => FeedResponse.fromJson(x))),
        totalFeeds: json["total_feeds"] == null ? null : json["total_feeds"],
        totalFollowers:
            json["total_followers"] == null ? null : json["total_followers"],
        isLiked: json["is_liked"] == null ? null : json["is_liked"],
        isDisliked: json["is_disliked"] == null ? null : json["is_disliked"],
        businessMedia: json["business_media"] == null
            ? null
            : List<BusinessMediaResponse>.from(json["business_media"]
                .map((x) => BusinessMediaResponse.fromJson(x))),
        totalLikes: json["total_likes"] == null ? null : json["total_likes"],
        totalViews: json["total_views"] == null ? null : json["total_views"],
        totalClick: json["total_click"] == null ? null : json["total_click"],
        allowNotification: json["allow_notification"] == null
            ? null
            : json["allow_notification"],
        locationName:
            json["location_name"] == null ? null : json["location_name"],
        businessLatitude: json["business_latitude"] == null
            ? null
            : json["business_latitude"],
        businessLongitude: json["business_longitude"] == null
            ? null
            : json["business_longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        // "otp": otp,
        "dob": dob == null
            ? null
            : "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "user_type": userType == null ? null : userType,
        "is_approved": isApproved == null ? null : isApproved,
        "is_active": isActive == null ? null : isActive,
        "business_name": businessName == null ? null : businessName,
        "business_address": businessAddress == null ? null : businessAddress,
        "business_phone": businessPhone == null ? null : businessPhone,
        "business_website": businessWebsite == null ? null : businessWebsite,
        "is_online": isOnline == null ? null : isOnline,
        "advertise_media": advertiseMedia == null ? null : advertiseMedia,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "city_id": cityId == null ? null : cityId,
        "city_name": cityName == null ? null : cityName,
        "metropolitan_area_id":
            metropolitanAreaId == null ? null : metropolitanAreaId,
        "metropolitan_area": metropolitanArea == null ? null : metropolitanArea,
        "contact": contact == null ? null : contact,
        "is_verified": isVerified == null ? null : isVerified,
        "avatar": avatar == null ? null : avatar,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "is_follow": isFollow == null ? null : isFollow,
        // "category": category == null ? null : category.toJson(),
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x.toJson())),
        "feed": feed == null
            ? null
            : List<dynamic>.from(feed.map((x) => x.toJson())),
        "total_feeds": totalFeeds == null ? null : totalFeeds,
        "total_followers": totalFollowers == null ? null : totalFollowers,
        "is_liked": isLiked == null ? null : isLiked,
        "is_disliked": isDisliked == null ? null : isDisliked,
        "business_media": businessMedia == null
            ? null
            : List<dynamic>.from(businessMedia.map((x) => x.toJson())),
        "total_likes": totalLikes == null ? null : totalLikes,
        "total_views": totalViews == null ? null : totalViews,
        "total_click": totalClick == null ? null : totalClick,
        "allow_notification":
            allowNotification == null ? null : allowNotification,
      };
}
