class AddUnregisteredBusinessRequestBody {
  String businessName;
  String latitude;
  String longitude;
  String categoryId;

  AddUnregisteredBusinessRequestBody(String businessName, String latitude,
      String longitude, String categoryId) {
    this.businessName = businessName;
    this.latitude = latitude;
    this.longitude = longitude;
    this.categoryId = categoryId;
  }
}
