class DislikeBusinessRequestBody {
  int? businessId;
  String? reason;
  int? action;

  DislikeBusinessRequestBody(int? businessId, String reason, int action) {
    this.businessId = businessId;
    this.reason = reason;
    this.action = action;
  }
}
