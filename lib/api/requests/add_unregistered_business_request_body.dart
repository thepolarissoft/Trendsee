class AddUnregisteredBusinessRequestBody {
  String? businessName;
  String? latitude;
  String? longitude;
  String? categoryId;
  String? businessUsername;

  AddUnregisteredBusinessRequestBody(String businessName, String latitude,
      String longitude, String categoryId, String businessUsername) {
    this.businessName = businessName;
    this.latitude = latitude;
    this.longitude = longitude;
    this.categoryId = categoryId;
    this.businessUsername = businessUsername;
  }
}
