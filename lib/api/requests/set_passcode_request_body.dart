class SetPasscodeRequestBody {
  String? email;
  String? passcode;
  SetPasscodeRequestBody(String? email, String passcode) {
    this.email = email;
    this.passcode = passcode;
  }
}
