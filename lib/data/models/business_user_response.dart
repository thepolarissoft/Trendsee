import 'package:trendoapp/data/models/business_media_response.dart';
import 'package:trendoapp/data/models/category_response.dart';
import 'package:trendoapp/data/models/feed_response.dart';
import 'package:trendoapp/data/models/metropolitan_areas_list_response.dart';

class BusinessUserResponse {
  BusinessUserResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.dob,
    this.userType,
    this.isApproved,
    this.businessName,
    this.businessAddress,
    this.businessPhone,
    this.businessWebsite,
    this.businessKeywords,
    this.isOnline,
    this.isMobile,
    this.categoryId,
    this.latitude,
    this.longitude,
    this.cityId,
    this.metropolitanAreaId,
    this.contact,
    this.isVerified,
    this.avatar,
    this.totalLikes,
    this.totalDislike,
    this.totalViews,
    this.totalClick,
    this.createdAt,
    this.updatedAt,
    this.feed,
    this.totalFeeds,
    // this.category,
    this.categories,
    this.metropolitanArea,
    this.city,
    this.businessMedia,
    this.allowNotification,
    this.cityName,
    this.isFollow,
    this.isLiked,
    this.businessHours,
    this.businessTimeZone,
    // this.isShowClosingSoon,
    this.businessStatus = "",
    this.currentPlanId,
    this.currentPlan,
  });
  int id;
  String firstName;
  String lastName;
  String username;
  String email;
  dynamic dob;
  int userType;
  int isApproved;
  String businessName;
  String businessAddress;
  String businessPhone;
  String businessWebsite;
  String businessKeywords;
  int isOnline;
  int isMobile;
  int categoryId;
  String latitude;
  String longitude;
  int cityId;
  int metropolitanAreaId;
  String contact;
  int isVerified;
  String cityName;
  String avatar;
  int totalLikes;
  int totalDislike;
  int totalViews;
  int totalClick;
  DateTime createdAt;
  DateTime updatedAt;
  List<FeedResponse> feed;
  int totalFeeds;
  // CategoryResponse category;
  List<CategoryResponse> categories;
  MetropolitanAreaInfo metropolitanArea;
  MetropolitanCityInfo city;
  List<BusinessMediaResponse> businessMedia;
  int allowNotification;
  int isLiked;
  int isFollow;
  List<BusinessHoursResponse> businessHours;
  String businessTimeZone;
  String businessStatus = "";
  // bool isShowClosingSoon = false;
  int currentPlanId;
  String currentPlan;

  factory BusinessUserResponse.fromJson(Map<String, dynamic> json) =>
      BusinessUserResponse(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        dob: json["dob"],
        userType: json["user_type"] == null ? null : json["user_type"],
        isApproved: json["is_approved"] == null ? null : json["is_approved"],
        businessName:
            json["business_name"] == null ? null : json["business_name"],
        businessAddress:
            json["business_address"] == null ? null : json["business_address"],
        businessPhone:
            json["business_phone"] == null ? null : json["business_phone"],
        businessWebsite:
            json["business_website"] == null ? null : json["business_website"],
        businessKeywords: json["business_keywords"] == null
            ? null
            : json["business_keywords"],
        isOnline: json["is_online"] == null ? null : json["is_online"],
        isMobile: json["is_mobile"] == null ? null : json["is_mobile"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        metropolitanAreaId: json["metropolitan_area_id"] == null
            ? null
            : json["metropolitan_area_id"],
        contact: json["contact"] == null ? null : json["contact"],
        isVerified: json["is_verified"] == null ? null : json["is_verified"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        totalLikes: json["total_likes"] == null ? null : json["total_likes"],
        totalDislike:
            json["total_dislike"] == null ? null : json["total_dislike"],
        totalViews: json["total_views"] == null ? null : json["total_views"],
        totalClick: json["total_click"] == null ? null : json["total_click"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        feed: json["feed"] == null
            ? null
            : List<FeedResponse>.from(
                json["feed"].map((x) => FeedResponse.fromJson(x))),
        totalFeeds: json["total_feeds"] == null ? null : json["total_feeds"],
        // category: json["category"] == null
        //     ? null
        //     : CategoryResponse.fromJson(json["category"]),
        categories: json["categories"] == null
            ? null
            : List<CategoryResponse>.from(
                json["categories"].map((x) => CategoryResponse.fromJson(x))),
        metropolitanArea: json["metropolitan_area"] == null
            ? null
            : MetropolitanAreaInfo.fromJson(json["metropolitan_area"]),
        city: json["city"] == null
            ? null
            : MetropolitanCityInfo.fromJson(json["city"]),
        businessMedia: json["business_media"] == null
            ? null
            : List<BusinessMediaResponse>.from(json["business_media"]
                .map((x) => BusinessMediaResponse.fromJson(x))),
        allowNotification: json["allow_notification"] == null
            ? null
            : json["allow_notification"],
        isLiked: json["is_liked"] == null ? null : json["is_liked"],
        cityName: json["city_name"] == null ? null : json["city_name"],
        isFollow: json["is_follow"] == null ? null : json["is_follow"],
        businessHours: json["business_time"] == null
            ? null
            : List<BusinessHoursResponse>.from(json["business_time"]
                .map((x) => BusinessHoursResponse.fromJson(x))),
        businessTimeZone: json["business_time_zone"] == null
            ? null
            : json["business_time_zone"],
        currentPlanId:
            json["current_plan_id"] == null ? null : json["current_plan_id"],
        currentPlan: json["current_plan"] == null ? null : json["current_plan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "dob": dob,
        "user_type": userType == null ? null : userType,
        "is_approved": isApproved == null ? null : isApproved,
        "business_name": businessName == null ? null : businessName,
        "business_address": businessAddress == null ? null : businessAddress,
        "business_phone": businessPhone == null ? null : businessPhone,
        "business_website": businessWebsite == null ? null : businessWebsite,
        "business_keywords": businessKeywords == null ? null : businessKeywords,
        "is_online": isOnline == null ? null : isOnline,
        "is_mobile": isMobile == null ? null : isMobile,
        "category_id": categoryId == null ? null : categoryId,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "city_id": cityId == null ? null : cityId,
        "metropolitan_area_id":
            metropolitanAreaId == null ? null : metropolitanAreaId,
        "contact": contact == null ? null : contact,
        "is_verified": isVerified == null ? null : isVerified,
        "avatar": avatar == null ? null : avatar,
        "total_likes": totalLikes == null ? null : totalLikes,
        "total_dislike": totalDislike == null ? null : totalDislike,
        "total_views": totalViews == null ? null : totalViews,
        "total_click": totalClick == null ? null : totalClick,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "feed": feed == null
            ? null
            : List<dynamic>.from(feed.map((x) => x.toJson())),
        "total_feeds": totalFeeds == null ? null : totalFeeds,
        // "category": category == null ? null : category.toJson(),
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x.toJson())),
        "metropolitan_area":
            metropolitanArea == null ? null : metropolitanArea.toJson(),
        "city": city == null ? null : city.toJson(),
        "city_name": cityName == null ? null : cityName,
        "business_media": businessMedia == null
            ? null
            : List<dynamic>.from(businessMedia.map((x) => x.toJson())),
        "allow_notification":
            allowNotification == null ? null : allowNotification,
        "business_time": businessHours == null
            ? null
            : List<dynamic>.from(businessHours.map((x) => x.toJson())),
        "business_time_zone":
            businessTimeZone == null ? null : businessTimeZone,
        "current_plan_id": currentPlanId == null ? null : currentPlanId,
        "current_plan": currentPlan == null ? null : currentPlan,
      };
}

class BusinessHoursResponse {
  BusinessHoursResponse(
      {this.id,
      this.dayNumber,
      this.userId,
      this.openTime,
      this.closeTime,
      this.createdAt,
      this.updatedAt,
      this.isOpen,
      // this.isShowClosingSoon = false,
      this.businessStatus = ""});

  int id;
  int dayNumber;
  int userId;
  String openTime;
  String closeTime;
  DateTime createdAt;
  DateTime updatedAt;
  bool isOpen = false;
  // bool isShowClosingSoon = false;
  String businessStatus = "";

  factory BusinessHoursResponse.fromJson(Map<String, dynamic> json) =>
      BusinessHoursResponse(
        id: json["id"] == null ? null : json["id"],
        dayNumber: json["day_number"] == null ? null : json["day_number"],
        userId: json["user_id"] == null ? null : json["user_id"],
        openTime: json["start_time"] == null ? null : json["start_time"],
        closeTime: json["end_time"] == null ? null : json["end_time"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "day_number": dayNumber == null ? null : dayNumber,
        "user_id": userId == null ? null : userId,
        "start_time": openTime == null ? null : openTime,
        "end_time": closeTime == null ? null : closeTime,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
