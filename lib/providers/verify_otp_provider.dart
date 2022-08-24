import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/api/common/access_token.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/profile_response.dart';
import 'package:trendoapp/data/models/verified_otp_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/show_alert_view.dart';
import 'package:trendoapp/presentation/screens/businessUser/multiple_business_user_list/multiple_business_user_list_screen.dart';
import 'package:trendoapp/presentation/screens/common/passcode_verification_screen.dart';
import 'package:trendoapp/utils/dialog_utils.dart';
import 'package:trendoapp/utils/preference_utils.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class VerifyOtpProvider extends ChangeNotifier {
  bool isLoading = false;
  VerifiedOtpResponse? verifiedOtpResponse;
  Baseresponse? baseresponse;
  ProfileResponse? profileResponse;

  // void verifyOtp(BuildContext context, String email, String otp) {
  //   isLoading = true;
  //   notifyListeners();
  //   ApiManager(context).verifyOTP(email, otp).then((response) {
  //     verifiedOtpResponse = response;
  //     print("verifiedOtpResponse CODE-> ${verifiedOtpResponse.statuscode}");
  //     print("verifiedOtpResponse msg-> ${verifiedOtpResponse.msg}");
  //     if (verifiedOtpResponse.statuscode == 200) {
  //       if (verifiedOtpResponse != null && verifiedOtpResponse.user != null) {
  //         log("verifiedOtpResponse Token-=-=-=-=> ${verifiedOtpResponse.token}");
  //         print(verifiedOtpResponse.user.toString());
  //         isLoading = false;
  //         StorageUtils.writeIntValue(
  //             StorageUtils.keyUserType, verifiedOtpResponse.user.userType);
  //         if (verifiedOtpResponse.user.userType == 2) {
  //           if (verifiedOtpResponse.user.isMobile == 1) {
  //             StorageUtils.writeStringValue(
  //                 StorageUtils.keyBusinessType, AppMessages.mobile_text);
  //           } else {
  //             if (verifiedOtpResponse.user.isOnline == 1) {
  //               StorageUtils.writeStringValue(
  //                   StorageUtils.keyBusinessType, AppMessages.online_text);
  //             } else {
  //               StorageUtils.writeStringValue(
  //                   StorageUtils.keyBusinessType, AppMessages.physical_text);
  //             }
  //           }
  //         }
  //         log("StorageUtils TOKEN=-==>> ${StorageUtils.readStringValue(StorageUtils.keyToken)}");
  //         print(verifiedOtpResponse.user.toString());
  //         if (StorageUtils.readIntValue(StorageUtils.keyUserType) != null) {
  //           if (StorageUtils.readIntValue(StorageUtils.keyUserType) == 1) {
  //             StorageUtils.writeStringValue(
  //                 StorageUtils.keyToken, verifiedOtpResponse.token);
  //             AccessToken().setTokenValue(
  //                 StorageUtils.readStringValue(StorageUtils.keyToken));
  //             Navigator.pushNamed(context, AppRoutes.timeline_route_name);
  //           } else if (StorageUtils.readIntValue(StorageUtils.keyUserType) ==
  //               2) {
  //             if (verifiedOtpResponse.user.isApproved == 0) {
  //               Navigator.pushNamed(context, AppRoutes.signin_route_name);
  //             } else if (verifiedOtpResponse.user.isApproved == 1) {
  //               StorageUtils.writeStringValue(
  //                   StorageUtils.keyToken, verifiedOtpResponse.token);
  //               AccessToken().setTokenValue(
  //                   StorageUtils.readStringValue(StorageUtils.keyToken));
  //               PreferenceUtils.setStringValue(
  //                   PreferenceUtils.keyBusinessUserProfileObject,
  //                   json.encode(verifiedOtpResponse.user));
  //               PreferenceUtils.setIntValue(
  //                   PreferenceUtils.keyUserId, verifiedOtpResponse.user.id);
  //               Navigator.pushNamed(
  //                   context, AppRoutes.business_timeline_route_name);
  //             }
  //           }
  //         }
  //         log("StorageUtils TOKEN=-==-->> ${StorageUtils.readStringValue(StorageUtils.keyToken)}");
  //       }
  //     } else if (verifiedOtpResponse.statuscode == 402
  //         //  &&
  //         //     verifiedOtpResponse.msg == "Business needs approval by admin"
  //         ) {
  //       DialogUtils().showSupportAlertDialog(context, "approval");
  //       Navigator.pushNamed(
  //           context, AppRoutes.successful_email_verification_route_name);
  //     } else {
  //       GlobalView().showToast(verifiedOtpResponse.msg);
  //     }
  //     isLoading = false;
  //     notifyListeners();
  //   }).catchError((onError) {
  //     isLoading = false;
  //     print("ONERROR->> $onError");
  //     ShowAlertView(
  //             context: context,
  //             onCallBack: () {
  //               verifyOtp(context, email, otp);
  //             },
  //             exception: onError)
  //         .showAlertDialog();
  //     notifyListeners();
  //   });
  // }

  void verifyOtpNew(BuildContext context, String? email, String otp) {
    isLoading = true;
    notifyListeners();
    ApiManager(context).verifyOTP(email, otp).then((response) async {
      verifiedOtpResponse = response;
      print("verifiedOtpResponse CODE-> ${verifiedOtpResponse!.statuscode}");
      print("verifiedOtpResponse msg-> ${verifiedOtpResponse!.msg}");
      if (verifiedOtpResponse!.statuscode == 200) {
        if (verifiedOtpResponse != null) {
          if (verifiedOtpResponse!.standardUser != null) {
            isLoading = false;
            log("verifiedOtpResponse Token-=-=-=-=> ${verifiedOtpResponse!.token}");
            print(verifiedOtpResponse!.standardUser.toString());
            isLoading = false;
            StorageUtils.writeIntValue(StorageUtils.keyUserType,
                verifiedOtpResponse!.standardUser!.userType);
            if (StorageUtils.readIntValue(StorageUtils.keyUserType) != null) {
              if (StorageUtils.readIntValue(StorageUtils.keyUserType) == 1) {
                StorageUtils.writeStringValue(
                    StorageUtils.keyToken, verifiedOtpResponse!.token);
                AccessToken().setTokenValue(
                    StorageUtils.readStringValue(StorageUtils.keyToken));
                Navigator.pushNamed(context, AppRoutes.timeline_route_name);
              }
            }
          } else if (verifiedOtpResponse!.businessUsers != null) {
            print(verifiedOtpResponse!.businessUsers.toString());
            isLoading = false;
            if (verifiedOtpResponse!.businessUsers != null &&
                verifiedOtpResponse!.businessUsers!.isNotEmpty &&
                verifiedOtpResponse!.businessUsers!.length == 1) {
              if (verifiedOtpResponse!.businessUsers![0].isApproved == 0) {
                Navigator.pushNamed(context, AppRoutes.signin_route_name);
              } else if (verifiedOtpResponse!.businessUsers![0].isApproved == 1) {
                log("Verified Token ${verifiedOtpResponse!.token}");
                getUserByIdToken(
                    context, verifiedOtpResponse!.businessUsers![0].id);
                // StorageUtils.writeStringValue(
                //     StorageUtils.keyToken, verifiedOtpResponse.token);
                // AccessToken().setTokenValue(
                //     StorageUtils.readStringValue(StorageUtils.keyToken));
                // PreferenceUtils.setStringValue(
                //     PreferenceUtils.keyBusinessUserProfileObject,
                //     json.encode(verifiedOtpResponse.businessUsers[0]));
                // PreferenceUtils.setIntValue(PreferenceUtils.keyUserId,
                //     verifiedOtpResponse.businessUsers[0].id);
                // Navigator.pushNamed(
                //     context, AppRoutes.business_timeline_route_name);
              }
            } else {
              Navigator.pushNamed(
                  context, AppRoutes.multiple_business_user_list_route_name,
                  arguments: MultipleBusinessUserListArgs(
                      listBusinessUsers: verifiedOtpResponse!.businessUsers));
            }
          }
          log("StorageUtils TOKEN=-==-->> ${StorageUtils.readStringValue(StorageUtils.keyToken)}");
        }
      } else if (verifiedOtpResponse!.statuscode == 402) {
        DialogUtils().showSupportAlertDialog(context, "approval");
        Navigator.pushNamed(
            context, AppRoutes.successful_email_verification_route_name);
      } else {
        GlobalView().showToast(verifiedOtpResponse!.msg!);
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                verifyOtpNew(context, email, otp);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void verifyPasscode(BuildContext context, String? email, String passcode) {
    isLoading = true;
    notifyListeners();
    ApiManager(context).verifyPasscode(email, passcode).then((response) async {
      verifiedOtpResponse = response;
      print("verifiedOtpResponse CODE-> ${verifiedOtpResponse!.statuscode}");
      print("verifiedOtpResponse msg-> ${verifiedOtpResponse!.msg}");
      if (verifiedOtpResponse!.statuscode == 200) {
        if (verifiedOtpResponse != null) {
          if (verifiedOtpResponse!.standardUser != null) {
            isLoading = false;
            log("verifiedOtpResponse Token-=-=-=-=> ${verifiedOtpResponse!.token}");
            print(verifiedOtpResponse!.standardUser.toString());
            isLoading = false;
            StorageUtils.writeIntValue(StorageUtils.keyUserType,
                verifiedOtpResponse!.standardUser!.userType);
            if (StorageUtils.readIntValue(StorageUtils.keyUserType) != null) {
              if (StorageUtils.readIntValue(StorageUtils.keyUserType) == 1) {
                StorageUtils.writeStringValue(
                    StorageUtils.keyToken, verifiedOtpResponse!.token);
                AccessToken().setTokenValue(
                    StorageUtils.readStringValue(StorageUtils.keyToken));
                Navigator.pushNamed(context, AppRoutes.timeline_route_name);
              }
            }
          } else if (verifiedOtpResponse!.businessUsers != null) {
            print(verifiedOtpResponse!.businessUsers.toString());
            isLoading = false;
            if (verifiedOtpResponse!.businessUsers != null &&
                verifiedOtpResponse!.businessUsers!.isNotEmpty &&
                verifiedOtpResponse!.businessUsers!.length == 1) {
              if (verifiedOtpResponse!.businessUsers![0].isApproved == 0) {
                Navigator.pushNamed(context, AppRoutes.signin_route_name);
              } else if (verifiedOtpResponse!.businessUsers![0].isApproved == 1) {
                log("Verified Token ${verifiedOtpResponse!.token}");
                getUserByIdToken(
                    context, verifiedOtpResponse!.businessUsers![0].id);
                // StorageUtils.writeStringValue(
                //     StorageUtils.keyToken, verifiedOtpResponse.token);
                // AccessToken().setTokenValue(
                //     StorageUtils.readStringValue(StorageUtils.keyToken));
                // PreferenceUtils.setStringValue(
                //     PreferenceUtils.keyBusinessUserProfileObject,
                //     json.encode(verifiedOtpResponse.businessUsers[0]));
                // PreferenceUtils.setIntValue(PreferenceUtils.keyUserId,
                //     verifiedOtpResponse.businessUsers[0].id);
                // Navigator.pushNamed(
                //     context, AppRoutes.business_timeline_route_name);
              }
            } else {
              Navigator.pushNamed(
                  context, AppRoutes.multiple_business_user_list_route_name,
                  arguments: MultipleBusinessUserListArgs(
                      listBusinessUsers: verifiedOtpResponse!.businessUsers));
            }
          }
          log("StorageUtils TOKEN=-==-->> ${StorageUtils.readStringValue(StorageUtils.keyToken)}");
        }
      } else if (verifiedOtpResponse!.statuscode == 402) {
        DialogUtils().showSupportAlertDialog(context, "approval");
        Navigator.pushNamed(
            context, AppRoutes.successful_email_verification_route_name);
      } else {
        GlobalView().showToast(verifiedOtpResponse!.msg!);
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                verifyOtpNew(context, email, passcode);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void sendOtp(BuildContext context, String? email) {
    isLoading = true;
    notifyListeners();
    ApiManager(context).sendOTP(email).then((response) {
      baseresponse = response;
      if (baseresponse!.statuscode == 200) {
        if (baseresponse != null) {
          isLoading = false;
          GlobalView().showToast(AppToastMessages.send_otp_verified_message);
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
                sendOtp(context, email);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void getUserByIdToken(BuildContext context, int? userId) async {
    isLoading = true;
    notifyListeners();
    ApiManager(context).getUserByIdToken(userId).then((response) {
      profileResponse = response;
      print("STATUS CODE-> ${profileResponse!.statuscode}");
      print("MSG-> ${profileResponse!.msg}");
      if (profileResponse != null) {
        isLoading = false;
        if (profileResponse!.statuscode == 200) {
          StorageUtils.writeIntValue(
              StorageUtils.keyUserType, profileResponse!.user!.userType);
          StorageUtils.writeStringValue(
              StorageUtils.keyToken, profileResponse!.token);
          AccessToken().setTokenValue(
              StorageUtils.readStringValue(StorageUtils.keyToken));
          PreferenceUtils.setStringValue(
              PreferenceUtils.keyBusinessUserProfileObject,
              json.encode(profileResponse!.user));
          PreferenceUtils.setIntValue(
              PreferenceUtils.keyUserId, profileResponse!.user!.id!);
          Navigator.pushNamed(context, AppRoutes.business_timeline_route_name);
        } else {
          GlobalView().showToast(profileResponse!.msg!);
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          getUserByIdToken(context, userId);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void sendOTPByBusinessID(BuildContext context, int businessID) async {
    isLoading = true;
    notifyListeners();
    ApiManager(context).sendOtpByBusinessID(businessID).then((response) {
      baseresponse = response;
      print("STATUS CODE-> ${baseresponse!.statuscode}");
      print("MSG-> ${baseresponse!.msg}");
      if (baseresponse != null) {
        isLoading = false;
        if (baseresponse!.statuscode == 200) {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => EmailVerificationScreen(
          //               isVerifyByBusinessID: true,
          //               businessID: businessID,
          //             )));
          Navigator.pushNamed(context, AppRoutes.passcodeVerification,
              arguments: PasscodeVerificationArgs(
                isVerifyByBusinessID: true,
                businessID: businessID,
              ));
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          sendOTPByBusinessID(context, businessID);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void verifyOtpByBusinessID(BuildContext context, int businessID, int otp) {
    isLoading = true;
    notifyListeners();
    ApiManager(context)
        .verifyOTPByBusinessID(businessID, otp)
        .then((response) async {
      verifiedOtpResponse = response;
      print("verifiedOtpResponse CODE-> ${verifiedOtpResponse!.statuscode}");
      print("verifiedOtpResponse msg-> ${verifiedOtpResponse!.msg}");
      if (verifiedOtpResponse!.statuscode == 200) {
        if (verifiedOtpResponse != null) {
          if (verifiedOtpResponse!.businessUsers != null) {
            print(verifiedOtpResponse!.businessUsers.toString());
            isLoading = false;
            if (verifiedOtpResponse!.businessUsers != null &&
                verifiedOtpResponse!.businessUsers!.isNotEmpty &&
                verifiedOtpResponse!.businessUsers!.length == 1) {
              if (verifiedOtpResponse!.businessUsers![0].isApproved == 0) {
                Navigator.pushNamed(context, AppRoutes.signin_route_name);
              } else if (verifiedOtpResponse!.businessUsers![0].isApproved == 1) {
                log("Verified Token ${verifiedOtpResponse!.token}");
                StorageUtils.writeStringValue(
                    StorageUtils.keyToken, verifiedOtpResponse!.token);
                AccessToken().setTokenValue(
                    StorageUtils.readStringValue(StorageUtils.keyToken));
                PreferenceUtils.setStringValue(
                    PreferenceUtils.keyBusinessUserProfileObject,
                    json.encode(verifiedOtpResponse!.businessUsers![0]));
                PreferenceUtils.setIntValue(PreferenceUtils.keyUserId,
                    verifiedOtpResponse!.businessUsers![0].id!);
                Navigator.pushNamed(
                    context, AppRoutes.business_timeline_route_name);
              }
            }
            // else {
            //   Navigator.pushNamed(
            //       context, AppRoutes.multiple_business_user_list_route_name,
            //       arguments: MultipleBusinessUserListArgs(
            //           listBusinessUsers: verifiedOtpResponse.businessUsers));
            // }
          }
          log("StorageUtils TOKEN=-==-->> ${StorageUtils.readStringValue(StorageUtils.keyToken)}");
        }
      } else if (verifiedOtpResponse!.statuscode == 402) {
        DialogUtils().showSupportAlertDialog(context, "approval");
        Navigator.pushNamed(
            context, AppRoutes.successful_email_verification_route_name);
      } else {
        GlobalView().showToast(verifiedOtpResponse!.msg!);
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                verifyOtpByBusinessID(context, businessID, otp);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void verifyPasscodeByBusinessID(
      BuildContext context, int businessID, int passcode) {
    isLoading = true;
    notifyListeners();
    ApiManager(context)
        .verifyPasscodeByBusinessID(businessID, passcode)
        .then((response) async {
      verifiedOtpResponse = response;
      print("verifiedOtpResponse CODE-> ${verifiedOtpResponse!.statuscode}");
      print("verifiedOtpResponse msg-> ${verifiedOtpResponse!.msg}");
      if (verifiedOtpResponse!.statuscode == 200) {
        if (verifiedOtpResponse != null) {
          if (verifiedOtpResponse!.businessUsers != null) {
            print(verifiedOtpResponse!.businessUsers.toString());
            isLoading = false;
            if (verifiedOtpResponse!.businessUsers != null &&
                verifiedOtpResponse!.businessUsers!.isNotEmpty &&
                verifiedOtpResponse!.businessUsers!.length == 1) {
              if (verifiedOtpResponse!.businessUsers![0].isApproved == 0) {
                Navigator.pushNamed(context, AppRoutes.signin_route_name);
              } else if (verifiedOtpResponse!.businessUsers![0].isApproved == 1) {
                log("Verified Token ${verifiedOtpResponse!.token}");
                StorageUtils.writeStringValue(
                    StorageUtils.keyToken, verifiedOtpResponse!.token);
                AccessToken().setTokenValue(
                    StorageUtils.readStringValue(StorageUtils.keyToken));
                PreferenceUtils.setStringValue(
                    PreferenceUtils.keyBusinessUserProfileObject,
                    json.encode(verifiedOtpResponse!.businessUsers![0]));
                PreferenceUtils.setIntValue(PreferenceUtils.keyUserId,
                    verifiedOtpResponse!.businessUsers![0].id!);
                Navigator.pushNamed(
                    context, AppRoutes.business_timeline_route_name);
              }
            }
            // else {
            //   Navigator.pushNamed(
            //       context, AppRoutes.multiple_business_user_list_route_name,
            //       arguments: MultipleBusinessUserListArgs(
            //           listBusinessUsers: verifiedOtpResponse.businessUsers));
            // }
          }
          log("StorageUtils TOKEN=-==-->> ${StorageUtils.readStringValue(StorageUtils.keyToken)}");
        }
      } else if (verifiedOtpResponse!.statuscode == 402) {
        DialogUtils().showSupportAlertDialog(context, "approval");
        Navigator.pushNamed(
            context, AppRoutes.successful_email_verification_route_name);
      } else {
        GlobalView().showToast(verifiedOtpResponse!.msg!);
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                verifyPasscodeByBusinessID(context, businessID, passcode);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void setPasscode(BuildContext context, String? email, String passcode) {
    isLoading = true;
    notifyListeners();
    ApiManager(context).setPasscode(email, passcode).then((response) async {
      verifiedOtpResponse = response;
      print("verifiedOtpResponse CODE-> ${verifiedOtpResponse!.statuscode}");
      print("verifiedOtpResponse msg-> ${verifiedOtpResponse!.msg}");
      if (verifiedOtpResponse!.statuscode == 200) {
        if (verifiedOtpResponse != null) {
          if (verifiedOtpResponse!.standardUser != null) {
            isLoading = false;
            log("verifiedOtpResponse Token-=-=-=-=> ${verifiedOtpResponse!.token}");
            print(verifiedOtpResponse!.standardUser.toString());
            isLoading = false;
            StorageUtils.writeIntValue(StorageUtils.keyUserType,
                verifiedOtpResponse!.standardUser!.userType);
            if (StorageUtils.readIntValue(StorageUtils.keyUserType) != null) {
              if (StorageUtils.readIntValue(StorageUtils.keyUserType) == 1) {
                StorageUtils.writeStringValue(
                    StorageUtils.keyToken, verifiedOtpResponse!.token);
                AccessToken().setTokenValue(
                    StorageUtils.readStringValue(StorageUtils.keyToken));
                Navigator.pushNamed(context, AppRoutes.timeline_route_name);
              }
            }
          } else if (verifiedOtpResponse!.businessUsers != null) {
            print(verifiedOtpResponse!.businessUsers.toString());
            isLoading = false;
            if (verifiedOtpResponse!.businessUsers != null &&
                verifiedOtpResponse!.businessUsers!.isNotEmpty &&
                verifiedOtpResponse!.businessUsers!.length == 1) {
              if (verifiedOtpResponse!.businessUsers![0].isApproved == 0) {
                Navigator.pushNamed(context, AppRoutes.signin_route_name);
              } else if (verifiedOtpResponse!.businessUsers![0].isApproved == 1) {
                log("Verified Token ${verifiedOtpResponse!.token}");
                getUserByIdToken(
                    context, verifiedOtpResponse!.businessUsers![0].id);
                // StorageUtils.writeStringValue(
                //     StorageUtils.keyToken, verifiedOtpResponse.token);
                // AccessToken().setTokenValue(
                //     StorageUtils.readStringValue(StorageUtils.keyToken));
                // PreferenceUtils.setStringValue(
                //     PreferenceUtils.keyBusinessUserProfileObject,
                //     json.encode(verifiedOtpResponse.businessUsers[0]));
                // PreferenceUtils.setIntValue(PreferenceUtils.keyUserId,
                //     verifiedOtpResponse.businessUsers[0].id);
                // Navigator.pushNamed(
                //     context, AppRoutes.business_timeline_route_name);
              }
            } else {
              Navigator.pushNamed(
                  context, AppRoutes.multiple_business_user_list_route_name,
                  arguments: MultipleBusinessUserListArgs(
                      listBusinessUsers: verifiedOtpResponse!.businessUsers));
            }
          }
          log("StorageUtils TOKEN=-==-->> ${StorageUtils.readStringValue(StorageUtils.keyToken)}");
        }
      } else if (verifiedOtpResponse!.statuscode == 402) {
        DialogUtils().showSupportAlertDialog(context, "approval");
        Navigator.pushNamed(
            context, AppRoutes.successful_email_verification_route_name);
      } else {
        GlobalView().showToast(verifiedOtpResponse!.msg!);
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                verifyOtpNew(context, email, passcode);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }
}
