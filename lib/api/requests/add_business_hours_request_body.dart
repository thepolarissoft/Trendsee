class AddBusinessHoursRequestBody {
  String dayNumbers;
  String startTimes;
  String endTimes;
  String businessTimeZone;
  AddBusinessHoursRequestBody(String dayNumbers, String startTimes,
      String endTimes, String businessTimeZone) {
    this.dayNumbers = dayNumbers;
    this.startTimes = startTimes;
    this.endTimes = endTimes;
    this.businessTimeZone = businessTimeZone;
  }
}
