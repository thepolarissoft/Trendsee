class SaveUserTokenRequestBody {
  int platform;
  String token;

  SaveUserTokenRequestBody(int platform, String token) {
    this.platform = platform;
    this.token = token;
  }
}
