// ignore_for_file: unused_element

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/api_urls.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/data/models/profile_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/base_response_provider.dart';
import 'package:trendoapp/providers/standard_user_provider.dart';
import 'package:trendoapp/utils/preference_utils.dart';
import 'package:http/http.dart' as http;
import 'package:trendoapp/utils/url_launcher.dart';

// ignore: must_be_immutable
class SimpleUserRegistrationPage extends StatefulWidget {
  bool isEditable;
  SimpleUserRegistrationPage(this.isEditable);

  @override
  _SimpleUserRegistrationPageState createState() =>
      _SimpleUserRegistrationPageState();
}

class _SimpleUserRegistrationPageState
    extends State<SimpleUserRegistrationPage> {
  TextEditingController firstNameTextEditingController =
      new TextEditingController();

  TextEditingController lastNameTextEditingController =
      new TextEditingController();

  TextEditingController userNameTextEditingController =
      new TextEditingController();

  TextEditingController emailTextEditingController =
      new TextEditingController();

  TextEditingController dateofBirthTextEditingController =
      new TextEditingController();

  bool checkValue = true;

  File image;

  PickedFile imageFile;

  dynamic pickImageError;

  File imageFileBody;
  File profilePicFile;
  ProfileResponse profileResponse;
  String profilePic = "";
  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final ImagePicker _picker = new ImagePicker();
      final pickedFile = await _picker.getImage(
        source: source,
        imageQuality: 40,
      );
      // setState(() {
      imageFile = pickedFile;
      print("_imageFile-->> ${imageFile.path.toString()}");
      imageFileBody = File(imageFile.path);
      // _imageFile.readAsString().then((value) => imageFileBody = value);
      print("imageFileBody->> $imageFileBody");
      // });
      // _imageFile = pickedFile;
      // print("_imageFile-->> ${_imageFile.path.toString()}");
      Provider.of<StandardUserProvider>(context, listen: false)
          .setStandardUserImage(imageFileBody);
      // // print("Image-->> ${StandardUserProvider().getUserImage()}");
    } catch (e) {
      // setState(() {
      pickImageError = e;
      // });
    }
  }

  void _showPicker(context) {
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

  void onClickRegisterBtn(BuildContext context) {
    // print(
    //     "isAgeCheckBoxValue -> ${Provider.of<StandardUserProvider>(context, listen: false).isAgeCheckBoxValue}");
    // print(
    //     "isPrivacyValue -> ${Provider.of<StandardUserProvider>(context, listen: false).isPrivacyCheckBoxValue}");

    if (Provider.of<StandardUserProvider>(context, listen: false)
            .isAgeCheckBoxValue &&
        Provider.of<StandardUserProvider>(context, listen: false)
            .isPrivacyCheckBoxValue) {
      if (
          // firstNameTextEditingController.text.isNotEmpty &&
          //   lastNameTextEditingController.text.isNotEmpty &&
          userNameTextEditingController.text.isNotEmpty &&
              emailTextEditingController.text.isNotEmpty) {
        if (EmailValidator.validate(emailTextEditingController.text) &&
            // Provider.of<StandardUserProvider>(context, listen: false)
            //         .userImage !=
            //     null &&
            Provider.of<StandardUserProvider>(context, listen: false)
                .isAgeCheckBoxValue &&
            Provider.of<StandardUserProvider>(context, listen: false)
                .isPrivacyCheckBoxValue) {
          Provider.of<StandardUserProvider>(context, listen: false)
              .standardUserRegister(
            context,
            firstNameTextEditingController.text.isEmpty
                ? ""
                : firstNameTextEditingController.text,
            lastNameTextEditingController.text.isEmpty
                ? ""
                : lastNameTextEditingController.text,
            userNameTextEditingController.text,
            emailTextEditingController.text,
            // dateofBirthTextEditingController.text,
            // imageFileBody.path,
            Provider.of<StandardUserProvider>(context, listen: false)
                        .userImage ==
                    null
                ? ""
                : Provider.of<StandardUserProvider>(context, listen: false)
                    .userImage
                    .path,
            "1",
            Provider.of<StandardUserProvider>(context, listen: false)
                        .isAgeCheckBoxValue ==
                    true
                ? 1
                : 0,
            Provider.of<StandardUserProvider>(context, listen: false)
                        .isPrivacyCheckBoxValue ==
                    true
                ? 1
                : 0,
          );
        }
        // else if (Provider.of<StandardUserProvider>(context, listen: false)
        //         .userImage ==
        //     null) {
        //   GlobalView().showToast(AppToastMessages.image_selection);
        // }
        else if (!EmailValidator.validate(emailTextEditingController.text)) {
          GlobalView().showToast(AppToastMessages.valid_email_message);
        } else {
          if (!Provider.of<StandardUserProvider>(context, listen: false)
                  .isAgeCheckBoxValue &&
              !Provider.of<StandardUserProvider>(context, listen: false)
                  .isPrivacyCheckBoxValue) {
            GlobalView().showToast(AppToastMessages.select_checkbox_message);
          } else if (!Provider.of<StandardUserProvider>(context, listen: false)
              .isAgeCheckBoxValue) {
            GlobalView().showToast(AppToastMessages.select_age_checkboxMessage);
          } else if (!Provider.of<StandardUserProvider>(context, listen: false)
              .isPrivacyCheckBoxValue) {
            GlobalView().showToast(
                AppToastMessages.select_terms_policy_checkbox_message);
          }

          // GlobalView().showToast(AppToastMessages
          //     .selectCheckBoxMessage);
        }
      } else {
        GlobalView().showToast(AppToastMessages.empty_value_message);
      }
    }
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
    if (userNameTextEditingController.text.isNotEmpty &&
        emailTextEditingController.text.isNotEmpty) {
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
  void initState() {
    super.initState();
    if (widget.isEditable) {
      getProfileData();
    }
  }

  @override
  Widget build(BuildContext context) {
    // firstNameTextEditingController.text = "kaushita";
    // lastNameTextEditingController.text = "polaris";
    // userNameTextEditingController.text = "kaushitapolaris";
    // emailTextEditingController.text = "kaushitapolaris@gmail.com";
    print("isEditable-=-> ${widget.isEditable}");
    return ListenableProvider<StandardUserProvider>(
        create: (_) => StandardUserProvider(),
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
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
                    padding: const EdgeInsets.symmetric(horizontal:16),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: DeviceSize().deviceWidth(context) * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GlobalView().sizedBoxView(47),
                              Container(
                                alignment: Alignment.topCenter,
                                child: GlobalView().textViewWithCenterAlign(
                                    widget.isEditable
                                        ? AppMessages.edit_profile_title
                                        : AppMessages.register_text,
                                    AppTextStyle.inter_font_family,
                                    AppTextStyle.semi_bold_font_weight,
                                    BaseColor.black_color,
                                    // 18
                                    DeviceSize().deviceHeight(context) * 0.024),
                              ),
                              GlobalView().sizedBoxView(
                                  DeviceSize().deviceHeight(context) * 0.02),
                              // widget.isEditable
                              //     ? 
                                  Image.asset(
                                      AppImages.trendsee_logo_transparent,
                                      height:
                                          DeviceSize().deviceWidth(context) / 3,
                                      width:
                                          DeviceSize().deviceWidth(context) / 3),
                                  // : 
                                  // Center(
                                  //     child: Stack(
                                  //       children: [
                                  //         Consumer<StandardUserProvider>(
                                  //             builder:
                                  //                 (_, standardUser, child) {
                                  //           return Container(
                                  //             height: DeviceSize().deviceWidth(
                                  //                         context) /
                                  //                     3 -
                                  //                 20,
                                  //             width: DeviceSize().deviceWidth(
                                  //                         context) /
                                  //                     3 -
                                  //                 20,
                                  //             decoration: BoxDecoration(
                                  //               color: BaseColor
                                  //                   .terms_policy_text_color,
                                  //               shape: BoxShape.circle,
                                  //               image: DecorationImage(
                                  //                   image: widget.isEditable
                                  //                       ? imageFile == null
                                  //                           ? NetworkImage(
                                  //                               profilePic)
                                  //                           : FileImage(
                                  //                               // File(_imageFile.path),
                                  //                               standardUser
                                  //                                   .userImage)
                                  //                       : standardUser
                                  //                                   .userImage ==
                                  //                               null
                                  //                           ? AssetImage(AppImages
                                  //                               .default_profile_Pic)
                                  //                           : FileImage(
                                  //                               // File(imageFileBody.path),
                                  //                               // Provider.of<StandardUserProvider>(
                                  //                               //         context,
                                  //                               //         listen: false)
                                  //                               //     .userImage
                                  //                               standardUser
                                  //                                   .userImage),
                                  //                   fit: BoxFit.cover),
                                  //             ),
                                  //             // child: _imageFile == null
                                  //             //     ? Text("not selected")
                                  //             //     : Image.file(
                                  //             //         File(_imageFile.path),
                                  //             //         width: 100,
                                  //             //         height: 100,
                                  //             //         fit: BoxFit.fitHeight,
                                  //             //       ),
                                  //           );
                                  //         }),
                                  //         Positioned(
                                  //             bottom: 0,
                                  //             right: 0,
                                  //             child: GestureDetector(
                                  //               onTap: () {
                                  //                 print("picker called");
                                  //                 _showPicker(context);
                                  //               },
                                  //               child: Container(
                                  //                 height: DeviceSize()
                                  //                         .deviceHeight(
                                  //                             context) *
                                  //                     0.048,
                                  //                 width: DeviceSize()
                                  //                         .deviceHeight(
                                  //                             context) *
                                  //                     0.048,
                                  //                 child: GlobalView()
                                  //                     .assetImageView(
                                  //                         AppImages.ic_camera),
                                  //               ),
                                  //             ))
                                  //       ],
                                  //     ),
                                  //   ),
                              
                              fNameLnameView(),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                alignment: Alignment.centerLeft,
                                child: GlobalView().textViewWithCenterAlign(
                                    AppMessages.title_username,
                                    AppTextStyle.inter_font_family,
                                    AppTextStyle.normal_font_weight,
                                    BaseColor.black_color.withOpacity(0.5),
                                    // 11
                                    DeviceSize().deviceHeight(context) * 0.014),
                              ),
                              GlobalView().textFieldView(
                                  AppImages.ic_user,
                                  userNameTextEditingController,
                                  AppMessages.hint_username_reg,
                                  AppTextStyle.start_text_align),
                              GlobalView().sizedBoxView(
                                  DeviceSize().deviceHeight(context) * 0.01),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                alignment: Alignment.centerLeft,
                                child: GlobalView().textViewWithCenterAlign(
                                    AppMessages.title_email,
                                    AppTextStyle.inter_font_family,
                                    AppTextStyle.normal_font_weight,
                                    BaseColor.black_color.withOpacity(0.5),
                                    // 11
                                    DeviceSize().deviceHeight(context) * 0.014),
                              ),
                              GlobalView().textFieldView(
                                  AppImages.ic_email,
                                  emailTextEditingController,
                                  AppMessages.hint_email,
                                  AppTextStyle.start_text_align),
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
                              //           maxTime: DateTime.now(),
                              //           onChanged: (date) {
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
                              //       controller:
                              //           dateofBirthTextEditingController,
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
                              //                     image: AssetImage(
                              //                         AppImages.ic_bg)),
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
                              //               color:
                              //                   BaseColor.borderTxtFieldColor),
                              //         ),
                              //         disabledBorder: OutlineInputBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(25),
                              //             borderSide: BorderSide(
                              //                 color: BaseColor
                              //                     .borderTxtFieldColor)),
                              //         border: OutlineInputBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(25),
                              //             borderSide: BorderSide(
                              //                 color: BaseColor
                              //                     .borderTxtFieldColor)),
                              //         focusedBorder: OutlineInputBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(25),
                              //             borderSide: BorderSide(
                              //                 color: BaseColor
                              //                     .borderTxtFieldColor)),
                              //         hintText: AppMessages.hintDateofBirth,
                              //         hintStyle: TextStyle(
                              //           color: BaseColor.hintColor
                              //               .withOpacity(0.6),
                              //           fontFamily:
                              //               AppTextStyle.interFontFamily,
                              //           fontSize: 14,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              GlobalView().sizedBoxView(
                                  DeviceSize().deviceHeight(context) * 0.05),
                              Visibility(
                                visible: !widget.isEditable,
                                child: Column(
                                  children: [
                                    ageConfirmationCheckBoxView(),
                                    GlobalView().sizedBoxView(
                                        DeviceSize().deviceHeight(context) *
                                            0.012),
                                    termsPolicyCheckBoxView(),
                                  ],
                                ),
                              ),

                              // Spacer(),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 5,
                                    right: 5,
                                    bottom: DeviceSize().deviceHeight(context) *
                                        0.05,
                                    top: DeviceSize().deviceHeight(context) *
                                        0.05),
                                child: widget.isEditable
                                    ? GestureDetector(
                                        onTap: () {
                                          onClickUpdateProfileButton();
                                        },
                                        child: GlobalView().buttonFilled(
                                            context,
                                            AppMessages.save_changes_btn_text),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          onClickRegisterBtn(context);
                                        },
                                        child: (Provider.of<StandardUserProvider>(
                                                        context)
                                                    .isAgeCheckBoxValue &&
                                                Provider.of<StandardUserProvider>(
                                                        context)
                                                    .isPrivacyCheckBoxValue)
                                            ? GlobalView().buttonFilled(context,
                                                AppMessages.create_account_text)
                                            : GlobalView().buttonFilledDisabled(
                                                context,
                                                AppMessages
                                                    .create_account_text),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 45,
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
                  Consumer2<StandardUserProvider, BaseResponseProvider>(
                      builder: (_, user, baseProvider, child) {
                    return Visibility(
                      visible: Provider.of<StandardUserProvider>(context)
                              .isLoading ||
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
                  // Positioned(
                  //   top: 57,
                  //   left: 0,
                  //   right: 0,
                  //   child: Container(
                  //     alignment: Alignment.topCenter,
                  //     child: GlobalView().textView(
                  //         AppMessages.registerText,
                  //         AppTextStyle.poppinsFontFamily,
                  //         AppTextStyle.semiBoldFontWeight,
                  //         BaseColor.blackColor,
                  //         18),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        });
  }

  Widget fNameLnameView() {
    return Visibility(
      visible: widget.isEditable ? false : true,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.centerLeft,
            child: GlobalView().textViewWithCenterAlign(
                AppMessages.title_firstname,
                AppTextStyle.inter_font_family,
                AppTextStyle.normal_font_weight,
                BaseColor.black_color.withOpacity(0.5),
                // 11
                DeviceSize().deviceHeight(context) * 0.014),
          ),
          GlobalView().textFieldView(
              AppImages.ic_user,
              firstNameTextEditingController,
              AppMessages.hint_firstname,
              AppTextStyle.start_text_align),
          GlobalView().sizedBoxView(DeviceSize().deviceHeight(context) * 0.01),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.centerLeft,
            child: GlobalView().textViewWithCenterAlign(
                AppMessages.title_lastname,
                AppTextStyle.inter_font_family,
                AppTextStyle.normal_font_weight,
                BaseColor.black_color.withOpacity(0.5),
                // 11
                DeviceSize().deviceHeight(context) * 0.014),
          ),
          GlobalView().textFieldView(
              AppImages.ic_user,
              lastNameTextEditingController,
              AppMessages.hint_lastname,
              AppTextStyle.start_text_align),
          GlobalView().sizedBoxView(DeviceSize().deviceHeight(context) * 0.01),
        ],
      ),
    );
  }

  Widget ageConfirmationCheckBoxView() =>
      Consumer<StandardUserProvider>(builder: (context, user, child) {
        return Container(
          alignment: Alignment.topLeft,
          // color: Colors.yellow,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 25,
                padding: EdgeInsets.zero,
                // color: Colors.green,
                child: Theme(
                  data: ThemeData(
                      unselectedWidgetColor: BaseColor.btn_gradient_end_color1,
                      backgroundColor: BaseColor.btn_gradient_end_color1),
                  child: Checkbox(
                      value: Provider.of<StandardUserProvider>(context,
                              listen: false)
                          .isAgeCheckBoxValue,
                      checkColor: BaseColor.pure_white_color,
                      activeColor: BaseColor.btn_gradient_end_color1,
                      onChanged: (bool value) {
                        Provider.of<StandardUserProvider>(context,
                                listen: false)
                            .changeAgeCheckBoxValue();
                        // setState(() {
                        //   checkValue = value;
                        // });
                      }),
                ),
              ),
              Expanded(
                  child: GlobalView().textViewWithStartAlign(
                      AppMessages.age_confirmation_text,
                      AppTextStyle.inter_font_family,
                      AppTextStyle.medium_font_weight,
                      BaseColor.forgot_pass_txt_color,
                      16))
            ],
          ),
        );
      });

  Widget termsPolicyCheckBoxView() =>
      Consumer<StandardUserProvider>(builder: (context, user, child) {
        return Container(
          alignment: Alignment.topLeft,
          // color: Colors.yellow,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 25,
                padding: EdgeInsets.zero,
                // color: Colors.green,
                child: Theme(
                  data: ThemeData(
                      unselectedWidgetColor: BaseColor.btn_gradient_end_color1,
                      backgroundColor: BaseColor.btn_gradient_end_color1),
                  child: Checkbox(
                      value: Provider.of<StandardUserProvider>(context,
                              listen: false)
                          .isPrivacyCheckBoxValue,
                      checkColor: BaseColor.pure_white_color,
                      activeColor: BaseColor.btn_gradient_end_color1,
                      onChanged: (bool value) {
                        Provider.of<StandardUserProvider>(context,
                                listen: false)
                            .changePrivacyCheckBoxValue();
                      }),
                ),
              ),
              Expanded(
                  child: Text.rich(TextSpan(
                      text: 'I confirm and accept ',
                      style: TextStyle(
                          fontSize: 14,
                          color: BaseColor.terms_policy_text_color,
                          fontFamily: AppTextStyle.inter_font_family),
                      children: <TextSpan>[
                    TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          fontSize: 16,
                          color: BaseColor.btn_gradient_end_color1,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // code to open / launch terms of service link here
                             UrlLauncher()
                                      .launchUrl(ApiUrls.privacy_policy_url);
                          }),
                    TextSpan(
                        text: ' and ',
                        style: TextStyle(
                          fontSize: 14,
                          color: BaseColor.terms_policy_text_color,
                          fontFamily: AppTextStyle.inter_font_family,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Terms of Service.',
                              style: TextStyle(
                                fontSize: 16,
                                color: BaseColor.btn_gradient_end_color1,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // code to open / launch privacy policy link here
                                   UrlLauncher()
                                      .launchUrl(ApiUrls.terms_service_url);
                                })
                        ])
                  ])))
            ],
          ),
        );
      });
}
