import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/feed_response.dart';
import 'package:trendoapp/data/models/home_feed_response.dart';
import 'package:trendoapp/data/models/like_dislike_response.dart';
import 'package:trendoapp/data/models/profile_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/show_alert_view.dart';
import 'package:trendoapp/utils/preference_utils.dart';

class HomeFeedResponseProvider extends ChangeNotifier {
  HomeFeedResponse? homeFeedResponse;
  bool isLoading = false;
  List<FeedResponse> listFeedInfo = [];
  late LikeDislikeResponse likeDislikeResponse;
  FeedResponse feedResponse = new FeedResponse();
  Baseresponse? baseresponse;
  ProfileResponse? profileResponse;
  var list = [];
  bool isAvailableHomeData = false;

  void getHomeFeedList(BuildContext context, String categoryId, String latitude,
      String longitude, String? distance,String? cityName) async {
    isLoading = true;
    isAvailableHomeData = false;
    notifyListeners();
    int page =
        homeFeedResponse == null ? 1 : homeFeedResponse!.data!.currentPage! + 1;
    ApiManager(context)
        .getHomeFeedList(page.toString(), categoryId == null ? "0" : categoryId,
            latitude, longitude, distance,cityName)
        .then((response) {
      homeFeedResponse = response;
      if (homeFeedResponse!.statuscode == 200) {
        if (homeFeedResponse != null &&
            homeFeedResponse!.data != null &&
            homeFeedResponse!.data!.data != null) {
          print("ISLOADING-=-=> $isLoading");
          if (page == 1) {
            listFeedInfo.clear();
          }
          listFeedInfo.addAll(homeFeedResponse!.data!.data!);
          print("listFeedInfo Length-->> ${listFeedInfo.length}");
          isAvailableHomeData = true;
        } else {
          isAvailableHomeData = false;
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
          getHomeFeedList(context, categoryId, latitude, longitude, distance,cityName);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void setFeedResponse(int index) {
    feedResponse = listFeedInfo[index];
    notifyListeners();
  }

  void changeHomeFeedLikeDislikeValue(
      String event, String isLike, String isDislike, int index) {
    listFeedInfo[index].totalLikes = 0;
    listFeedInfo[index].totalDislikes = 0;
    if (event.toLowerCase() == "like") {
      if (isLike == "1") {
        listFeedInfo[index].isLiked = 1;
        listFeedInfo[index].isDisliked = 0;
      } else {
        listFeedInfo[index].isLiked = 0;
        listFeedInfo[index].isDisliked = 0;
      }
      listFeedInfo[index].totalLikes = likeDislikeResponse.feed!.totalLikes;
      listFeedInfo[index].totalDislikes =
          likeDislikeResponse.feed!.totalDislikes;
    } else if (event.toLowerCase() == "dislike") {
      if (isDislike == "1") {
        listFeedInfo[index].isLiked = 0;
        listFeedInfo[index].isDisliked = 1;
      } else {
        listFeedInfo[index].isLiked = 0;
        listFeedInfo[index].isDisliked = 0;
      }
      listFeedInfo[index].totalDislikes =
          likeDislikeResponse.feed!.totalDislikes;
      listFeedInfo[index].totalLikes = likeDislikeResponse.feed!.totalLikes;
    }
    notifyListeners();
  }

  void changeFeedDetailLikeDislikeValue(
      String event, String isLike, String isDislike) {
    print("Like-->> $isLike" + "  DisLike-->> $isDislike");
    feedResponse.totalLikes = 0;
    feedResponse.totalDislikes = 0;
    if (event.toLowerCase() == "like") {
      if (isLike == "1") {
        feedResponse.isLiked = 1;
        feedResponse.isDisliked = 0;
      } else {
        feedResponse.isLiked = 0;
        feedResponse.isDisliked = 0;
      }
      feedResponse.totalLikes = likeDislikeResponse.feed!.totalLikes;
      feedResponse.totalDislikes = likeDislikeResponse.feed!.totalDislikes;
    } else if (event.toLowerCase() == "dislike") {
      if (isDislike == "1") {
        feedResponse.isLiked = 0;
        feedResponse.isDisliked = 1;
      } else {
        feedResponse.isLiked = 0;
        feedResponse.isDisliked = 0;
      }
      feedResponse.totalDislikes = likeDislikeResponse.feed!.totalDislikes;
      feedResponse.totalLikes = likeDislikeResponse.feed!.totalLikes;
    }
    print("feedResponse.isLiked->> ${feedResponse.isLiked}");
    print("feedResponse.isDisliked->> ${feedResponse.isDisliked}");

    notifyListeners();
  }

  void getMyCheckInsList(BuildContext context, int page) async {
    isLoading = true;
    notifyListeners();
    ApiManager(context).getMyCheckInsList(page.toString()).then((response) {
      homeFeedResponse = response;
      if (homeFeedResponse!.statuscode == 200) {
        if (homeFeedResponse != null) {
          if (homeFeedResponse!.data != null &&
              homeFeedResponse!.data!.data != null) {
            // listFeedInfo.clear();
            listFeedInfo.addAll(homeFeedResponse!.data!.data!);
            print("listFeedInfo Length-->> ${listFeedInfo.length}");
            print("nextPageUrl====>> ${homeFeedResponse!.data!.nextPageUrl}");
          }
          isLoading = false;
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          getMyCheckInsList(context, page);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void homeFeedLike(
      BuildContext context, int feedId, int isLike, int index) async {
    ApiManager(context).homeFeedLike(feedId, isLike).then((response) {
      baseresponse = response;
      if (baseresponse != null) {
        print("baseresponse--->>== ${baseresponse!.msg}");
        if (baseresponse!.statuscode == 200 || baseresponse!.statuscode == 201) {
          if (isLike == 1) {
            listFeedInfo[index].isLiked = 1;
            listFeedInfo[index].totalLikes = listFeedInfo[index].totalLikes! + 1;
            print("IS LIKED-> ${listFeedInfo[index].isLiked}");
            print("TOTAL LIKES-> ${listFeedInfo[index].totalLikes}");
          } else {
            listFeedInfo[index].isLiked = 0;
            listFeedInfo[index].totalLikes = listFeedInfo[index].totalLikes! - 1;
            print("IS LIKED==-> ${listFeedInfo[index].isLiked}");
            print("TOTAL LIKES===-> ${listFeedInfo[index].totalLikes}");
          }
          GlobalView().showToast(AppMessages.like_business_text);
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          homeFeedLike(context, feedId, isLike, index);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void checkInDetailsLike(
    BuildContext context,
    int? feedId,
    int isLike,
  ) async {
    print("feed_id->> $feedId");
    ApiManager(context).homeFeedLike(feedId, isLike).then((response) {
      baseresponse = response;
      if (baseresponse != null) {
        print("baseresponse--->>== ${baseresponse!.msg}");
        if (baseresponse!.statuscode == 200 || baseresponse!.statuscode == 201) {
          print("feedResponse.isLiked-> ${feedResponse.isLiked}");
          print("feedResponse.totalLikes-> ${feedResponse.totalLikes}");
          if (isLike == 1) {
            feedResponse.isLiked = 1;
            feedResponse.totalLikes = feedResponse.totalLikes! + 1;
          } else {
            feedResponse.isLiked = 0;
            feedResponse.totalLikes = feedResponse.totalLikes! - 1;
          }
          GlobalView().showToast(AppMessages.like_business_text);
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          checkInDetailsLike(context, feedId, isLike);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void deleteMycheckIns(
      BuildContext context, int? feedId, int index, String route) async {
    ApiManager(context).deleteMyCheckIns(feedId.toString()).then((response) {
      baseresponse = response;
      if (baseresponse!.statuscode == 200) {
        if (baseresponse != null) {
          print("baseresponse--->>== ${baseresponse!.msg}");
          if (baseresponse!.statuscode == 200) {
            // GlobalView().showToast(baseresponse.msg);
            if (route.toLowerCase() == "profile") {
              profileResponse!.user!.totalFeeds =
                  profileResponse!.user!.totalFeeds! - 1;
              listFeedInfo.removeAt(index);
            } else {
              listFeedInfo[index].totalFeeds =
                  listFeedInfo[index].totalFeeds! - 1;
              listFeedInfo.removeAt(index);
            }
          }
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          deleteMycheckIns(context, feedId, index, route);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void checkInsLike(
      BuildContext context, FeedResponse feedResponse2, int isLike) async {
    print("feed_id->> ${feedResponse2.id}");
    ApiManager(context)
        .homeFeedLike(
      feedResponse2.id,
      isLike,
    )
        .then((response) {
      baseresponse = response;
      if (baseresponse != null) {
        print("feedResponse2.isLiked-> ${feedResponse2.isLiked}");
        print("feedResponse2.totalLikes-> ${feedResponse2.totalLikes}");
        print("baseresponse--->>== ${baseresponse!.msg}");
        if (baseresponse!.statuscode == 200 || baseresponse!.statuscode == 201) {
          if (isLike == 1) {
            feedResponse2.isLiked = 1;
            feedResponse2.totalLikes = feedResponse2.totalLikes! + 1;
            GlobalView().showToast(AppMessages.like_business_text);
          } else {
            feedResponse2.isLiked = 0;
            feedResponse2.totalLikes = feedResponse2.totalLikes! - 1;
            GlobalView().showToast(AppMessages.unlike_business_text);
          }
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          checkInsLike(context, feedResponse2, isLike);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void getProfile(BuildContext context) async {
    isLoading = true;
    // notifyListeners();
    ApiManager(context).getProfile().then((response) {
      if (response.statuscode == 200) {
        profileResponse = response;
        PreferenceUtils.setObject(PreferenceUtils.keyStandardUserProfileObject,
            json.encode(profileResponse));
        if (response != null) {
          isLoading = false;
          if (response.user!.businessMedia!.isNotEmpty) {}
          // notifyListeners();
          listFeedInfo.clear();
          listFeedInfo.addAll(profileResponse!.user!.feed!);
          print("PROFILE RESPONSE-->> ${response.user!.avatar}");
        } else {
          isLoading = true;
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                getProfile(context);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }
}



    // // if (Provider.of<ConnectionProvider>(context, listen: false)
    // //     .isInternetConnection) {
    // isLoading = true;
    // notifyListeners();
    // homeFeedResponse = await ApiManager(context).getHomeFeedList(
    //     page.toString(),
    //     categoryId == null ? "0" : categoryId,
    //     latitude,
    //     longitude,
    //     distance);
    // if (homeFeedResponse.statuscode == 200) {
    //   if (homeFeedResponse != null &&
    //       homeFeedResponse.data != null &&
    //       homeFeedResponse.data.data != null) {
    //     if (page == 1) {
    //       listFeedInfo.clear();
    //     }
    //     print("LENGTH-> ${homeFeedResponse.data.data.length}");
    //     listFeedInfo.addAll(homeFeedResponse.data.data);
    //     // list = listFeedInfo.toList();
    //     // list = List<FeedResponse>.from(listFeedInfo);
    //     // // List<FeedResponse> _list = list;
    //     // if (list.isNotEmpty) {
    //     //   // print("_list->> ${_list[0].category.name}");
    //     //   print("LIST description-> ${list[0].description}");
    //     //   print("listFeedInfo description-> ${listFeedInfo[0].description}");
    //     // }
    //     print("listFeedInfo Length-->> ${listFeedInfo.length}");
    //     print("nextPageUrl====>> ${homeFeedResponse.data.nextPageUrl}");
    //     // print("FIRST NAME->> ${listFeedInfo[0].user.firstName}");
    //   } else {
    //     isLoading = false;
    //   }
    //   isLoading = false;
    // }
    // // } else {
    // //   GlobalView().showToast(AppMessages.no_internet_msg);
    // // }



      // void home_feed_like_dislike(BuildContext context, String feed_id,
  //     String event, String is_like, String is_dislike, int index) async {
  //   // isLoading = true;
  //   // notifyListeners();
  //   print("Like-->> $is_like" + "DisLike-->> $is_dislike");
  //   likeDislikeResponse = await ApiManager(context)
  //       .homeFeedLikeDislike(feed_id, is_like, is_dislike);
  //   if (likeDislikeResponse != null) {
  //     // isLoading = false;
  //     print("likeDislikeResponse--->>== ${likeDislikeResponse.msg}");
  //
  //       changeHomeFeedLikeDislikeValue(event, is_like, is_dislike, index);
  //       GlobalView().showToast(likeDislikeResponse.msg);
  //
  //   } else {
  //     // isLoading = true;
  //   }
  // }


  // void feed_detail_like_dislike(
  //     BuildContext context,
  //     String feed_id,
  //     String is_like,
  //     String is_dislike,
  //     // FeedResponse feedResponse,
  //     String event) async {
  //   print("feed_id->> $feed_id");
  //   likeDislikeResponse = await ApiManager(context)
  //       .homeFeedLikeDislike(feed_id, is_like, is_dislike);
  //   if (likeDislikeResponse != null) {
  //     print("likeDislikeResponse--->>== ${likeDislikeResponse.msg}");
  //
  //       changeFeedDetailLikeDislikeValue(event, is_like, is_dislike);
  //       GlobalView().showToast(likeDislikeResponse.msg);
  //
  //   } else {}
  //   notifyListeners();
  // }
