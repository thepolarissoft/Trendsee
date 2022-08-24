import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/standard_user_registration_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class StandardUserRegistrationRequest implements IHttpRequest {
  @override
  String? absolutePath = ApiUrls.user_register_url;

  @override
  Object? body;

  @override
  HttpMethod? httpMethod = HttpMethod.POST;

  @override
  Map<String, String> get headers {
    return Map<String, String>();
  }

  @override
  Map<String, String> get parameters {
    return Map<String, String>();
  }

  StandardUserRegistrationRequest(
      StandardUserRegistrationRequestBody standardUserRegistrationRequestBody) {
    var map = new Map<String, dynamic>();
    map["first_name"] = standardUserRegistrationRequestBody.firstName;
    map["last_name"] = standardUserRegistrationRequestBody.lastName;
    map["username"] = standardUserRegistrationRequestBody.username;
    map["email"] = standardUserRegistrationRequestBody.email;
    // map["password"] = standardUserRegistrationRequestBody.password;
    map["dob"] = standardUserRegistrationRequestBody.dob;
    map["avatar"] = standardUserRegistrationRequestBody.avatar;
    map["user_type"] = standardUserRegistrationRequestBody.userType;
    // final msg = jsonEncode(map);
    print("AVATAR-->> ${map["avatar"]}");
    this.body = map;
    print('BODY $body');
  }
}
