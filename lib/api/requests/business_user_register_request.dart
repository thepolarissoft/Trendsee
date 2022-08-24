import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/business_user_register_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class BusinessUserRegisterRequest implements IHttpRequest {
  @override
  String? absolutePath = ApiUrls.user_register_url;

  @override
  Object? body;

  @override
  HttpMethod? httpMethod = HttpMethod.POST;

  @override
  Map<String, dynamic> get headers {
    return Map<String, String>();
  }

  @override
  Map<String, String> get parameters {
    return Map<String, String>();
  }

  BusinessUserRegisterRequest(
      BusinessUserRegisterRequestBody businessUserRegisterRequestBody) {
    var map = new Map<String, String?>();
    map['first_name'] = businessUserRegisterRequestBody.firstName;
    map['last_name'] = businessUserRegisterRequestBody.lastName;
    map['username'] = businessUserRegisterRequestBody.username;
    map['email'] = businessUserRegisterRequestBody.email;
    map['business_name'] = businessUserRegisterRequestBody.businessName;
    map['business_address'] = businessUserRegisterRequestBody.businessAddress;
    map['business_phone'] = businessUserRegisterRequestBody.businessPhone;
    map['latitude'] = businessUserRegisterRequestBody.latitude;
    map['longitude'] = businessUserRegisterRequestBody.longitude;
    map['city'] = businessUserRegisterRequestBody.city;
    map['metropolitan_area'] = businessUserRegisterRequestBody.metropolitanArea;
    map['contact'] = businessUserRegisterRequestBody.contact;
    // map = {'advertise_media': businessUserRegisterRequestBody.advertise_media};
    map['user_type'] = businessUserRegisterRequestBody.userType;
    map['is_eighteen'] = businessUserRegisterRequestBody.isEighteen;
    map['is_accepted_tac'] = businessUserRegisterRequestBody.isAcceptedTac;
    map['category_id'] = businessUserRegisterRequestBody.categoryId;
    map['advertise_media'] = businessUserRegisterRequestBody.advertiseMedia;
    map['metropolitan_area_id'] =
        businessUserRegisterRequestBody.metropolitanAreaId.toString();
    map['city_id'] = businessUserRegisterRequestBody.cityId.toString();

    this.body = map;
    print("Body-->> $body");
  }
}
