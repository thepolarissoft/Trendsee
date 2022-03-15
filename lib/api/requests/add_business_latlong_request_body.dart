class AddBusinessLatlongRequestBody {
  String latitude;
  String longitude;
  int isDefault;
  int businessLocationId;

  AddBusinessLatlongRequestBody(
    this.latitude,
    this.longitude,
    this.isDefault,
    this.businessLocationId,
  );
}
