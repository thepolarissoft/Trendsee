class CreateCommentRequestBody {
  String? feedId;
  String? comment;
  CreateCommentRequestBody(String feedId, String comment) {
    this.feedId = feedId;
    this.comment = comment;
  }
}
