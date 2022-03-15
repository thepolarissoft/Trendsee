import 'package:trendoapp/data/models/login_user_response.dart';

class CommentResponse {
  CommentResponse({
    this.id,
    this.businessUserId,
    this.comment,
    this.feedId,
    this.userId,
    this.reason,
    this.commentId,
    this.tagUserId,
    this.createdAt,
    this.updatedAt,
    this.isLiked,
    this.tagUserName,
    this.replies,
    this.user,
  });

  int id;
  int businessUserId;
  String comment;
  int feedId;
  int userId;
  String reason;
  int commentId;
  int tagUserId;
  DateTime createdAt;
  DateTime updatedAt;
  int isLiked;
  String tagUserName;
  List<dynamic> replies;
  LoginUserResponse user;

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      CommentResponse(
        id: json["id"] == null ? null : json["id"],
        businessUserId:
            json["business_user_id"] == null ? null : json["business_user_id"],
        comment: json["comment"] == null ? null : json["comment"],
        feedId: json["feed_id"] == null ? null : json["feed_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        reason: json["reason"] == null ? null : json["reason"],
        commentId: json["comment_id"] == null ? null : json["comment_id"],
        tagUserId: json["tag_user_id"] == null ? null : json["tag_user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isLiked: json["is_liked"] == null ? null : json["is_liked"],
        tagUserName:
            json["tag_user_name"] == null ? null : json["tag_user_name"],
        replies: json["replies"] == null
            ? null
            : List<dynamic>.from(json["replies"].map((x) => x)),
        user: json["user"] == null
            ? null
            : LoginUserResponse.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "comment": comment == null ? null : comment,
        "feed_id": feedId == null ? null : feedId,
        "user_id": userId == null ? null : userId,
        "comment_id": commentId == null ? null : commentId,
        "tag_user_id": tagUserId == null ? null : tagUserId,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "is_liked": isLiked == null ? null : isLiked,
        "tag_user_name": tagUserName == null ? null : tagUserName,
        "replies":
            replies == null ? null : List<dynamic>.from(replies.map((x) => x)),
        "user": user == null ? null : user.toJson(),
      };
}
