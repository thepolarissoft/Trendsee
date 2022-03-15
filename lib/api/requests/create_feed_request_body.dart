class CreateFeedRequestBody {
  String description;
  String businessUserId;
  String categoryId;

  CreateFeedRequestBody(
      String description, String businessUserId, String categoryId) {
    this.description = description;
    this.businessUserId = businessUserId;
    this.categoryId = categoryId;
  }
}
