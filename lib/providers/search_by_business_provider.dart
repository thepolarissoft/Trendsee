import 'package:flutter/material.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/business_details_response.dart';
import 'package:trendoapp/data/models/business_liked_list_response.dart';
import 'package:trendoapp/data/models/comment_response.dart';
import 'package:trendoapp/data/models/disliked_comments_response.dart';
import 'package:trendoapp/data/models/feed_response.dart';
import 'package:trendoapp/data/models/home_feed_response.dart';
import 'package:trendoapp/data/models/search_business_keywords_response.dart';
import 'package:trendoapp/data/models/search_by_business_response.dart';
import 'package:trendoapp/data/models/verified_user_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/show_alert_view.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class SearchByBusinessProvider extends ChangeNotifier {
  SearchByBusinessResponse searchByBusinessResponse;
  bool isLoading = false;
  List<VerifiedUserResponse> listBusiness = [];
  Baseresponse baseresponse;
  // VerifiedUserResponse selectedBusinessResponse = new VerifiedUserResponse();
  List<String> listMediaImages = [];
  int current = 1;
  BusinessLikedListResponse businessLikedListResponse;
  // List<VerifiedUserResponse> listBusinessLiked = [];
  BusinessDetailsResponse businessDetailsResponse;
  DislikedCommentsResponse dislikedCommentsResponse =
      new DislikedCommentsResponse();
  List<CommentResponse> listDislikedComments = [];
  bool isAvailableComment = false;
  HomeFeedResponse homeFeedResponse;
  List<FeedResponse> listFeedInfo = [];
  bool isAvailableFeedsData = false;
  SearchBusinessKeywordsResponse searchBusinessKeywordsResponse =
      SearchBusinessKeywordsResponse();
  List<String> listBusinessKeyword = [];

  void getSearchByBusinessList(
      BuildContext context,
      int page,
      String searchValue,
      String categoryId,
      String latitude,
      String longitude,
      String distance,
      String cityName) {
    isLoading = true;
    notifyListeners();
    ApiManager(context)
        .getSearchByBusinessList(page.toString(), searchValue, categoryId,
            latitude, longitude, distance, cityName)
        .then((response) {
      searchByBusinessResponse = response;
      if (searchByBusinessResponse.statuscode == 200) {
        if (searchByBusinessResponse != null &&
            searchByBusinessResponse.place != null &&
            searchByBusinessResponse.place.data != null) {
          if (searchByBusinessResponse.place.data.isNotEmpty) {
            if (page == 1) {
              listBusiness.clear();
              listBusiness.addAll(searchByBusinessResponse.place.data);
            } else {
              listBusiness.addAll(searchByBusinessResponse.place.data);
            }
          }
          isLoading = false;
          print(
              "searchByBusinessResponse-> ${searchByBusinessResponse.place.data.length}");
        }
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                getSearchByBusinessList(context, page, searchValue, categoryId,
                    latitude, longitude, distance, cityName);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void followBusiness(BuildContext context, int businessId, int index) {
    isLoading = true;
    ApiManager(context).followBusiness(businessId.toString()).then((response) {
      baseresponse = response;
      if (baseresponse.statuscode == 200) {
        if (baseresponse != null) {
          listBusiness[index].isFollow = 1;
          // GlobalView().showToast(AppToastMessages.follow_done_message);
        }
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                followBusiness(context, businessId, index);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void unFollowBusiness(BuildContext context, int businessId, int index) {
    isLoading = true;
    ApiManager(context)
        .unFollowBusiness(businessId.toString())
        .then((response) {
      baseresponse = response;
      if (baseresponse.statuscode == 200) {
        if (baseresponse != null) {
          listBusiness[index].isFollow = 0;
          // GlobalView().showToast(AppToastMessages.unfollow_done_message);
          isLoading = false;
        }
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                unFollowBusiness(context, businessId, index);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void followBusinessDetails(BuildContext context, int businessId) {
    isLoading = true;
    ApiManager(context).followBusiness(businessId.toString()).then((response) {
      baseresponse = response;
      if (baseresponse.statuscode == 200) {
        if (baseresponse != null) {
          businessDetailsResponse.business.isFollow = 1;
          // GlobalView().showToast(AppToastMessages.follow_done_message);
        }
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                followBusinessDetails(context, businessId);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void unFollowBusinessDetails(BuildContext context, int businessId) {
    isLoading = true;
    ApiManager(context)
        .unFollowBusiness(businessId.toString())
        .then((response) {
      baseresponse = response;
      if (baseresponse.statuscode == 200) {
        if (baseresponse != null) {
          businessDetailsResponse.business.isFollow = 1;
          // GlobalView().showToast(AppToastMessages.unfollow_done_message);
        }
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                unFollowBusinessDetails(context, businessId);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  // void selectedBusinessItem(VerifiedUserResponse businessResponse) {
  //   print("Length-> ${businessResponse.businessMedia.length}");
  // listMediaImages.clear();
  // for (var i = 0; i < businessResponse.businessMedia.length; i++) {
  //   listMediaImages.add(businessResponse.businessMedia[i].media);
  //   print("listMediaImages-> $listMediaImages");
  // }
  //   selectedBusinessResponse = businessResponse;
  //   notifyListeners();
  // }

  void setCurrentIndex(int index) {
    current = index;
    notifyListeners();
  }

  void checkInsLike(BuildContext context, int feedId, int isLike, int index) {
    print("feed_id->> $feedId");
    ApiManager(context).homeFeedLike(feedId, isLike).then((response) {
      baseresponse = response;
      if (baseresponse != null) {
        print("baseresponse--->>== ${baseresponse.msg}");
        if (baseresponse.statuscode == 200 || baseresponse.statuscode == 201) {
          if (isLike == 1) {
            businessDetailsResponse.business.feed[index].isLiked = 1;
            businessDetailsResponse.business.feed[index].totalLikes =
                businessDetailsResponse.business.feed[index].totalLikes + 1;
          } else {
            businessDetailsResponse.business.feed[index].isLiked = 0;
            businessDetailsResponse.business.feed[index].totalLikes =
                businessDetailsResponse.business.feed[index].totalLikes - 1;
          }
          GlobalView().showToast(AppMessages.like_business_text);
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                checkInsLike(context, feedId, isLike, index);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void checkInsDetailsLike(
    BuildContext context,
    int feedId,
    int isLike,
  ) {
    print("feed_id->> $feedId");
    ApiManager(context).homeFeedLike(feedId, isLike).then((response) {
      baseresponse = response;
      if (baseresponse != null) {
        print("baseresponse--->>== ${baseresponse.msg}");
        if (baseresponse.statuscode == 200 || baseresponse.statuscode == 201) {
          if (isLike == 1) {
            businessDetailsResponse.business.isLiked = 1;
            businessDetailsResponse.business.totalLikes =
                businessDetailsResponse.business.totalLikes + 1;
          } else {
            businessDetailsResponse.business.isLiked = 0;
            businessDetailsResponse.business.totalLikes =
                businessDetailsResponse.business.totalLikes - 1;
          }
          GlobalView().showToast(AppMessages.like_business_text);
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                checkInsDetailsLike(context, feedId, isLike);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void getBusinessLikedList(BuildContext context, int page) {
    isLoading = true;
    notifyListeners();

    ApiManager(context).getBusinessLikedList(page.toString()).then((response) {
      businessLikedListResponse = response;
      print("businessLikedListResponse-> ${businessLikedListResponse.place}");
      if (businessLikedListResponse.statuscode == 200) {
        if (businessLikedListResponse != null &&
            businessLikedListResponse.place != null &&
            businessLikedListResponse.place.data != null) {
          if (page == 1) {
            listBusiness.clear();
          }
          listBusiness.addAll(businessLikedListResponse.place.data);
          print(businessLikedListResponse.place.data.length);
          print(listBusiness.length);
          // notifyListeners();
          // GlobalView().showToast(AppToastMessages.sucessfullyDataFetchMessage);
        }
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                getBusinessLikedList(context, page);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void unLikeBusiness(
      BuildContext context, int businessId, int index, String route) {
    ApiManager(context).unlikeBusiness(businessId.toString()).then((response) {
      baseresponse = response;
      if (baseresponse != null) {
        print("baseresponse--->>== ${baseresponse.msg}");
        if (baseresponse.statuscode == 200 || baseresponse.statuscode == 201) {
          listBusiness[index].isLiked = 0;
          if (route.toLowerCase() == "businessilike") {
            listBusiness.removeAt(index);
          }
          //  getBusinessLikedList(context, 1);
          GlobalView().showToast(AppMessages.unlike_business_text);
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                unLikeBusiness(context, businessId, index, route);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void unLikeBusinessDetails(BuildContext context, int businessId) {
    ApiManager(context).unlikeBusiness(businessId.toString()).then((response) {
      baseresponse = response;
      if (baseresponse != null) {
        print("baseresponse--->>== ${baseresponse.msg}");
        if (baseresponse.statuscode == 200 || baseresponse.statuscode == 201) {
          businessDetailsResponse.business.totalLikes =
              businessDetailsResponse.business.totalLikes - 1;
          businessDetailsResponse.business.isLiked = 0;
          // getBusinessLikedList(context, 1);
          GlobalView().showToast(AppMessages.unlike_business_text);
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                unLikeBusinessDetails(context, businessId);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void likeBusiness(BuildContext context, VerifiedUserResponse business) {
    ApiManager(context).likeBusiness(business.id.toString()).then((response) {
      baseresponse = response;
      if (baseresponse != null) {
        print("baseresponse--->>== ${baseresponse.msg}");
        if (baseresponse.statuscode == 200 || baseresponse.statuscode == 201) {
          business.isLiked = 1;
          business.totalLikes += 1;
          business.isDisliked = 0;
          GlobalView().showToast(AppMessages.like_business_text);
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                likeBusiness(context, business);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void businessDetails(BuildContext context, int businessId) async {
    isLoading = true;
    // notifyListeners();
    ApiManager(context)
        .businessDetails(
            businessId,
            StorageUtils.readStringValue(StorageUtils.keyLatitude),
            StorageUtils.readStringValue(StorageUtils.keyLongitude))
        .then((response) {
      businessDetailsResponse = response;
      if (businessDetailsResponse != null) {
        print("businessDetailsResponse--->>== ${businessDetailsResponse.msg}");
        if (businessDetailsResponse.statuscode == 200 ||
            businessDetailsResponse.statuscode == 201) {
          if (businessDetailsResponse.business != null) {
            print(
                "IS DISLIKED=-=-=-=-> ${businessDetailsResponse.business.isDisliked}");
            // print("BUSINESS-> ${businessDetailsResponse.business.toJson()}");
            if (businessDetailsResponse.business.businessMedia.isNotEmpty) {
              listMediaImages.clear();
              for (var i = 0;
                  i < businessDetailsResponse.business.businessMedia.length;
                  i++) {
                listMediaImages.add(
                    businessDetailsResponse.business.businessMedia[i].media);
                print("listMediaImages-> $listMediaImages");
              }
            }
          }
        }
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                businessDetails(context, businessId);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void dislikeBusiness(BuildContext context, VerifiedUserResponse business,
      String reason, int action, String route) {
    ApiManager(context)
        .dislikeBusiness(business.id, reason, action)
        .then((response) {
      baseresponse = response;
      if (baseresponse != null) {
        print("baseresponse--->>== ${baseresponse.msg}");
        if (baseresponse.statuscode == 200 || baseresponse.statuscode == 201) {
          if (action == 1) {
            business.isDisliked = 1;
            business.isLiked = 0;
          } else {
            business.isDisliked = 0;
            business.isLiked = 1;
          }
          if (route == "businessilike") {
            listBusiness.removeWhere((element) => element.id == business.id);
          }
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                dislikeBusiness(context, business, reason, action, route);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void dislikedCommentList(BuildContext context, int page, int businessId) {
    isLoading = true;
    isAvailableComment = true;
    notifyListeners();
    ApiManager(context).dislikedCommentList(page, businessId).then((response) {
      dislikedCommentsResponse = response;
      if (dislikedCommentsResponse != null) {
        print(
            "dislikedCommentsResponse--->>== ${dislikedCommentsResponse.msg}");
        if (dislikedCommentsResponse.statuscode == 200 ||
            dislikedCommentsResponse.statuscode == 201) {
          if (dislikedCommentsResponse.dislike != null) {
            if (dislikedCommentsResponse.dislike.data != null &&
                dislikedCommentsResponse.dislike.data.length > 0 &&
                dislikedCommentsResponse.dislike.data.isNotEmpty) {
              if (page == 1) {
                listDislikedComments.clear();
              }
              listDislikedComments
                  .addAll(dislikedCommentsResponse.dislike.data);
              isAvailableComment = true;
            } else {
              listDislikedComments.clear();
              isAvailableComment = false;
            }
          }
        }
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                dislikedCommentList(context, page, businessId);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void getFeedListbyBusinessID(
      BuildContext context, String businessUserId, int page) async {
    isLoading = true;
    isAvailableFeedsData = false;
    notifyListeners();
    ApiManager(context)
        .getFeedsByBusinessID(businessUserId, page)
        .then((response) {
      homeFeedResponse = response;
      if (homeFeedResponse.statuscode == 200) {
        if (homeFeedResponse != null &&
            homeFeedResponse.data != null &&
            homeFeedResponse.data.data != null) {
          print("ISLOADING-=-=> $isLoading");
          if (page == 1) {
            listFeedInfo.clear();
          }
          listFeedInfo.addAll(homeFeedResponse.data.data);
          print("listFeedInfo Length-->> ${listFeedInfo.length}");
          isAvailableFeedsData = true;
        } else {
          isAvailableFeedsData = false;
        }
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          getFeedListbyBusinessID(context, businessUserId, page);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  List<String> searchBusinessKeywords(
      BuildContext context, String searchValue) {
    // isLoading = true;
    // isAvailableFeedsData = false;
    ApiManager(context)
        .searchBusinessKeywords(searchValue.trim())
        .then((response) {
      searchBusinessKeywordsResponse = response;
      if (searchBusinessKeywordsResponse.statuscode == 200) {
        if (searchBusinessKeywordsResponse != null &&
            searchBusinessKeywordsResponse.data != null) {
          print("ISLOADING-=-=> $isLoading");
          searchBusinessKeywordsResponse.data =
              searchBusinessKeywordsResponse.data.toSet().toList();
          listBusinessKeyword.clear();
          for (var i = 0; i < searchBusinessKeywordsResponse.data.length; i++) {
            listBusinessKeyword
                .add(searchBusinessKeywordsResponse.data[i].trim());
          }
          // listBusinessKeyword.retainWhere(
          //     (s) => s.toLowerCase().contains(searchValue.toLowerCase()));
          print("listBusinessKeyword-=-=--> $listBusinessKeyword");
        }
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          searchBusinessKeywords(context, searchValue);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
    return listBusinessKeyword;
  }
}
