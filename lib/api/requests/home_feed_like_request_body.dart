class HomeFeedLikeRequestBody {
  int? feedId;
  int? isLike;
  HomeFeedLikeRequestBody(int? feedId, int isLike) {
    this.feedId = feedId;
    this.isLike = isLike;
  }
}
