import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trendoapp/api/common/access_token.dart';
import 'package:trendoapp/api/common/api.dart';
import 'package:trendoapp/api/common/exception/exception_helper.dart';
import 'package:trendoapp/api/requests/add_business_hours_request.dart';
import 'package:trendoapp/api/requests/add_business_hours_request_body.dart';
import 'package:trendoapp/api/requests/add_unregistered_business_request.dart';
import 'package:trendoapp/api/requests/add_unregistered_business_request_body.dart';
import 'package:trendoapp/api/requests/business_details_request.dart';
import 'package:trendoapp/api/requests/change_passcode_request.dart';
import 'package:trendoapp/api/requests/change_passcode_request_body.dart';
import 'package:trendoapp/api/requests/click_feed_request.dart';
import 'package:trendoapp/api/requests/create_comment_request.dart';
import 'package:trendoapp/api/requests/create_comment_request_body.dart';
import 'package:trendoapp/api/requests/create_feed_request.dart';
import 'package:trendoapp/api/requests/create_feed_request_body.dart';
import 'package:trendoapp/api/requests/deactivate_account_request.dart';
import 'package:trendoapp/api/requests/delete_account_request.dart';
import 'package:trendoapp/api/requests/delete_business_latlong_request.dart';
import 'package:trendoapp/api/requests/delete_business_latlong_request_body.dart';
import 'package:trendoapp/api/requests/delete_feed_request.dart';
import 'package:trendoapp/api/requests/dislike_business_request.dart';
import 'package:trendoapp/api/requests/dislike_business_request_body.dart';
import 'package:trendoapp/api/requests/disliked_comments_request.dart';
import 'package:trendoapp/api/requests/follow_business_request.dart';
import 'package:trendoapp/api/requests/get_business_liked_list_request.dart';
import 'package:trendoapp/api/requests/get_business_list_by_name_request.dart';
import 'package:trendoapp/api/requests/get_business_list_request.dart';
import 'package:trendoapp/api/requests/get_business_user_profile_request.dart';
import 'package:trendoapp/api/requests/get_categories_list_request.dart';
import 'package:trendoapp/api/requests/get_comment_list_request.dart';
import 'package:trendoapp/api/requests/get_feeds_by_id_request.dart';
import 'package:trendoapp/api/requests/get_home_feed_request.dart';
import 'package:trendoapp/api/requests/get_list_business_home_feed_request.dart';
import 'package:trendoapp/api/requests/get_location_list_request.dart';
import 'package:trendoapp/api/requests/get_metropolitan_areas_list_request.dart';
import 'package:trendoapp/api/requests/get_my_check_ins_request.dart';
import 'package:trendoapp/api/requests/get_notifications_list_request.dart';
import 'package:trendoapp/api/requests/get_profile_request.dart';
import 'package:trendoapp/api/requests/get_search_by_business_request.dart';
import 'package:trendoapp/api/requests/get_user_by_id_token_request.dart';
import 'package:trendoapp/api/requests/graph_click_request.dart';
import 'package:trendoapp/api/requests/graph_like_request.dart';
import 'package:trendoapp/api/requests/graph_view_request.dart';
import 'package:trendoapp/api/requests/home_feed_like_request.dart';
import 'package:trendoapp/api/requests/home_feed_like_request_body.dart';
import 'package:trendoapp/api/requests/like_business_request.dart';
import 'package:trendoapp/api/requests/like_business_request_body.dart';
import 'package:trendoapp/api/requests/logout_request.dart';
import 'package:trendoapp/api/requests/save_notification_settings_request.dart';
import 'package:trendoapp/api/requests/save_notification_settings_request_body.dart';
import 'package:trendoapp/api/requests/save_user_token_request.dart';
import 'package:trendoapp/api/requests/save_user_token_request_body.dart';
import 'package:trendoapp/api/requests/search_business_keywords_request.dart';
import 'package:trendoapp/api/requests/search_by_city_request.dart';
import 'package:trendoapp/api/requests/send_otp_by_business_id_request.dart';
import 'package:trendoapp/api/requests/send_otp_request.dart';
import 'package:trendoapp/api/requests/send_otp_request_body.dart';
import 'package:trendoapp/api/requests/set_passcode_request.dart';
import 'package:trendoapp/api/requests/set_passcode_request_body.dart';
import 'package:trendoapp/api/requests/sign_in_request.dart';
import 'package:trendoapp/api/requests/sign_in_request_body.dart';
import 'package:trendoapp/api/requests/standard_user_registration_request.dart';
import 'package:trendoapp/api/requests/standard_user_registration_request_body.dart';
import 'package:trendoapp/api/requests/unfollow_business_request.dart';
import 'package:trendoapp/api/requests/unlike_business_request.dart';
import 'package:trendoapp/api/requests/unlike_business_request_body.dart';
import 'package:trendoapp/api/requests/add_business_latlong_request.dart';
import 'package:trendoapp/api/requests/add_business_latlong_request_body.dart';
import 'package:trendoapp/api/requests/update_list_keywords_request.dart';
import 'package:trendoapp/api/requests/verify_otp_by_business_id_request.dart';
import 'package:trendoapp/api/requests/verify_otp_by_business_id_request_body.dart';
import 'package:trendoapp/api/requests/verify_otp_request.dart';
import 'package:trendoapp/api/requests/verify_otp_request_body.dart';
import 'package:trendoapp/api/requests/verify_passcode_by_business_id_request.dart';
import 'package:trendoapp/api/requests/verify_passcode_by_business_id_request_body.dart';
import 'package:trendoapp/api/requests/verify_passcode_request.dart';
import 'package:trendoapp/api/requests/verify_passcode_request_body.dart';
import 'package:trendoapp/api/requests/view_feed_request.dart';
import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/business_city_response.dart';
import 'package:trendoapp/data/models/business_details_response.dart';
import 'package:trendoapp/data/models/business_liked_list_response.dart';
import 'package:trendoapp/data/models/business_list_response.dart';
import 'package:trendoapp/data/models/business_user_profile_response.dart';
import 'package:trendoapp/data/models/categories_list_response.dart';
import 'package:trendoapp/data/models/comment_list_response.dart';
import 'package:trendoapp/data/models/disliked_comments_response.dart';
import 'package:trendoapp/data/models/graph_like_response.dart';
import 'package:trendoapp/data/models/home_feed_response.dart';
import 'package:trendoapp/data/models/location_list_response.dart';
import 'package:trendoapp/data/models/metropolitan_areas_list_response.dart';
import 'package:trendoapp/data/models/notification_list_response.dart';
import 'package:trendoapp/data/models/profile_response.dart';
import 'package:trendoapp/data/models/search_business_keywords_response.dart';
import 'package:trendoapp/data/models/search_by_business_response.dart';
import 'package:trendoapp/data/models/update_business_latlong_response.dart';
import 'package:trendoapp/data/models/update_list_keywords_response.dart';
import 'package:trendoapp/data/models/verified_otp_response.dart';

import 'common/exception/exception_type.dart';

class ApiManager {
  BuildContext context;
  ApiManager(this.context);

  Future<Baseresponse> standardUserRegister(
    String firstName,
    String lastName,
    String username,
    String email,
    // String password,
    String dob,
    File avatar,
    String userType,
  ) {
    Completer<Baseresponse> completer = new Completer();
    StandardUserRegistrationRequestBody standardUserRegistrationRequestBody = new StandardUserRegistrationRequestBody(firstName, lastName, username, email, dob, avatar, userType);
    StandardUserRegistrationRequest standardUserRegistrationRequest = new StandardUserRegistrationRequest(standardUserRegistrationRequestBody);
    Api(context: context)
        .request(standardUserRegistrationRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> sendOTP(String? email) {
    Completer<Baseresponse> completer = new Completer();
    SendOtpRequestBody sendOtpRequestBody = new SendOtpRequestBody(email);
    SendOtpRequest sendOtpRequest = new SendOtpRequest(sendOtpRequestBody);
    Api(context: context)
        .request(sendOtpRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<VerifiedOtpResponse> verifyOTP(String? email, String otp) {
    Completer<VerifiedOtpResponse> completer = new Completer();
    VerifyOtpRequestBody verifyOtpRequestBody = new VerifyOtpRequestBody(email, otp);
    VerifyOtpRequest verifyOtpRequest = new VerifyOtpRequest(verifyOtpRequestBody);
    Api(context: context)
        .request(verifyOtpRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(VerifiedOtpResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<ProfileResponse> signIn(String userInput) {
    Completer<ProfileResponse> completer = new Completer();
    SignInRequestBody signInRequestBody = new SignInRequestBody(userInput);
    SignInRequest signInRequest = new SignInRequest(signInRequestBody);
    Api(context: context)
        .request(signInRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(ProfileResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<ProfileResponse> getProfile() {
    Completer<ProfileResponse> completer = new Completer();
    GetProfileRequest getProfileRequest = new GetProfileRequest();
    Api(context: context)
        .request(getProfileRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(ProfileResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> logout() {
    Completer<Baseresponse> completer = new Completer();
    LogoutRequest logoutRequest = new LogoutRequest();
    Api(context: context)
        .request(logoutRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<LocationListResponse> getLocationList() {
    Completer<LocationListResponse> completer = new Completer();
    GetLocationListRequest getLocationListRequest = new GetLocationListRequest();
    Api(context: context)
        .request(getLocationListRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(LocationListResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<BusinessListResponse> getBusinessList(
    int page,
    String latitude,
    String longitude,
    String? distance,
  ) {
    Completer<BusinessListResponse> completer = new Completer();
    GetBusinessListRequest getBusinessListRequest = new GetBusinessListRequest(page, latitude, longitude, distance);
    Api(context: context)
        .request(getBusinessListRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(BusinessListResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> createFeed(
    String description,
    String businessUserId,
    String categoryId,
    String? latitude,
    String? longitude,
    String? locationName,
    String isSupport,
  ) {
    Completer<Baseresponse> completer = new Completer();
    CreateFeedRequestBody createFeedRequestBody = new CreateFeedRequestBody(
      description,
      businessUserId,
      categoryId,
      latitude,
      isSupport,
      longitude,
      locationName,
    );
    CreateFeedRequest createFeedRequest = new CreateFeedRequest(createFeedRequestBody);
    Api(context: context)
        .request(createFeedRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<HomeFeedResponse> getHomeFeedList(String page, String categoryId, String latitude, String longitude, String? distance, String? cityName) async {
    Completer<HomeFeedResponse> completer = new Completer();
    GetHomeFeedRequest getHomeFeedRequest = new GetHomeFeedRequest(page, categoryId, latitude, longitude, distance, cityName);
    Api(context: context)
        .request(getHomeFeedRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(HomeFeedResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  // completer
                  //     .completeError(Exception(AppMessages.token_expired_text)),
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
        // ExceptionHelper().handleExceptions(ExceptionType.NetworkException),
      );
    });
    return completer.future;
  }

  Future<CategoriesListResponse> getCategoriesList() {
    Completer<CategoriesListResponse> completer = new Completer();
    GetCategoriesListRequest getCategoriesListRequest = new GetCategoriesListRequest();
    Api(context: context)
        .request(getCategoriesListRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(CategoriesListResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<HomeFeedResponse> getMyCheckInsList(String page) {
    Completer<HomeFeedResponse> completer = new Completer();
    GetMyCheckInsRequest getMyCheckInsRequest = new GetMyCheckInsRequest(page);
    Api(context: context)
        .request(getMyCheckInsRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(HomeFeedResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> viewFeed(String feedId) {
    Completer<Baseresponse> completer = new Completer();
    ViewFeedRequest viewFeedRequest = new ViewFeedRequest(feedId);
    Api(context: context)
        .request(viewFeedRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<HomeFeedResponse> getBusinessHomeFeedList(String page) {
    Completer<HomeFeedResponse> completer = new Completer();
    GetListBusinessHomeFeedRequest getListBusinessHomeFeedRequest = new GetListBusinessHomeFeedRequest(page);
    Api(context: context)
        .request(getListBusinessHomeFeedRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(HomeFeedResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<CommentListResponse> getCommentList(String feedId) {
    Completer<CommentListResponse> completer = new Completer();
    GetCommentListRequest getCommentListRequest = new GetCommentListRequest(feedId);
    Api(context: context)
        .request(getCommentListRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(CommentListResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<CommentListResponse> createComment(String feedId, String comment) {
    Completer<CommentListResponse> completer = new Completer();
    CreateCommentRequestBody createCommentRequestBody = new CreateCommentRequestBody(feedId, comment);
    CreateCommentRequest createCommentRequest = new CreateCommentRequest(createCommentRequestBody);
    Api(context: context)
        .request(createCommentRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(CommentListResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<MetropolitanAreasListResponse> getMetropolitanAreasList() {
    Completer<MetropolitanAreasListResponse> completer = new Completer();
    GetMetropolitanAreasListRequest getMetropolitanAreasListRequest = new GetMetropolitanAreasListRequest();
    Api(context: context)
        .request(getMetropolitanAreasListRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(MetropolitanAreasListResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> homeFeedLike(int? feedId, int isLike) {
    Completer<Baseresponse> completer = new Completer();
    HomeFeedLikeRequestBody homeFeedLikeRequestBody = new HomeFeedLikeRequestBody(feedId, isLike);
    HomeFeedLikeRequest homeFeedLikeRequest = new HomeFeedLikeRequest(homeFeedLikeRequestBody);
    Api(context: context)
        .request(homeFeedLikeRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<BusinessUserProfileResponse> getBusinessUserProfile() {
    Completer<BusinessUserProfileResponse> completer = new Completer();
    GetBusinessUserProfileRequest getBusinessUserProfileRequest = new GetBusinessUserProfileRequest();
    Api(context: context)
        .request(getBusinessUserProfileRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(BusinessUserProfileResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<SearchByBusinessResponse> getSearchByBusinessList(String page, String searchValue, String categoryId, String latitude, String longitude, String? distance, String? cityName) {
    Completer<SearchByBusinessResponse> completer = new Completer();
    GetSearchByBusinessRequest getSearchByBusinessRequest = new GetSearchByBusinessRequest(page, searchValue, categoryId, latitude, longitude, distance, cityName);
    Api(context: context)
        .request(getSearchByBusinessRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(SearchByBusinessResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> followBusiness(String businessId) {
    Completer<Baseresponse> completer = new Completer();
    FollowBusinessRequest followBusinessRequest = new FollowBusinessRequest(businessId);
    Api(context: context)
        .request(followBusinessRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<NotificationListResponse> getNotificationsList(int page) {
    Completer<NotificationListResponse> completer = new Completer();
    GetNotificationsListRequest getNotificationsListRequest = new GetNotificationsListRequest(page);
    Api(context: context)
        .request(getNotificationsListRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(NotificationListResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> unFollowBusiness(String businessId) {
    Completer<Baseresponse> completer = new Completer();
    UnfollowBusinessRequest unfollowBusinessRequest = new UnfollowBusinessRequest(businessId);
    Api(context: context)
        .request(unfollowBusinessRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<BusinessLikedListResponse> getBusinessLikedList(String page) {
    Completer<BusinessLikedListResponse> completer = new Completer();
    GetBusinessLikedListRequest getBusinessLikedListRequest = new GetBusinessLikedListRequest(page);
    Api(context: context)
        .request(getBusinessLikedListRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(BusinessLikedListResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> deleteMyCheckIns(String feedId) {
    Completer<Baseresponse> completer = new Completer();
    DeleteFeedRequest deleteFeedRequest = new DeleteFeedRequest(feedId);
    Api(context: context)
        .request(deleteFeedRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> unlikeBusiness(String businessId) {
    Completer<Baseresponse> completer = new Completer();
    UnlikeBusinessRequestBody unlikeBusinessRequestBody = new UnlikeBusinessRequestBody(businessId);
    UnlikeBusinessRequest unlikeBusinessRequest = new UnlikeBusinessRequest(unlikeBusinessRequestBody);
    Api(context: context)
        .request(unlikeBusinessRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> likeBusiness(String businessId) {
    Completer<Baseresponse> completer = new Completer();
    LikeBusinessRequestBody likeBusinessRequestBody = new LikeBusinessRequestBody(businessId);
    LikeBusinessRequest likeBusinessRequest = new LikeBusinessRequest(likeBusinessRequestBody);
    Api(context: context)
        .request(likeBusinessRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> saveNotificationSettings(int allowNotification) {
    Completer<Baseresponse> completer = new Completer();
    SaveNotificationSettingsRequestBody saveNotificationSettingsRequestBody = new SaveNotificationSettingsRequestBody(allowNotification);
    SaveNotificationSettingsRequest saveNotificationSettingsRequest = new SaveNotificationSettingsRequest(saveNotificationSettingsRequestBody);
    Api(context: context)
        .request(saveNotificationSettingsRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> deactivateAccount() async {
    Completer<Baseresponse> completer = new Completer();
    DeactivateAccountRequest deactivateAccountRequest = new DeactivateAccountRequest();
    Api(context: context)
        .request(deactivateAccountRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> deleteAccount() {
    Completer<Baseresponse> completer = new Completer();
    DeleteAccountRequest deleteAccountRequest = new DeleteAccountRequest();
    Api(context: context)
        .request(deleteAccountRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> clickFeed(String feedId) {
    Completer<Baseresponse> completer = new Completer();
    ClickFeedRequest clickFeedRequest = new ClickFeedRequest(feedId);
    Api(context: context)
        .request(clickFeedRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<UpdateListKeywordsResponse> updateListKeywords(String businessKeywords) {
    Completer<UpdateListKeywordsResponse> completer = new Completer();
    UpdateListKeywordsRequest updateListKeywordsRequest = new UpdateListKeywordsRequest(businessKeywords);
    Api(context: context)
        .request(updateListKeywordsRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(UpdateListKeywordsResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<GraphResponse> graphLike(int businessUserId, String graphRange) {
    Completer<GraphResponse> completer = new Completer();
    GraphLikeRequest graphLikeRequest = new GraphLikeRequest(businessUserId, graphRange);
    Api(context: context)
        .request(graphLikeRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      GraphResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<GraphResponse> graphView(int businessUserId, String graphRange) {
    Completer<GraphResponse> completer = new Completer();
    GraphViewRequest graphViewRequest = new GraphViewRequest(businessUserId, graphRange);
    Api(context: context)
        .request(graphViewRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      GraphResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<GraphResponse> graphClick(int businessUserId, String graphRange) {
    Completer<GraphResponse> completer = new Completer();
    GraphClickRequest graphClickRequest = new GraphClickRequest(businessUserId, graphRange);
    Api(context: context)
        .request(graphClickRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      GraphResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<BusinessDetailsResponse> businessDetails(int? businessId, String latitude, String longitude) async {
    Completer<BusinessDetailsResponse> completer = new Completer();
    BusinessDetailsRequest businessDetailsRequest = new BusinessDetailsRequest(businessId, latitude, longitude);
    // Response response =
    //     await Api(context: context).request(businessDetailsRequest);
    // try {
    //   print("RESPONSE-> $response");
    //   if (response.statusCode == 200) {
    //     log("BUSINESS DETAILS-> ${response.body}");
    //     // log("BUSINESS DETAILS2-> ${BusinessDetailsResponse.fromJson(json.decode(response.body))}"),
    //     return BusinessDetailsResponse.fromJson(json.decode(response.body));
    //   }
    // } on Exception catch (e) {
    //   print("E $e");
    // }
    Api(context: context)
        .request(businessDetailsRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  // log("BUSINESS DETAILS-> ${response.body}"),
                  log("BUSINESS DETAILS2-> ${BusinessDetailsResponse.fromJson(json.decode(response.body))}"),
                  completer.complete(BusinessDetailsResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> dislikeBusiness(int? businessId, String reason, int action) {
    Completer<Baseresponse> completer = new Completer();
    DislikeBusinessRequestBody dislikeBusinessRequestBody = new DislikeBusinessRequestBody(businessId, reason, action);
    DislikeBusinessRequest dislikeBusinessRequest = new DislikeBusinessRequest(dislikeBusinessRequestBody);
    Api(context: context)
        .request(dislikeBusinessRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<DislikedCommentsResponse> dislikedCommentList(int page, int? businessId) {
    Completer<DislikedCommentsResponse> completer = new Completer();
    DislikedCommentsRequest dislikedCommentsRequest = new DislikedCommentsRequest(page, businessId);
    Api(context: context)
        .request(dislikedCommentsRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      DislikedCommentsResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<BusinessLatlongResponse> addBusinessLatlong(String? latitude, String? longitude, int isDefault, String locationName, String businessUserId) {
    Completer<BusinessLatlongResponse> completer = new Completer();
    AddBusinessLatlongRequestBody addBusinessLatlongRequestBody = new AddBusinessLatlongRequestBody(latitude, longitude, isDefault, locationName, businessUserId);
    AddBusinessLatlongRequest addBusinessLatlongRequest = new AddBusinessLatlongRequest(addBusinessLatlongRequestBody);
    Api(context: context)
        .request(addBusinessLatlongRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                    // Baseresponse.fromJson(json.decode(response.body))),
                    BusinessLatlongResponse.fromJson(
                      json.decode(response.body),
                    ),
                  ),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> deleteBusinessLatlong(
    int? businessLocationId,
  ) {
    Completer<Baseresponse> completer = new Completer();
    DeleteBusinessLatlongRequestBody deleteBusinessLatlongRequestBody = new DeleteBusinessLatlongRequestBody(businessLocationId);
    DeleteBusinessLatlongRequest deleteBusinessLatlongRequest = new DeleteBusinessLatlongRequest(deleteBusinessLatlongRequestBody);
    Api(context: context)
        .request(deleteBusinessLatlongRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<BusinessListResponse> getBusinessByNameList(int page, String searchValue) {
    Completer<BusinessListResponse> completer = new Completer();
    GetBusinessListByNameRequest getBusinessListByNameRequest = new GetBusinessListByNameRequest(page, searchValue);
    Api(context: context)
        .request(getBusinessListByNameRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(BusinessListResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> saveUserTokenForNotification(String? token) {
    Completer<Baseresponse> completer = new Completer();
    SaveUserTokenRequestBody saveUserTokenRequestBody = new SaveUserTokenRequestBody(Platform.isAndroid ? 0 : 1, token);
    SaveUserTokenRequest saveUserTokenRequest = new SaveUserTokenRequest(saveUserTokenRequestBody);
    Api(context: context)
        .request(saveUserTokenRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> addUnregisteredBusiness(String businessName, String latitude, String longitude, String categoryId, String businessUsername) {
    Completer<Baseresponse> completer = new Completer();
    AddUnregisteredBusinessRequestBody addUnregisteredBusinessRequestBody = AddUnregisteredBusinessRequestBody(businessName, latitude, longitude, categoryId, businessUsername);
    AddUnregisteredBusinessRequest addUnregisteredBusinessRequest = AddUnregisteredBusinessRequest(addUnregisteredBusinessRequestBody);
    Api(context: context)
        .request(addUnregisteredBusinessRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> addBusinessHours(String userId, String startTimes, String endTimes, String? businessTimeZone) {
    Completer<Baseresponse> completer = new Completer();
    AddBusinessHoursRequestBody addBusinessHoursRequestBody = AddBusinessHoursRequestBody("0,1,2,3,4,5,6", startTimes, endTimes, businessTimeZone);
    AddBusinessHoursRequest addBusinessHoursRequest = AddBusinessHoursRequest(addBusinessHoursRequestBody);
    Api(context: context)
        .request(addBusinessHoursRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(
                      // Baseresponse.fromJson(json.decode(response.body))),
                      Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<BusinessCityResponse> searchByCity(String searchValue) {
    Completer<BusinessCityResponse> completer = new Completer();
    SearchByCityRequest searchByCityRequest = SearchByCityRequest(searchValue);
    Api(context: context)
        .request(searchByCityRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(BusinessCityResponse.fromJson(json.decode(response.body))),
                  // Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<ProfileResponse> getUserByIdToken(int? userId) {
    Completer<ProfileResponse> completer = new Completer();
    GetUserByIdTokenRequest getUserByIdTokenRequest = GetUserByIdTokenRequest(userId);
    Api(context: context)
        .request(getUserByIdTokenRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(ProfileResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> sendOtpByBusinessID(int businessId) {
    log("businessId FROM Api manager $businessId");
    Completer<Baseresponse> completer = new Completer();
    SendOtpByBusinessIdRequest sendOtpByIdRequest = SendOtpByBusinessIdRequest(businessId: businessId);
    Api(context: context)
        .request(sendOtpByIdRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<VerifiedOtpResponse> verifyOTPByBusinessID(int businessId, int otp) {
    Completer<VerifiedOtpResponse> completer = new Completer();
    VerifyOtpByBusinessIdRequestBody verifyOtpByBusinessIdRequestBody = VerifyOtpByBusinessIdRequestBody(businessId: businessId, otp: otp);
    VerifyOtpByBusinessIdRequest verifyOtpByBusinessIdRequest = VerifyOtpByBusinessIdRequest(verifyOtpByBusinessIdRequestBody);
    Api(context: context)
        .request(verifyOtpByBusinessIdRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(VerifiedOtpResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<HomeFeedResponse> getFeedsByBusinessID(String businessUserId, int page) async {
    Completer<HomeFeedResponse> completer = new Completer();
    GetFeedsByIdRequest getFeedsByIdRequest = GetFeedsByIdRequest(businessUserId: businessUserId, page: page);
    Api(context: context)
        .request(getFeedsByIdRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(HomeFeedResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  // completer
                  //     .completeError(Exception(AppMessages.token_expired_text)),
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
        // ExceptionHelper().handleExceptions(ExceptionType.NetworkException),
      );
    });
    return completer.future;
  }

  Future<SearchBusinessKeywordsResponse> searchBusinessKeywords(String searchValue) async {
    Completer<SearchBusinessKeywordsResponse> completer = new Completer();
    SearchBusinessKeywordsRequest searchBusinessKeywordsRequest = SearchBusinessKeywordsRequest(searchValue: searchValue);
    Api(context: context)
        .request(searchBusinessKeywordsRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(SearchBusinessKeywordsResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  // completer
                  //     .completeError(Exception(AppMessages.token_expired_text)),
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
        // ExceptionHelper().handleExceptions(ExceptionType.NetworkException),
      );
    });
    return completer.future;
  }

  Future<VerifiedOtpResponse> verifyPasscode(String? email, String passcode) {
    Completer<VerifiedOtpResponse> completer = new Completer();
    VerifyPasscodeRequestBody verifyPasscodeRequestBody = VerifyPasscodeRequestBody(email, passcode);
    VerifyPasscodeRequest verifyPasscodeRequest = VerifyPasscodeRequest(verifyPasscodeRequestBody);
    Api(context: context)
        .request(verifyPasscodeRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(VerifiedOtpResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<VerifiedOtpResponse> verifyPasscodeByBusinessID(int businessId, int passcode) {
    Completer<VerifiedOtpResponse> completer = new Completer();
    VerifyPasscodeByBusinessIdRequestBody verifyPasscodeByBusinessIdRequestBody = VerifyPasscodeByBusinessIdRequestBody(businessId: businessId, passcode: passcode);
    VerifyPasscodeByBusinessIdRequest verifyPasscodeByBusinessIdRequest = VerifyPasscodeByBusinessIdRequest(verifyPasscodeByBusinessIdRequestBody);
    Api(context: context)
        .request(verifyPasscodeByBusinessIdRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(VerifiedOtpResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<Baseresponse> changePasscode(String oldPasscode, String newPasscode) {
    Completer<Baseresponse> completer = new Completer();
    ChangePasscodeRequestBody changePasscodeRequestBody = ChangePasscodeRequestBody(oldPasscode: oldPasscode, newPasscode: newPasscode);
    ChangePasscodeRequest changePasscodeRequest = ChangePasscodeRequest(changePasscodeRequestBody);
    Api(context: context)
        .request(changePasscodeRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(Baseresponse(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }

  Future<VerifiedOtpResponse> setPasscode(String? email, String passcode) {
    Completer<VerifiedOtpResponse> completer = new Completer();
    SetPasscodeRequestBody setPasscodeRequestBody = SetPasscodeRequestBody(email, passcode);
    SetPasscodeRequest setPasscodeRequest = SetPasscodeRequest(setPasscodeRequestBody);
    Api(context: context)
        .request(setPasscodeRequest)
        .then((response) => {
              print("RESPONSE-> $response"),
              if (response.statusCode == 200)
                {
                  completer.complete(VerifiedOtpResponse.fromJson(json.decode(response.body))),
                }
              else if (AccessToken().checkTokenExpiry(context: context, response: response) == true)
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.TokenExpiredException)),
                }
              else
                {
                  completer.completeError(ExceptionHelper().handleExceptions(ExceptionType.HttpException)),
                }
            })
        .catchError((error) {
      print("Api MAnager error-> $error");
      completer.completeError(
        Exception(error),
      );
    });
    return completer.future;
  }
}

  // Future<LikeDislikeResponse> homeFeedLikeDislike(
  //     String feed_id, String is_like, String is_dislike) async {
  //   var connectionResult = await (Connectivity().checkConnectivity());
  //   if ((connectionResult == ConnectivityResult.mobile) ||
  //       connectionResult == ConnectivityResult.wifi) {
  //     HomeFeedLikeDislikeRequestBody homeFeedLikeDislikeRequestBody =
  //         new HomeFeedLikeDislikeRequestBody(feed_id, is_like, is_dislike);
  //     HomeFeedLikeDislikeRequest homeFeedLikeDislikeRequest =
  //         new HomeFeedLikeDislikeRequest(homeFeedLikeDislikeRequestBody);

  //     Response response = await Api().request(homeFeedLikeDislikeRequest);
  //     if (response.statusCode == 200) {
  //       return LikeDislikeResponse.fromJson(json.decode(response.body));
  //     } else {
  //       print(response.body);
  //     }
  //   } else {
  //     await DialogUtils.displayDialogCallBack(
  //             context,
  //             AppImages.icon_finder_no_internet,
  //             AppMessages.noInternetTitle,
  //             AppMessages.noInternetMsg,
  //             AppMessages.noInternetSubMsg,
  //             AppMessages.cancelMsg,
  //             AppMessages.okMsg)
  //         .then((value) {
  //       print("Clicked Value-> $value");
  //       if (value == AppMessages.okMsg) {
  //         print("Retry btn clicked");
  //         homeFeedLikeDislike(feed_id, is_like, is_dislike);
  //       } else {
  //         print("Cancel btn clicked");
  //         return null;
  //       }
  //     });
  //   }
  // }


// Future<Baseresponse> businessUserRegister(
  //     String firstName,
  //     String lastName,
  //     String username,
  //     String email,
  //     String businessName,
  //     String businessAddress,
  //     String businessPhone,
  //     String latitude,
  //     String longitude,
  //     String city,
  //     String metropolitanArea,
  //     String contact,
  //     int userType,
  //     int isEighteen,
  //     int isAcceptedTac,
  //     int categoryId,
  //     String advertiseMedia,
  //     int metropolitanAreaId,
  //     int cityId) async {
  //   BusinessUserRegisterRequestBody businessUserRegisterRequestBody =
  //       new BusinessUserRegisterRequestBody(
  //           firstName,
  //           lastName,
  //           username,
  //           email,
  //           businessName,
  //           businessAddress,
  //           businessPhone,
  //           latitude,
  //           longitude,
  //           city,
  //           metropolitanArea,
  //           contact,
  //           userType,
  //           isEighteen,
  //           isAcceptedTac,
  //           categoryId,
  //           advertiseMedia,
  //           metropolitanAreaId,
  //           cityId);
  //   BusinessUserRegisterRequest businessUserRegisterRequest =
  //       new BusinessUserRegisterRequest(businessUserRegisterRequestBody);
  //   Response response = await Api(
  //       context: context,
  //       onCallBack: () {
  //         businessUserRegister(
  //             firstName,
  //             lastName,
  //             username,
  //             email,
  //             businessName,
  //             businessAddress,
  //             businessPhone,
  //             latitude,
  //             longitude,
  //             city,
  //             metropolitanArea,
  //             contact,
  //             userType,
  //             isEighteen,
  //             isAcceptedTac,
  //             categoryId,
  //             advertiseMedia,
  //             metropolitanAreaId,
  //             cityId);
  //       }).request(businessUserRegisterRequest);
  //   if (response.statusCode == 200) {
  //     return Baseresponse.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load data!');
  //   }
  //}