class AddBusinessLatlongRequestBody {
  String latitude;
  String longitude;
  int isDefault;
  int businessLocationId;
  String locationName;
  AddBusinessLatlongRequestBody(
    this.latitude,
    this.longitude,
    this.isDefault,
    this.businessLocationId,
    this.locationName,
  );
}
