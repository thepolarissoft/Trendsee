import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/data/models/profile_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/base_response_provider.dart';
import 'package:trendoapp/providers/profile_provider.dart';
import 'package:trendoapp/providers/standard_user_provider.dart';
import 'package:trendoapp/utils/preference_utils.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstNameTextEditingController =
      new TextEditingController();

  TextEditingController lastNameTextEditingController =
      new TextEditingController();

  TextEditingController userNameTextEditingController =
      new TextEditingController();

  TextEditingController emailTextEditingController =
      new TextEditingController();

  // TextEditingController dateofBirthTextEditingController =
  //     new TextEditingController();

  PickedFile _imageFile;
  dynamic pickImageError;
  File imageFileBody;
  String profilePic = "";
  File profilePicFile;
  ProfileResponse profileResponse;

  @override
  void initState() {
    super.initState();
    getProfileData();
    // Provider.of<ProfileProvider>(context, listen: false).getProfile(context);
    // if (Provider.of<ProfileProvider>(context, listen: false).profileResponse !=
    //     null) {
    // profilePic = Provider.of<ProfileProvider>(context, listen: false)
    //     .profileResponse
    //     .user
    //     .avatar;
    // firstNameTextEditingController.text =
    //     Provider.of<ProfileProvider>(context, listen: false)
    //         .profileResponse
    //         .user
    //         .firstName;
    // lastNameTextEditingController.text =
    //     Provider.of<ProfileProvider>(context, listen: false)
    //         .profileResponse
    //         .user
    //         .lastName;
    // userNameTextEditingController.text =
    //     Provider.of<ProfileProvider>(context, listen: false)
    //         .profileResponse
    //         .user
    //         .username;
    // emailTextEditingController.text =
    //     Provider.of<ProfileProvider>(context, listen: false)
    //         .profileResponse
    //         .user
    //         .email;
    // }
  }

  void getProfileData() async {
    String model =
        PreferenceUtils.getObject(PreferenceUtils.keyStandardUserProfileObject);
    profileResponse = ProfileResponse.fromJson(json.decode(model));
    print(profileResponse.user.avatar);
    if (profileResponse != null) {
      print("PRefs is not empty");
      profilePic = profileResponse.user.avatar;
      firstNameTextEditingController.text = profileResponse.user.firstName;
      lastNameTextEditingController.text = profileResponse.user.lastName;
      userNameTextEditingController.text = profileResponse.user.username;
      emailTextEditingController.text = profileResponse.user.email;
    } else {
      print("PRefs is empty");
    }
    // setState(() {});
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final ImagePicker _picker = new ImagePicker();
      final pickedFile = await _picker.getImage(
        source: source,
        imageQuality: 40,
      );
      // setState(() {
      _imageFile = pickedFile;
      print("_imageFile-->> ${_imageFile.path.toString()}");
      imageFileBody = File(_imageFile.path);
      // _imageFile.readAsString().then((value) => imageFileBody = value);
      print("imageFileBody->> $imageFileBody");
      // });
      // _imageFile = pickedFile;
      // print("_imageFile-->> ${_imageFile.path.toString()}");
      Provider.of<StandardUserProvider>(context, listen: false)
          .setStandardUserImage(imageFileBody);
      // });

      // // print("Image-->> ${StandardUserProvider().getUserImage()}");
    } catch (e) {
      setState(() {
        pickImageError = e;
      });
    }
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _onImageButtonPressed(ImageSource.gallery,
                            context: context);
                        Navigator.of(context).pop();
                      }),
                  // new ListTile(
                  //   leading: new Icon(Icons.photo_camera),
                  //   title: new Text('Camera'),
                  //   onTap: () {
                  //     _onImageButtonPressed(ImageSource.camera,
                  //         context: context);
                  //     Navigator.of(context).pop();
                  //   },
                  // ),
                ],
              ),
            ),
          );
        });
  }

  void onClickUpdateProfileButton() async {
    var rng = new Random();
    // get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
    // get temporary path from temporary directory.
    String tempPath = tempDir.path;
    // create a new file in temporary path with random file name.
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
    // call http.get method and pass imageUrl into it to get response.
    var response = await http.get(Uri.parse(profilePic));
    // write bodyBytes received in response to file.
    profilePicFile = await file.writeAsBytes(response.bodyBytes);
    print("profile_pic_file path-> ${profilePicFile.path}");
    // print(
    //     "imageFileBody path-> ${imageFileBody.path}");
    if (firstNameTextEditingController.text.isNotEmpty &&
        lastNameTextEditingController.text.isNotEmpty &&
        userNameTextEditingController.text.isNotEmpty &&
        emailTextEditingController.text.isNotEmpty &&
        _imageFile.toString().isNotEmpty) {
      if (EmailValidator.validate(emailTextEditingController.text)) {
        Provider.of<BaseResponseProvider>(context, listen: false).updateProfile(
            context,
            firstNameTextEditingController.text,
            lastNameTextEditingController.text,
            userNameTextEditingController.text,
            emailTextEditingController.text,
            imageFileBody == null ? profilePicFile.path : imageFileBody.path);
      } else {
        GlobalView().showToast(AppToastMessages.valid_email_message);
      }
    } else {
      GlobalView().showToast(AppToastMessages.empty_value_message);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("_imageFile-> $_imageFile");
    return GlobalView().safeAreaView(Container(
        child: GestureDetector(onTap: () {
      FocusScope.of(context).unfocus();
    }, child: Consumer<BaseResponseProvider>(builder: (_, response, child) {
      return !Provider.of<BaseResponseProvider>(context).isLoading
          ? Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  AppImages.background_image1,
                ),
                fit: BoxFit.cover,
                // alignment: Alignment.topCenter,
              )),
              child: Stack(
                children: [
                  // GlobalView().assetImageView(AppImages.backgroundImage1),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Consumer<ProfileProvider>(
                              builder: (_, profile, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                GlobalView().sizedBoxView(47),
                                Container(
                                  alignment: Alignment.topCenter,
                                  child: GlobalView().textViewWithCenterAlign(
                                      AppMessages.edit_profile_title,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.semi_bold_font_weight,
                                      BaseColor.black_color,
                                      18),
                                ),
                                GlobalView().sizedBoxView(20),
                                // Center(
                                //   child: Stack(
                                //     children: [
                                //       Consumer<StandardUserProvider>(
                                //           builder: (_, standardUser, child) {
                                //         return Container(
                                //           height: 108,
                                //           width: 108,
                                //           decoration: BoxDecoration(
                                //             color: BaseColor
                                //                 .terms_policy_text_color,
                                //             shape: BoxShape.circle,
                                //             image: DecorationImage(
                                //                 image: _imageFile == null
                                //                     ? NetworkImage(profilePic)
                                //                     : FileImage(
                                //                         // File(_imageFile.path),
                                //                         standardUser.userImage),
                                //                 fit: BoxFit.cover),
                                //           ),
                                //           // child: _imageFile == null
                                //           //     ? Text("not selected")
                                //           //     : Image.file(
                                //           //         File(_imageFile.path),
                                //           //         width: 100,
                                //           //         height: 100,
                                //           //         fit: BoxFit.fitHeight,
                                //           //       ),
                                //         );
                                //       }),
                                //       Positioned(
                                //           bottom: 0,
                                //           right: 0,
                                //           child: GestureDetector(
                                //             onTap: () {
                                //               print("picker called");
                                //               _showPicker(context);
                                //             },
                                //             child: Container(
                                //               height: 38,
                                //               width: 38,
                                //               child: GlobalView()
                                //                   .assetImageView(
                                //                       AppImages.ic_camera),
                                //             ),
                                //           ))
                                //     ],
                                //   ),
                                // ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.centerLeft,
                                  child: GlobalView().textViewWithCenterAlign(
                                      AppMessages.title_firstname,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.normal_font_weight,
                                      BaseColor.black_color.withOpacity(0.5),
                                      11),
                                ),
                                GlobalView().textFieldView(
                                    AppImages.ic_user,
                                    firstNameTextEditingController,
                                    AppMessages.hint_firstname,
                                    AppTextStyle.start_text_align,
                                    textInputType: TextInputType.name),
                                GlobalView().sizedBoxView(10),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.centerLeft,
                                  child: GlobalView().textViewWithCenterAlign(
                                      AppMessages.title_lastname,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.normal_font_weight,
                                      BaseColor.black_color.withOpacity(0.5),
                                      11),
                                ),
                                GlobalView().textFieldView(
                                    AppImages.ic_user,
                                    lastNameTextEditingController,
                                    AppMessages.hint_lastname,
                                    AppTextStyle.start_text_align,
                                    textInputType: TextInputType.name),
                                GlobalView().sizedBoxView(10),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.centerLeft,
                                  child: GlobalView().textViewWithCenterAlign(
                                      AppMessages.title_username,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.normal_font_weight,
                                      BaseColor.black_color.withOpacity(0.5),
                                      11),
                                ),
                                GlobalView().textFieldView(
                                    AppImages.ic_user,
                                    userNameTextEditingController,
                                    AppMessages.hint_username_reg,
                                    AppTextStyle.start_text_align,
                                    textInputType: TextInputType.name),
                                GlobalView().sizedBoxView(10),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.centerLeft,
                                  child: GlobalView().textViewWithCenterAlign(
                                      AppMessages.title_email,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.normal_font_weight,
                                      BaseColor.black_color.withOpacity(0.5),
                                      11),
                                ),
                                GlobalView().textFieldView(
                                    AppImages.ic_email,
                                    emailTextEditingController,
                                    AppMessages.hint_email,
                                    AppTextStyle.start_text_align,
                                    textInputType: TextInputType.emailAddress),
                                GlobalView().sizedBoxView(60),
                                // Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, bottom: 50, top: 50),
                                  child: GestureDetector(
                                    onTap: () {
                                      onClickUpdateProfileButton();
                                    },
                                    child: GlobalView().buttonFilled(context,
                                        AppMessages.save_changes_btn_text),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 57,
                    left: 21,
                    child: Container(
                      // color: Colors.red,
                      height: 25,
                      width: 25,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child:
                              GlobalView().assetImageView(AppImages.ic_back)),
                    ),
                  ),
                  Consumer<BaseResponseProvider>(builder: (_, user, child) {
                    return Visibility(
                      visible:
                          Provider.of<BaseResponseProvider>(context).isLoading,
                      // visible: true,
                      child: Positioned(
                        child: Container(
                          // color: BaseColor.loader_bg_color,
                          child: GlobalView().loaderView(),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            )
          : Container(
              // color: BaseColor.loader_bg_color,
              child: GlobalView().loaderView(),
            );
    }))));
  }
}

// GlobalView().sizedBoxView(10),
// Container(
//   padding: EdgeInsets.symmetric(vertical: 5),
//   alignment: Alignment.centerLeft,
//   child: GlobalView().textViewWithCenterAlign(
//       AppMessages.titleDateofBirth,
//       AppTextStyle.interFontFamily,
//       AppTextStyle.normalFontWeight,
//       BaseColor.blackColor.withOpacity(0.5),
//       11),
// ),
// // GlobalView().textFieldView(
// //     AppImages.ic_calendar,
// //     dateofBirthTextEditingController,
// //     AppMessages.hintDateofBirth,
// //     AppTextStyle.startTextAlign),
// Material(
//   shadowColor: BaseColor.shadowColor,
//   elevation: 4,
//   borderRadius: BorderRadius.circular(25),
//   child: GestureDetector(
//     onTap: () {
//       print("clicked");
//       DatePicker.showDatePicker(context,
//           showTitleActions: true,
//           minTime: DateTime(1950, 1, 1),
//           maxTime: DateTime.now(), onChanged: (date) {
//         print('change $date');
//       }, onConfirm: (date) {
//         print('confirm $date');
//         String formattedDate =
//             DateFormat('yyyy-MM-dd').format(date);
//         // String formattedDate = DateFormat('hh:mm:a').format(time);
//         dateofBirthTextEditingController.text =
//             formattedDate;
//       },
//           currentTime: DateTime.now(),
//           locale: LocaleType.en);
//     },
//     child: TextField(
//       enabled: false,
//       controller: dateofBirthTextEditingController,
//       cursorColor: BaseColor.borderTxtFieldColor,
//       style: TextStyle(
//         color: BaseColor.hintColor,
//         fontFamily: AppTextStyle.interFontFamily,
//         fontSize: 14,
//       ),
//       textAlign: AppTextStyle.startTextAlign,
//       decoration: InputDecoration(
//         isDense: true,
//         focusColor: BaseColor.pureWhiteColor,
//         contentPadding:
//             EdgeInsets.only(left: 60, right: -30),
//         prefixIcon: Padding(
//           padding: EdgeInsets.only(right: 15),
//           child: Container(
//               height: 50,
//               width: 58,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage(AppImages.ic_bg)),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(
//                     top: 13,
//                     bottom: 13,
//                     left: 13,
//                     right: 20),
//                 child: Image.asset(
//                   AppImages.ic_calendar,
//                   height: 24,
//                   width: 24,
//                 ),
//               )),
//         ),
//         //  prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(25),
//           borderSide: BorderSide(
//               color: BaseColor.borderTxtFieldColor),
//         ),
//         disabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide(
//                 color: BaseColor.borderTxtFieldColor)),
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide(
//                 color: BaseColor.borderTxtFieldColor)),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide(
//                 color: BaseColor.borderTxtFieldColor)),
//         hintText: AppMessages.hintDateofBirth,
//         hintStyle: TextStyle(
//           color: BaseColor.hintColor.withOpacity(0.6),
//           fontFamily: AppTextStyle.interFontFamily,
//           fontSize: 14,
//         ),
//       ),
//     ),
//   ),
// ),
