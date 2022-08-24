import 'dart:convert';
import 'dart:io';

import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/policy.dart';

class FileRequestManager {
  // ignore: missing_return
  Future<Baseresponse> stdUserRegister(
      String firstName,
      String lastName,
      String username,
      String email,
      // String dob,
      String filename,
      String userType,
      int isEighteen,
      int isAcceptedTac,
      String passcode) async {
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.user_register_url));
    request.fields["first_name"] = firstName;
    request.fields["last_name"] = lastName;
    request.fields["username"] = username;
    request.fields["email"] = email;
    // request.fields["dob"] = dob;
    request.fields["user_type"] = userType;
    request.fields["is_eighteen"] = isEighteen.toString();
    request.fields["is_accepted_tac"] = isAcceptedTac.toString();
    request.fields["passcode"] = passcode;
    print("FILENAME-> $filename");
    if (filename != null && filename.length > 0) {
      request.files.add(await http.MultipartFile.fromPath('avatar', filename));
    }
    print("REQUEST->> $request");
    var res = await request.send();
    print("RES->> $res");
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      print("RESPONSE AFTER 200 CODE-->> $res");
      // print("RESPONSE-->> ${Baseresponse.fromJson(json.decode(respStr))}");
      // return Baseresponse.fromJson(json.decode(respStr));
      return Baseresponse(json.decode(respStr));
    } else {
      print(res.statusCode);
      print(res);
      return Baseresponse(json.decode(respStr));
    }
    // return null;
    // return res.reasonPhrase;
  }

  // ignore: missing_return
  Future<Baseresponse> updateProfile(
    BuildContext context,
    String firstName,
    String lastName,
    String username,
    String email,
    String filename,
  ) async {
    var request = new http.MultipartRequest('POST', Uri.parse(ApiUrls.update_profile_url));
    request.fields["first_name"] = firstName;
    request.fields["last_name"] = lastName;
    request.fields["username"] = username;
    request.fields["email"] = email;
    request.files.add(await http.MultipartFile.fromPath('avatar', filename));
    request.headers.addAll(IHttpRequest.defaultHeader);
    // print("REQUEST->> $request");
    var res = await request.send();
    // print("RES->> $res");
    final respStr = await res.stream.bytesToString();
    // Response response = (await res.stream.toBytes()) as http.Response;
    if (res.statusCode == 200) {
      // print("RES-->> $res");
      // print("RESPONSE-->> ${Baseresponse.fromJson(json.decode(respStr))}");
      // return Baseresponse.fromJson(json.decode(respStr));
      return Baseresponse(json.decode(respStr));
    }
    //  else if (AccessToken().checkTokenExpiry(
    //       context: context,
    //       response: response,
    //     ) ==
    //     true) {
    //   throw Exception(AppMessages.token_expired_text);
    // }
    else {
      // print(
      //     "RESPONSE====>> ${Baseresponse.fromJson(json.decode(respStr)).toString()}");
      print(res.statusCode);
      return Baseresponse(json.decode(respStr));
    }
    // return res.reasonPhrase;
  }

  // ignore: missing_return
  Future<Baseresponse> businessUserRegister(
    String firstName,
    String lastName,
    String username,
    String email,
    String businessName,
    String businessAddress,
    String businessPhone,
    String latitude,
    String longitude,
    String city,
    String metropolitanArea,
    String contact,
    int userType,
    int isEighteen,
    int isAcceptedTac,
    String categoryIds,
    String advertiseMedia,
    int? metropolitanAreaId,
    int? cityId,
    String businessWebsite,
    int isOnline,
    int isMobile,
  ) async {
    Map data = {
      "first_name": firstName,
      "last_name": lastName,
      "username": username,
      "email": email,
      "business_name": businessName,
      "business_address": businessAddress,
      "business_phone": businessPhone,
      "latitude": latitude,
      "longitude": longitude,
      "city_name": city,
      "metropolitan_area": metropolitanArea,
      "contact": contact,
      "user_type": userType.toString(),
      "is_eighteen": isEighteen.toString(),
      "is_accepted_tac": isAcceptedTac.toString(),
      // "category_id": categoryId.toString(),
      "cm_category_ids": categoryIds,
      "advertise_media": advertiseMedia,
      "metropolitan_area_id": metropolitanAreaId,
      "city_id": cityId,
      "business_website": !businessWebsite.startsWith(AppMessages.http_text) && !businessWebsite.startsWith(AppMessages.https_text)
          ? AppMessages.http_text + businessWebsite
          : businessWebsite,
      "is_online": isOnline,
      "is_mobile": isMobile.toString(),
    };
    // if (!url.startsWith("http")) {
    //   url = "http://" + url;
    // }
    print("DATA==--->>> $data");
    Object body = jsonEncode(data);
    print("BODY==--->>> $body");
    var response = await http.post(Uri.parse(ApiUrls.user_register_url), headers: {"Content-Type": "application/json"}, body: body);

    // print("BODY-->> ${jsonEncode({
    //       "first_name": first_name,
    //       "last_name": last_name,
    //       "username": username,
    //       "email": email,
    //       "business_name": business_name,
    //       "business_address": business_address,
    //       "business_phone": business_phone,
    //       "latitude": latitude,
    //       "longitude": longitude,
    //       "city": city,
    //       "metropolitan_area": metropolitan_area,
    //       "contact": contact,
    //       "user_type": user_type.toString(),
    //       "is_eighteen": is_eighteen.toString(),
    //       "is_accepted_tac": is_accepted_tac.toString(),
    //       "category_id": category_id.toString(),
    //       "advertise_media": advertise_media,
    //     })}");
    print("REQUEST->> ${response.body}");
    if (response.statusCode == 200) {
      // print(
      //     "RESPONSE-->> ${Baseresponse.fromJson(json.decode(response.body))}");
      // return Baseresponse.fromJson(json.decode(response.body));
      return Baseresponse(json.decode(response.body));
    } else {
      print(response.statusCode);
      return Baseresponse(json.decode(response.body));
    }
    // request.fields["first_name"] = first_name;
    // request.fields["last_name"] = last_name;
    // request.fields["username"] = username;
    // request.fields["email"] = email;
    // request.fields["business_name"] = business_name;
    // request.fields["business_address"] = business_address;
    // request.fields["business_phone"] = business_phone;
    // request.fields["latitude"] = latitude;
    // request.fields["longitude"] = longitude;
    // request.fields["city"] = city;
    // request.fields["metropolitan_area"] = metropolitan_area;
    // request.fields["contact"] = contact;
    // // request.fields["advertise_media"] = advertise_media[];

    // for (int i=0;i<advertise_media.length;i++) {
    //   // request.files.add(http.MultipartFile.fromString('advertise_media', item));
    //   request.fields["advertise_media"] = advertise_media[i];
    // }
    // // for (String item in advertise_media) {
    // //   request.files.add(http.MultipartFile.fromString('advertise_media', item));
    // // }
    // request.fields["user_type"] = user_type;
    // request.fields["is_eighteen"] = is_eighteen.toString();
    // request.fields["is_accepted_tac"] = is_accepted_tac.toString();
    // request.fields["category_id"] = category_id.toString();
    // // request.files.add(await http.MultipartFile.fromPath('advertise_media', advertise_media));

    // var res = await request.send();
    // print("RES->> $res");
    // final respStr = await res.stream.bytesToString();
    // print("respStr--> $respStr");
    // if (res.statusCode == 200) {
    //   print("RES-->> $res");
    //   print("RESPONSE-->> ${Baseresponse.fromJson(json.decode(respStr))}");
    //   return Baseresponse.fromJson(json.decode(respStr));
    // } else {
    //   print(res.statusCode);
    // }

    // return res.reasonPhrase;
  }

  // ignore: missing_return
  Future<Baseresponse> businessUserUpdateProfile(
    BuildContext context,
    String firstName,
    String lastName,
    String username,
    String email,
    String businessName,
    String businessAddress,
    String businessPhone,
    String latitude,
    String longitude,
    String contact,
    String categoryIds,
    String advertiseMedia,
    int? metropolitanAreaId,
    int? cityId,
    String cityName,
    String businessWebsite,
    int isOnline,
    int isMobile,
    File avatar,
  ) async {
    Map<String, String> data = {
      "first_name": firstName,
      "last_name": lastName,
      "username": username,
      "email": email,
      "business_name": businessName,
      "business_address": businessAddress,
      "business_phone": businessPhone,
      "latitude": latitude,
      "longitude": longitude,
      "contact": contact,
      // "category_id": categoryIds.toString(),
      "cm_category_ids": categoryIds.toString(),
      "advertise_media": advertiseMedia,
      "metropolitan_area_id": metropolitanAreaId.toString(),
      "city_id": cityId.toString(),
      "city_name": cityName,
      "business_website": !businessWebsite.startsWith(AppMessages.http_text) && !businessWebsite.startsWith(AppMessages.https_text)
          ? AppMessages.http_text + businessWebsite
          : businessWebsite,
      "is_online": isOnline.toString(),
      "is_mobile": isMobile.toString(),
    };
    print("DATA==--->>> $data");
    // Object body = jsonEncode(data);
    // print("BODY==--->>> $body");
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(ApiUrls.update_business_profile_url),
    );
    request.fields.addAll(data);
    if (avatar.path != null && avatar.path.length > 0) {
      request.files.add(await http.MultipartFile.fromPath('avatar', avatar.path));
    }
    request.headers.addAll(IHttpRequest.defaultHeader);
    var res = await request.send();
    print("RES->> $res");
    final respStr = await res.stream.bytesToString();
    print("STATUS CODE ${res.statusCode}");
    if (res.statusCode == 200) {
      print("RESPONSE-->> ${Baseresponse(json.decode(respStr))}");
      // return Baseresponse.fromJson(json.decode(response.body));
      return Baseresponse(json.decode(respStr));
    } else {
      print(res.statusCode);
      return Baseresponse(json.decode(respStr));
    }
  }

  // ignore: missing_return
  Future<String> uploadImageToS3(BuildContext? context, File file, String fileName, String ext) async {
    const _accessKeyId = 'AKIAXB6LPMGHXM3AJBFN';
    const _secretKeyId = 'X/4ADguGDzRSvuxl3tHq3ZA9NvbQvURXs2vtiKyY';
    const _region = 'us-east-2';
    const _s3Endpoint = 'https://trendobucket.s3.us-east-2.amazonaws.com';
    final _file = File(file.path);
    // ignore: deprecated_member_use
    final stream = http.ByteStream(DelegatingStream.typed(_file.openRead()));
    final length = await _file.length();
    final uri = Uri.parse(_s3Endpoint);
    final req = http.MultipartRequest("POST", uri);
    final multipartFile = http.MultipartFile('file', stream, length, filename: fileName);
    final policy = Policy.fromS3PresignedPost('AppsData/BusinessMedia/' + fileName + ext, 'trendobucket', _accessKeyId, 15, length, region: _region);
    final key = SigV4.calculateSigningKey(_secretKeyId, policy.datetime, _region, 's3');
    final signature = SigV4.calculateSignature(key, policy.encode());
    req.files.add(multipartFile);
    req.fields['key'] = policy.key;
    req.fields['acl'] = 'public-read';
    req.fields['X-Amz-Credential'] = policy.credential;
    req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
    req.fields['X-Amz-Date'] = policy.datetime;
    req.fields['Policy'] = policy.encode();
    req.fields['X-Amz-Signature'] = signature;
    try {
      final res = await req.send();
      print("RES-->> $res");
      // await for (var value in res.stream.transform(utf8.decoder)) {
      print(res.statusCode);
      // Response response = (await res.stream.toBytes()) as http.Response;
      if (res.statusCode >= 200 && res.statusCode <= 299) {
        String imageUrl = _s3Endpoint + '/AppsData/BusinessMedia/' + fileName + ext;
        print("imageUrl-->> $imageUrl");
        return imageUrl;
      } else {
        return '';
      }
      // else if (AccessToken().checkTokenExpiry(
      //       context: context,
      //       response: response,
      //     ) ==
      //     true) {
      //   throw Exception(AppMessages.token_expired_text);
      // }
      // }
    } catch (e) {
      print(e.toString());
      return '';
    }
  }

  void deleteImageFromS3(String imageURL) async {
    const _accessKeyId = 'AKIAXB6LPMGHXM3AJBFN';
    const _secretKeyId = 'X/4ADguGDzRSvuxl3tHq3ZA9NvbQvURXs2vtiKyY';
    const _region = 'us-east-2';
    // const _s3Endpoint = 'https://trendobucket.s3.us-east-2.amazonaws.com';
    // final _file = File(file.path);
    // final stream = http.ByteStream(DelegatingStream.typed(_file.openRead()));
    // final length = await _file.length();
    // final uri = Uri.parse(_s3Endpoint);
    // final req = http.delete(Uri.parse(imageURL));
    print("imageURL-->> $imageURL");
    final request = http.Request("DELETE", Uri.parse(imageURL));

    // final multipartFile =
    //     http.MultipartFile('file', stream, length, filename: fileName);
    final policy = Policy.fromS3PresignedPost(imageURL, 'trendobucket', _accessKeyId, 15, 1024, region: _region);

    final key = SigV4.calculateSigningKey(_secretKeyId, policy.datetime, _region, 's3');
    final signature = SigV4.calculateSignature(key, policy.encode());
    request.headers.addAll(<String, String>{
      'key': policy.key,
      'acl': 'public-read',
      'X-Amz-Credential': policy.credential,
      'X-Amz-Date': policy.datetime,
      'Policy': policy.encode(),
      'X-Amz-Signature': signature
    });

    try {
      final res = await request.send();
      print("RES-->> $res");
      // await for (var value in res.stream.transform(utf8.decoder)) {
      print(res.statusCode);
      final respStr = await res.stream.bytesToString();
      print(respStr);
      if (res.statusCode >= 200 && res.statusCode <= 299) {
        // String imageUrl =
        //     _s3Endpoint + '/AppsData/BusinessMedia/' + fileName + ext;
        // print("imageUrl-->> $imageUrl");

      }
      // }
    } catch (e) {
      print(e.toString());
    }
  }
}
