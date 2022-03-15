class VerifyOtpRequestBody {
  String email;
  String otp;
  VerifyOtpRequestBody(String email, String otp) {
    this.email = email;
    this.otp = otp;
  }
}
