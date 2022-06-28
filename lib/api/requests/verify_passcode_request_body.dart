class VerifyPasscodeRequestBody {
  String email;
  String passcode;
  VerifyPasscodeRequestBody(String email, String passcode) {
    this.email = email;
    this.passcode = passcode;
  }
}
