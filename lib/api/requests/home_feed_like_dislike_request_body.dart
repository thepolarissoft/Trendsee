class HomeFeedLikeDislikeRequestBody {
  String feedId;
  String isLike;
  String isDislike;

  HomeFeedLikeDislikeRequestBody(
      String feedId, String isLike, String isDislike) {
    this.feedId = feedId;
    this.isLike = isLike;
    this.isDislike = isDislike;
  }
}
