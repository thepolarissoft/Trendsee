class CreateFeedRequestBody {
  String? description;
  String? businessUserId;
  String? categoryId;
  String? latitude;
  String? longitude;
  String? locationName;

  CreateFeedRequestBody(
      String description,
      String businessUserId,
      String categoryId,
      String? latitude,
      String? longitude,
      String? locationName) {
    this.description = description;
    this.businessUserId = businessUserId;
    this.categoryId = categoryId;
    this.latitude = latitude;
    this.longitude = longitude;
    this.locationName = locationName;
  }
}
