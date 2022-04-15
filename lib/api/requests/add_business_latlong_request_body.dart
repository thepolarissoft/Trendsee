class AddBusinessLatlongRequestBody {
  String latitude;
  String longitude;
  int isDefault;
  int businessLocationId;
  String locationName;
  String businessUserId;
  AddBusinessLatlongRequestBody(
    this.latitude,
    this.longitude,
    this.isDefault,
    this.locationName,
    this.businessUserId,
  );
}
