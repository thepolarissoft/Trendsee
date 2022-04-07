import 'package:trendoapp/data/models/business_user_response.dart';
import 'package:trendoapp/data/models/category_response.dart';
import 'package:trendoapp/data/models/comment_response.dart';
import 'package:trendoapp/data/models/login_user_response.dart';

class FeedResponse {
  FeedResponse({
    this.id,
    this.title,
    this.description,
    this.categoryId,
    this.userId,
    this.businessUserId,
    this.totalLikes,
    this.totalDislikes,
    this.totalComments,
    this.totalShares,
    this.createdAt,
    this.updatedAt,
    this.totalFeeds,
    this.isLiked,
    this.isDisliked,
    // this.images,
    // this.category,
    this.categories,
    this.user,
    this.businessUser,
    this.comments,
    this.locationName,
  });

  int id;
  String title;
  String description;
  int categoryId;
  int userId;
  int businessUserId;
  int totalLikes;
  int totalDislikes;
  int totalComments;
  int totalShares;
  DateTime createdAt;
  DateTime updatedAt;
  int totalFeeds;
  int isLiked;
  int isDisliked;
  // List<dynamic> images;
  // CategoryResponse category;
  List<CategoryResponse> categories;
  LoginUserResponse user;
  BusinessUserResponse businessUser;
  List<CommentResponse> comments;
  String locationName;
  factory FeedResponse.fromJson(Map<String, dynamic> json) => FeedResponse(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        businessUserId:
            json["business_user_id"] == null ? null : json["business_user_id"],
        totalLikes: json["total_likes"] == null ? null : json["total_likes"],
        totalDislikes:
            json["total_dislikes"] == null ? null : json["total_dislikes"],
        totalComments:
            json["total_comments"] == null ? null : json["total_comments"],
        totalShares: json["total_shares"] == null ? null : json["total_shares"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        totalFeeds: json["total_feeds"] == null ? null : json["total_feeds"],
        isLiked: json["is_liked"] == null ? null : json["is_liked"],
        isDisliked: json["is_disliked"] == null ? null : json["is_disliked"],
        // images: json["images"] == null
        //     ? null
        //     : List<dynamic>.from(json["images"].map((x) => x)),
        // category: json["category"] == null
        //     ? null
        //     : CategoryResponse.fromJson(json["category"]),
        categories: json["categories"] == null
            ? null
            : List<CategoryResponse>.from(
                json["categories"].map((x) => CategoryResponse.fromJson(x))),
        user: json["user"] == null
            ? null
            : LoginUserResponse.fromJson(json["user"]),
        businessUser: json["business_user"] == null
            ? null
            : BusinessUserResponse.fromJson(json["business_user"]),
        comments: json["comments"] == null
            ? null
            : List<CommentResponse>.from(
                json["comments"].map((x) => CommentResponse.fromJson(x))),
        locationName:
            json["location_name"] == null ? null : json["location_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "category_id": categoryId == null ? null : categoryId,
        "user_id": userId == null ? null : userId,
        "business_user_id": businessUserId == null ? null : businessUserId,
        "total_likes": totalLikes == null ? null : totalLikes,
        "total_dislikes": totalDislikes == null ? null : totalDislikes,
        "total_comments": totalComments == null ? null : totalComments,
        "total_shares": totalShares == null ? null : totalShares,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "total_feeds": totalFeeds == null ? null : totalFeeds,
        "is_liked": isLiked == null ? null : isLiked,
        "is_disliked": isDisliked == null ? null : isDisliked,
        // "images":
        //     images == null ? null : List<dynamic>.from(images.map((x) => x)),
        // "category": category == null ? null : category.toJson(),
        "user": user == null ? null : user.toJson(),
        "business_user": businessUser == null ? null : businessUser.toJson(),
        "comments": comments == null
            ? null
            : List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}
