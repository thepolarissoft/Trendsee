import 'dart:io';
import 'package:flutter/material.dart';
import 'package:trendoapp/api/file_request_manager.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/standard_user_image_model.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/show_alert_view.dart';
import 'package:trendoapp/presentation/screens/common/set_passcode_screen.dart';
import 'package:trendoapp/utils/dialog_utils.dart';
import 'package:trendoapp/utils/preference_utils.dart';

class StandardUserProvider extends ChangeNotifier {
  Baseresponse baseresponse;
  bool isLoading = false;
  File userImage;
  bool isPrivacyCheckBoxValue = false;
  bool isAgeCheckBoxValue = false;

  void standardUserRegister(
      BuildContext context,
      String firstName,
      String lastName,
      String username,
      String email,
      // String password,
      // String dob,
      String avatar,
      String userType,
      int isEighteen,
      int isAcceptedTac) {
    isLoading = true;
    notifyListeners();
    FileRequestManager()
        .stdUserRegister(firstName, lastName, username, email, avatar, userType,
            isEighteen, isAcceptedTac)
        .then((response) {
      baseresponse = response;
      print("RESPONSE->> ${baseresponse.toJsonData()}");
      if (baseresponse.statuscode == 200) {
        if (baseresponse != null) {
          isLoading = false;
          print("baseresponse--->>== ${baseresponse.msg}");
          GlobalView().showToast(AppToastMessages.create_account_message);
          PreferenceUtils.setStringValue(PreferenceUtils.keyEmail, email);
          print(
              "EMAIL-->> ${PreferenceUtils.getStringValue(PreferenceUtils.keyEmail)}");
          // Navigator.pushNamed(context, AppRoutes.emailVerificationRouteName);
          if (baseresponse.isThisFirstBusinessWithThisEmail == true) {
            Navigator.pushNamed(context, AppRoutes.setPasscode,
                arguments: SetPasscodeArgs(email: email));
          } else {
            DialogUtils.displayDialogCallBack(
                    context,
                    "",
                    AppMessages.registrationSuccessfullyText,
                    AppMessages.registerAnotherBusinessTitle,
                    "",
                    "",
                    AppMessages.ok_text)
                .then((value) {
              if (value == AppMessages.ok_text) {
                Navigator.pushNamed(context, AppRoutes.signin_route_name);
              }
            });
          }

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => EmailVerificationScreen(email: email)));
        }
      } else if (baseresponse.statuscode == 400) {
        DialogUtils.displayDialogCallBack(
            context,
            "",
            AppMessages.already_registered_title,
            baseresponse.msg,
            "",
            AppMessages.cancel_text,
            AppMessages.ok_text);
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                standardUserRegister(context, firstName, lastName, username,
                    email, avatar, userType, isEighteen, isAcceptedTac);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void changePrivacyCheckBoxValue() {
    if (isPrivacyCheckBoxValue) {
      isPrivacyCheckBoxValue = false;
      notifyListeners();
    } else {
      isPrivacyCheckBoxValue = true;
      notifyListeners();
    }
  }

  void changeAgeCheckBoxValue() {
    if (isAgeCheckBoxValue) {
      isAgeCheckBoxValue = false;
      notifyListeners();
    } else {
      isAgeCheckBoxValue = true;
      notifyListeners();
    }
  }

  void setStandardUserImage(File images) {
    StandardUserImageModel standardUserImageModel =
        new StandardUserImageModel(images);
    // standardUserImageModel.standardUserImage = images;
    userImage = standardUserImageModel.standardUserImage;
    print("USER IMAGE====----->> $userImage");
    // userImage = images;
    notifyListeners();
  }

  // PickedFile getUserImage() {
  //   return userImage;
  //   notifyListeners();
  // }
}

// void standard_user_register(
//   BuildContext context,
//   String first_name,
//   String last_name,
//   String username,
//   String email,
//   // String password,
//   String dob,
//   File avatar,
//   String user_type,
// ) async {
//   isLoading = true;
//   notifyListeners();
//   baseresponse = await ApiManager(context).standardUserRegister(
//       first_name, last_name, username, email, dob, avatar, user_type);
//   if (baseresponse != null) {
//     isLoading = false;
//     if (baseresponse.statuscode == 200) {
//       GlobalView().showToast(AppToastMessages.createAccountMessage);
//       PreferenceUtils.setStringValue(PreferenceUtils.KEY_EMAIL, email);
//       print(
//           "EMAIL-->> ${PreferenceUtils.getStringValue(PreferenceUtils.KEY_EMAIL)}");
//       // Navigator.pushNamed(context, AppRoutes.emailVerificationRouteName);
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => EmailVerificationScreen(email)));
//     } else {
//       print("baseresponse-> ${baseresponse.statuscode}");
//       GlobalView().showToast(baseresponse.msg);
//     }
//   } else {
//     isLoading = true;
//   }
//   notifyListeners();
// }
