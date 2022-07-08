import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/api_urls.dart';
import 'package:trendoapp/data/models/business_user_profile_response.dart';
import 'package:trendoapp/data/models/business_user_response.dart';
import 'package:trendoapp/data/models/category_response.dart';
import 'package:trendoapp/data/models/metropolitan_areas_list_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/multiline_textfield.dart';
import 'package:trendoapp/presentation/screens/businessUser/category_selection_screen.dart';
import 'package:trendoapp/presentation/screens/businessUser/homeTabs/add_more_locations_screen.dart';
import 'package:trendoapp/providers/business_user_provider.dart';
import 'package:trendoapp/providers/categories_list_provider.dart';
import 'package:trendoapp/router/app_router.dart';
import 'package:trendoapp/utils/category_utils.dart';
import 'package:trendoapp/utils/dialog_utils.dart';
import 'package:trendoapp/utils/url_launcher.dart';
import 'package:trendoapp/utils/validation_utils.dart';

import '../../../constants/app_images.dart';
import '../../../constants/app_messages.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_text_style.dart';
import '../../../constants/app_toast_messages.dart';
import '../../../constants/base_color.dart';
import '../../../constants/device_size.dart';
import '../../../utils/preference_utils.dart';

// ignore: must_be_immutable
class BusinessUserRegistrationPage extends StatefulWidget {
  bool isEditable;
  BusinessUserRegistrationPage(this.isEditable);
  @override
  _BusinessUserRegistrationPageState createState() =>
      _BusinessUserRegistrationPageState();
}

class _BusinessUserRegistrationPageState
    extends State<BusinessUserRegistrationPage> {
  TextEditingController businessNameTextEditingController =
      new TextEditingController();

  TextEditingController businessWebsiteTextEditingController =
      new TextEditingController();

  TextEditingController businessPhoneNumberTextEditingController =
      new TextEditingController();

  TextEditingController metropolitanAreaTextEditingController =
      new TextEditingController();
  AutoCompleteTextField searchMetropolitanAreaTextField;
  AutoCompleteTextField searchCityTextField;

  TextEditingController businessAddressTextEditingController =
      new TextEditingController();

  TextEditingController businessGPSCoordinatesTextEditingController =
      new TextEditingController();

  TextEditingController ownerFirstNameTextEditingController =
      new TextEditingController();

  TextEditingController lastNameTextEditingController =
      new TextEditingController();

  TextEditingController userNameTextEditingController =
      new TextEditingController();

  TextEditingController emailTextEditingController =
      new TextEditingController();

  TextEditingController dateofBirthTextEditingController =
      new TextEditingController();

  TextEditingController otherPhoneTextEditingController =
      new TextEditingController();

  TextEditingController businessCategoryTextEditingController =
      new TextEditingController();

  TextEditingController cityTextEditingController = new TextEditingController();

  bool checkValue = true;

  PickedFile _imageFile;

  dynamic pickImageError;

  List<PickedFile> listOfFileImages = [];

  bool isVideo = false;
  List<String> listMediaImages = [];

  double _latitude;
  double _longitude;
  // String imageUrl = "";
  String category;
  String matropolitanArea;
  String city;
  BusinessUserResponse businessUserResponse = new BusinessUserResponse();
  BusinessUserProfileResponse businessUserProfileResponse;
  GlobalKey<AutoCompleteTextFieldState<MetropolitanAreaInfo>> keyArea =
      new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<MetropolitanCityInfo>> keyCity =
      new GlobalKey();
  File imageFileBody;
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<BusinessUserProvider>(context, listen: false);
    provider.listImageUrl = [];
    provider.selectedBusiness = AppMessages.physical_text;

    var catProvider =
        Provider.of<CategoriesListProvider>(context, listen: false);
    // for (var i = 0; i < catProvider.listCategories.length; i++) {
    //   catProvider.listCategories[i].isChecked = false;
    // }
    Future.delayed(
      Duration.zero,
      () async {
        if (widget.isEditable) {
          setProfileData();
          Provider.of<CategoriesListProvider>(context, listen: false)
              .addDataToList(
                  Provider.of<BusinessUserProvider>(context, listen: false)
                      .businessUserProfileResponse
                      .user
                      .categories);
          var catProvider =
              Provider.of<CategoriesListProvider>(context, listen: false);
          businessCategoryTextEditingController.text = CategoryUtils()
              .getCategoryName(catProvider.listSelectedCategories);
        } else {
          if (
              // catProvider.listFilteredCategoryId != null &&
              catProvider.listCategories.length > 0) {
            // catProvider.selectedCategoryData = catProvider.listCategories[0];
            catProvider
                .selectedBusinessCategoryItem(catProvider.listCategories[0]);
          }
          print(
              "catProvider.selectedCategoryData ${catProvider.selectedCategoryResponse.name}");
          provider.setCenterLocation(null, null);
          businessGPSCoordinatesTextEditingController.text = "";
        }
      },
    );
    // emailTextEditingController.text = "uwtest303@gmail.com";
  }

  @override
  Widget build(BuildContext context) {
    // print("BUILD CALLED");
    setRegisterData();
    print("isEditable-=-=-> ${widget.isEditable}");
    // if (widget.isEditable) {
    //   setProfileData();
    // } else {
    //   // setRegisterData();
    // }
    // return ListenableProvider<BusinessUserProvider>(
    //     create: (_) => BusinessUserProvider(),
    //     builder: (context, child) {
    return WillPopScope(onWillPop: () async {
      Provider.of<BusinessUserProvider>(context, listen: false)
          .isVisibleMetropolitanCity = false;
      return true;
    }, child: Consumer<BusinessUserProvider>(builder: (_, provider, child) {
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
            ),
          ),
          child: Stack(
            children: [
              // GlobalView().assetImageView(AppImages.backgroundImage1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: DeviceSize().deviceWidth(context) * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GlobalView().sizedBoxView(47),
                          Container(
                            alignment: Alignment.topCenter,
                            child: GlobalView().textViewWithCenterAlign(
                                widget.isEditable
                                    ? AppMessages.edit_business_profile_title
                                    : AppMessages.business_user_register_text,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.semi_bold_font_weight,
                                BaseColor.black_color,
                                18),
                          ),
                          GlobalView().sizedBoxView(30),
                          GlobalView().textViewWithStartAlign(
                              AppMessages.public_info_msg,
                              AppTextStyle.inter_font_family,
                              AppTextStyle.medium_font_weight,
                              BaseColor.black_color,
                              12),
                          GlobalView().sizedBoxView(10),
                          Visibility(
                            visible: widget.isEditable,
                            child: Center(
                              child: Stack(
                                children: [
                                  Container(
                                    height:
                                        DeviceSize().deviceWidth(context) / 3 -
                                            20,
                                    width:
                                        DeviceSize().deviceWidth(context) / 3 -
                                            20,
                                    decoration: BoxDecoration(
                                      color: BaseColor.terms_policy_text_color,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: widget.isEditable
                                              ? _imageFile == null
                                                  ? businessUserResponse
                                                                  .avatar !=
                                                              null &&
                                                          businessUserResponse
                                                                  .avatar
                                                                  .length >
                                                              0
                                                      ? NetworkImage(
                                                          businessUserResponse
                                                              .avatar)
                                                      : AssetImage(AppImages
                                                          .default_profile_Pic)
                                                  : FileImage(
                                                      // File(_imageFile.path),
                                                      provider.userImage)
                                              : provider.userImage == null
                                                  ? AssetImage(AppImages
                                                      .default_profile_Pic)
                                                  : FileImage(
                                                      // File(imageFileBody.path),
                                                      // Provider.of<StandardUserProvider>(
                                                      //         context,
                                                      //         listen: false)
                                                      //     .userImage
                                                      provider.userImage),
                                          // NetworkImage(
                                          //     businessUserResponse
                                          //         .avatar),
                                          fit: BoxFit.cover),
                                    ),
                                    // child: _imageFile == null
                                    //     ? Text("not selected")
                                    //     : Image.file(
                                    //         File(_imageFile.path),
                                    //         width: 100,
                                    //         height: 100,
                                    //         fit: BoxFit.fitHeight,
                                    //       ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (widget.isEditable &&
                                            provider.businessUserProfileResponse
                                                    .user.currentPlan
                                                    .toLowerCase() ==
                                                AppMessages.freeText) {
                                          DialogUtils.displayDialogCallBack(
                                                  context,
                                                  "",
                                                  "",
                                                  AppMessages
                                                      .selectDiffPlanText,
                                                  "",
                                                  AppMessages.ok_text,
                                                  AppMessages.viewPlansHereText)
                                              .then((value) {
                                            if (value ==
                                                AppMessages.viewPlansHereText) {
                                              UrlLauncher().launchUrl(
                                                  ApiUrls.sign_up_website_url);
                                            }
                                          });
                                        } else {
                                          print("picker called");
                                          _showPicker(context,
                                              AppMessages.profile_text);
                                        }
                                      },
                                      child: Container(
                                        height:
                                            DeviceSize().deviceHeight(context) *
                                                0.048,
                                        width:
                                            DeviceSize().deviceHeight(context) *
                                                0.048,
                                        child: GlobalView().assetImageView(
                                            AppImages.ic_camera),
                                      ),
                                    ),
                                  ),
                                  GlobalView().sizedBoxView(10),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            alignment: Alignment.centerLeft,
                            child: GlobalView().textViewWithCenterAlign(
                                AppMessages.title_business_name,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.normal_font_weight,
                                BaseColor.black_color.withOpacity(0.5),
                                11),
                          ),
                          GlobalView().textFieldView(
                              AppImages.ic_business,
                              businessNameTextEditingController,
                              AppMessages.hint_business_name,
                              AppTextStyle.start_text_align,
                              textInputType: TextInputType.name),
                          GlobalView().sizedBoxView(10),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            alignment: Alignment.centerLeft,
                            child: GlobalView().textViewWithCenterAlign(
                                AppMessages.title_business_website,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.normal_font_weight,
                                BaseColor.black_color.withOpacity(0.5),
                                11),
                          ),
                          GlobalView().textFieldView(
                              AppImages.ic_website,
                              businessWebsiteTextEditingController,
                              AppMessages.hint_business_website,
                              AppTextStyle.start_text_align,
                              textInputType: TextInputType.url,
                              isReadOnly: widget.isEditable &&
                                  provider.businessUserProfileResponse.user
                                          .currentPlan
                                          .toLowerCase() ==
                                      AppMessages.freeText, onTap: () {
                            if (widget.isEditable &&
                                provider.businessUserProfileResponse.user
                                        .currentPlan
                                        .toLowerCase() ==
                                    AppMessages.freeText) {
                              DialogUtils.displayDialogCallBack(
                                      context,
                                      "",
                                      "",
                                      AppMessages.selectDiffPlanText,
                                      "",
                                      AppMessages.ok_text,
                                      AppMessages.viewPlansHereText)
                                  .then((value) {
                                if (value == AppMessages.viewPlansHereText) {
                                  UrlLauncher()
                                      .launchUrl(ApiUrls.sign_up_website_url);
                                }
                              });
                            }
                          }),
                          GlobalView().sizedBoxView(10),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            alignment: Alignment.centerLeft,
                            child: GlobalView().textViewWithCenterAlign(
                                AppMessages.title_select_category,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.normal_font_weight,
                                BaseColor.black_color.withOpacity(0.5),
                                11),
                          ),
                          // if (widget.isEditable)
                          // GlobalView().textFieldViewReadOnly(
                          //     AppImages.ic_category,
                          //     businessCategoryTextEditingController,
                          //     AppMessages.hint_category_name,
                          //     AppTextStyle.start_text_align),
                          // else
                          MultilineCategoryTextfield(
                            controller: businessCategoryTextEditingController,
                            onClick: () {
                              onClickCategoryView();
                            },
                          ),
                          // categoryView(),
                          GlobalView().sizedBoxView(10),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            alignment: Alignment.centerLeft,
                            child: GlobalView().textViewWithCenterAlign(
                                AppMessages.title_business_phone_number,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.normal_font_weight,
                                BaseColor.black_color.withOpacity(0.5),
                                11),
                          ),
                          GlobalView().textFieldViewPhone(
                              AppImages.ic_phone,
                              businessPhoneNumberTextEditingController,
                              AppMessages.hint_business_phone_number,
                              AppTextStyle.start_text_align),
                          GlobalView().sizedBoxView(20),
                          AbsorbPointer(
                            absorbing: widget.isEditable ? true : false,
                            child: onlineBusinessCheckBoxView(),
                          ),
                          Visibility(
                            visible: Provider.of<BusinessUserProvider>(context)
                                        .selectedBusiness ==
                                    AppMessages.physical_text
                                ? true
                                : false,
                            child: Column(
                              children: [
                                GlobalView().sizedBoxView(10),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.centerLeft,
                                  child: GlobalView().textViewWithCenterAlign(
                                      AppMessages.title_metropolitan_area,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.normal_font_weight,
                                      BaseColor.black_color.withOpacity(0.5),
                                      11),
                                ),
                                // widget.isEditable
                                //     ? GlobalView().textFieldViewReadOnly(
                                //         AppImages.ic_metro,
                                //         metropolitanAreaTextEditingController,
                                //         AppMessages.hint_metropolitan_area,
                                //         AppTextStyle.start_text_align)
                                //     : metropolitanAreaView(),
                                // Visibility(
                                //   visible:
                                //       Provider.of<BusinessUserProvider>(context)
                                //           .isVisibleMetropolitanCity,
                                //   child: Column(
                                //     children: [
                                //       GlobalView().sizedBoxView(10),
                                //       GlobalView().textFieldView(
                                //           AppImages.ic_metro,
                                //           metropolitanAreaTextEditingController,
                                //           AppMessages.hint_metropolitan_area,
                                //           AppTextStyle.start_text_align),
                                //     ],
                                //   ),
                                // ),
                                // Consumer<BusinessUserProvider>(
                                //     builder: (ctx, businessProvider, child) {
                                //   return metropolitanAreaView(businessProvider);
                                // }),
                                metropolitanAutoCompleteTextFieldView(),

                                GlobalView().sizedBoxView(10),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.centerLeft,
                                  child: GlobalView().textViewWithCenterAlign(
                                      AppMessages.title_city,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.normal_font_weight,
                                      BaseColor.black_color.withOpacity(0.5),
                                      11),
                                ),
                                GlobalView().textFieldView(
                                    AppImages.ic_location,
                                    cityTextEditingController,
                                    AppMessages.hint_city_name,
                                    AppTextStyle.start_text_align),
                                // Visibility(
                                //   visible:
                                //       Provider.of<BusinessUserProvider>(context)
                                //           .isVisibleMetropolitanCity,
                                //   child: Column(
                                //     children: [
                                //       GlobalView().sizedBoxView(10),
                                //       GlobalView().textFieldView(
                                //           AppImages.ic_location,
                                //           cityTextEditingController,
                                //           AppMessages.hint_city_name,
                                //           AppTextStyle.start_text_align),
                                //     ],
                                //   ),
                                // ),

                                // GlobalView().sizedBoxView(10),
                                // Container(
                                //   padding: EdgeInsets.symmetric(vertical: 5),
                                //   alignment: Alignment.centerLeft,
                                //   child: GlobalView().textViewWithCenterAlign(
                                //       AppMessages.title_city,
                                //       AppTextStyle.inter_font_family,
                                //       AppTextStyle.normal_font_weight,
                                //       BaseColor.black_color.withOpacity(0.5),
                                //       11),
                                // ),
                                // cityAutoCompleteTextFieldView(),
                                GlobalView().sizedBoxView(10),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.centerLeft,
                                  child: GlobalView().textViewWithCenterAlign(
                                      AppMessages.title_business_address,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.normal_font_weight,
                                      BaseColor.black_color.withOpacity(0.5),
                                      11),
                                ),
                                GlobalView().textFieldView(
                                    AppImages.ic_location,
                                    businessAddressTextEditingController,
                                    AppMessages.hint_business_address,
                                    AppTextStyle.start_text_align),
                                GlobalView().sizedBoxView(10),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.centerLeft,
                                  child: GlobalView().textViewWithCenterAlign(
                                      AppMessages
                                          .title_business_gps_coordinates,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.normal_font_weight,
                                      BaseColor.black_color.withOpacity(0.5),
                                      11),
                                ),
                                textFieldViewForBusinessGPSCoordinate(
                                    AppImages.ic_location,
                                    businessGPSCoordinatesTextEditingController,
                                    AppMessages.hint_business_gps_coordinates,
                                    AppTextStyle.start_text_align),
                                GlobalView().sizedBoxView(20),
                                Visibility(
                                  visible: widget.isEditable ? true : false,
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigator.pushNamed(
                                      //   context,
                                      //   AppRoutes.add_more_locations_route_name,
                                      //   arguments: AddMoreLocationArgs(
                                      //     Provider.of<BusinessUserProvider>(
                                      //             context,
                                      //             listen: false)
                                      //         .businessUserProfileResponse
                                      //         .latLong,
                                      //   ),
                                      // );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              AddMoreLocationsScreen(),
                                        ),
                                      ).then((onCallBack));
                                    },
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: GlobalView()
                                          .wrappedButtonFilledView(
                                              context,
                                              AppMessages
                                                  .add_more_locations_text),
                                    ),
                                  ),
                                ),
                                GlobalView().sizedBoxView(30),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: GlobalView().textViewWithCenterAlign(
                                      AppMessages.add_photos_videos_text,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.semi_bold_font_weight,
                                      BaseColor.black_color,
                                      16),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: widget.isEditable &&
                                    Provider.of<BusinessUserProvider>(context)
                                            .selectedBusiness ==
                                        AppMessages.mobile_text
                                ? true
                                : false,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //   context,
                                  //   AppRoutes.add_more_locations_route_name,
                                  //   arguments: AddMoreLocationArgs(
                                  //     Provider.of<BusinessUserProvider>(
                                  //             context,
                                  //             listen: false)
                                  //         .businessUserProfileResponse
                                  //         .latLong,
                                  //   ),
                                  // );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AddMoreLocationsScreen(),
                                    ),
                                  ).then((onCallBack));
                                },
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: GlobalView().wrappedButtonFilledView(
                                      context,
                                      AppMessages.add_more_locations_text),
                                ),
                              ),
                            ),
                          ),
                          GlobalView().sizedBoxView(27),
                          addPhotosorVideosView(context),
                          GlobalView().sizedBoxView(10),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: GlobalView().textViewWithCenterAlign(
                                AppMessages.personal_info_text,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.semi_bold_font_weight,
                                BaseColor.black_color,
                                16),
                          ),
                          GlobalView().sizedBoxView(10),
                          GlobalView().textViewWithStartAlign(
                              AppMessages.non_public_info_msg,
                              AppTextStyle.inter_font_family,
                              AppTextStyle.medium_font_weight,
                              BaseColor.black_color,
                              12),
                          GlobalView().sizedBoxView(27),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            alignment: Alignment.centerLeft,
                            child: GlobalView().textViewWithCenterAlign(
                                AppMessages.title_owner_firstname,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.normal_font_weight,
                                BaseColor.black_color.withOpacity(0.5),
                                11),
                          ),
                          GlobalView().textFieldView(
                              AppImages.ic_user,
                              ownerFirstNameTextEditingController,
                              AppMessages.hint_owner_firstname,
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
                              AppMessages.hint_lastname +
                                  AppMessages.of_owner_text,
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
                              AppMessages.hint_email +
                                  AppMessages.of_owner_text,
                              AppTextStyle.start_text_align,
                              textInputType: TextInputType.emailAddress),
                          Visibility(
                            visible: kDebugMode && !widget.isEditable,
                            child: StatefulBuilder(builder: (context, state) {
                              return Column(
                                children: [
                                  GlobalView().sizedBoxView(
                                      DeviceSize().deviceHeight(context) *
                                          0.01),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    alignment: Alignment.centerLeft,
                                    child: GlobalView().textViewWithCenterAlign(
                                        AppMessages.hint_password,
                                        AppTextStyle.inter_font_family,
                                        AppTextStyle.normal_font_weight,
                                        BaseColor.black_color.withOpacity(0.5),
                                        // 11
                                        DeviceSize().deviceHeight(context) *
                                            0.014),
                                  ),
                                  GlobalView().textFieldView(
                                      AppImages.ic_password,
                                      passwordTextEditingController,
                                      AppMessages.hint_password,
                                      AppTextStyle.start_text_align,
                                      isObscure: isObscure,
                                      suffixIcon: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            isObscure = !isObscure;
                                            state(() {});
                                          },
                                          icon: Icon(
                                            isObscure
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: BaseColor
                                                .btn_gradient_start_color1,
                                          ))),
                                ],
                              );
                            }),
                          ),
                          GlobalView().sizedBoxView(10),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            alignment: Alignment.centerLeft,
                            child: GlobalView().textViewWithCenterAlign(
                                AppMessages.title_other_phone_number,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.normal_font_weight,
                                BaseColor.black_color.withOpacity(0.5),
                                11),
                          ),
                          GlobalView().textFieldViewPhone(
                              AppImages.ic_phone,
                              otherPhoneTextEditingController,
                              AppMessages.hint_other_phone_number,
                              AppTextStyle.start_text_align,
                              isReadOnly: widget.isEditable &&
                                  provider.businessUserProfileResponse.user
                                          .currentPlan
                                          .toLowerCase() ==
                                      AppMessages.freeText, onTap: () {
                            if (widget.isEditable &&
                                provider.businessUserProfileResponse.user
                                        .currentPlan
                                        .toLowerCase() ==
                                    AppMessages.freeText) {
                              DialogUtils.displayDialogCallBack(
                                      context,
                                      "",
                                      "",
                                      AppMessages.selectDiffPlanText,
                                      "",
                                      AppMessages.ok_text,
                                      AppMessages.viewPlansHereText)
                                  .then((value) {
                                if (value == AppMessages.viewPlansHereText) {
                                  UrlLauncher()
                                      .launchUrl(ApiUrls.sign_up_website_url);
                                }
                              });
                            }
                          }),
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
                          // GlobalView().textFieldView(
                          //     AppImages.ic_calendar,
                          //     dateofBirthTextEditingController,
                          //     AppMessages.hintDateofBirth +
                          //         AppMessages.ofOwnerText,
                          //     AppTextStyle.startTextAlign),
                          GlobalView().sizedBoxView(50),
                          Visibility(
                            visible: !widget.isEditable,
                            child: Column(
                              children: [
                                // onlineBusinessCheckBoxView(),
                                GlobalView().sizedBoxView(12),
                                ageConfirmationCheckBoxView(),
                                GlobalView().sizedBoxView(12),
                                termsPolicyCheckBoxView(),
                              ],
                            ),
                          ),
                          // Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 5, right: 5, bottom: 50, top: 50),
                            child: Consumer<BusinessUserProvider>(
                                builder: (_, user, child) {
                              return widget.isEditable
                                  ? GestureDetector(
                                      onTap: () {
                                        print("SAVE btn Clicked");
                                        onClickUpdateProfileBtn(
                                            context: context);
                                      },
                                      child: GlobalView().buttonFilled(context,
                                          AppMessages.save_changes_btn_text),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        onClickRegisterBtn(context: context);
                                      },
                                      child: (Provider.of<BusinessUserProvider>(
                                                      context,
                                                      listen: false)
                                                  .isAgeCheckBoxValue &&
                                              Provider.of<BusinessUserProvider>(
                                                      context,
                                                      listen: false)
                                                  .isPrivacyCheckBoxValue)
                                          ? GlobalView().buttonFilled(context,
                                              AppMessages.create_account_text)
                                          : GlobalView().buttonFilledDisabled(
                                              context,
                                              AppMessages.create_account_text));
                            }),
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
                    onTap: () async {
                      Provider.of<BusinessUserProvider>(context, listen: false)
                          .userImage = null;
                      Provider.of<BusinessUserProvider>(context, listen: false)
                          .isVisibleMetropolitanCity = false;
                      Provider.of<BusinessUserProvider>(context, listen: false)
                          .listBusinessKeywords
                          .clear();
                      Navigator.pop(context);
                    },
                    child: GlobalView().assetImageView(AppImages.ic_back),
                  ),
                ),
              ),
              Consumer<BusinessUserProvider>(builder: (_, user, child) {
                return Visibility(
                  visible:
                      Provider.of<BusinessUserProvider>(context, listen: false)
                          .isLoading,
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
              //         AppMessages.businessUserRegisterText,
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
    }));
    // });
  }

  Widget searchItemView(String data, String route) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: BaseColor.border_txtfield_color),
            child: Image.asset(
                route == AppMessages.area_text
                    ? AppImages.ic_metro
                    : AppImages.ic_location,
                height: 20,
                width: 20,
                color: BaseColor.pure_white_color),
          ),
          SizedBox(width: 10),
          Expanded(
            child:
                // GlobalView().textViewWithStartAlign(
                //     "item.name GlobalViewGlobalViewGlobalViewGlobalViewGlobalView",
                //     AppTextStyle.inter_font_family,
                //     AppTextStyle.normal_font_weight,
                //     BaseColor.black_color,
                //     14),
                Text(
              // "ABC Gold & silver jewellery manufacturer ABC Gold & silver jewellery manufacturer",
              data,
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: AppTextStyle.inter_font_family,
                fontWeight: AppTextStyle.normal_font_weight,
                color: BaseColor.black_color,
                fontSize: 14,
              ),
            ),
          ),
          Image.asset(AppImages.ic_back_search2,
              height: 15, width: 15, color: BaseColor.black_color),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget metropolitanAutoCompleteTextFieldView() {
    return Consumer<BusinessUserProvider>(
        builder: (ctx, businessProvider, child) {
      return Row(
        children: [
          Expanded(
            child: AbsorbPointer(
              absorbing: businessProvider.isEditableArea,
              child: Theme(
                data: ThemeData(
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: BaseColor.border_txtfield_color,
                  ),
                ),
                child: Material(
                  shadowColor: BaseColor.shadow_color,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(25),
                  child: searchMetropolitanAreaTextField =
                      AutoCompleteTextField<MetropolitanAreaInfo>(
                    key: keyArea,
                    // controller: searchMetropolitanAreaTextField,
                    //  cursorColor: BaseColor.border_txtfield_color,
                    style: TextStyle(
                      color: BaseColor.hint_color,
                      fontFamily: AppTextStyle.inter_font_family,
                      fontSize: 14,
                    ),
                    clearOnSubmit: false,
                    decoration: InputDecoration(
                      // enabled: businessProvider.isEditableArea, // for enabled text
                      // enabled: false,
                      isDense: true,
                      // filled: true,
                      focusColor: BaseColor.pure_white_color,
                      contentPadding: EdgeInsets.only(left: 50, right: -40),
                      prefixIcon:
                          GlobalView().prefixIconView(AppImages.ic_metro),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            BorderSide(color: BaseColor.border_txtfield_color),
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: BaseColor.border_txtfield_color)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: BaseColor.border_txtfield_color)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: BaseColor.border_txtfield_color)),
                      hintText: AppMessages.hint_metropolitan_area,
                      hintStyle: TextStyle(
                        color: BaseColor.hint_color.withOpacity(0.6),
                        fontFamily: AppTextStyle.inter_font_family,
                        fontSize: 14,
                      ),
                    ),
                    textSubmitted: (value) {
                      businessProvider.selectedMetropolitanAreaNameFun(value);
                      // businessProvider.changeEditableAreaValue();
                    },
                    onFocusChanged: (value) {
                      //   businessProvider.selectedMetropolitanAreaNameFun(
                      //       searchMetropolitanAreaTextField
                      //           .textField.controller.text);
                      // var provider =
                      //     Provider.of<BusinessUserProvider>(context, listen: false);
                      // provider.selectedMetropolitanAreaInfo = null;
                      // provider.selectedMetroCityInfo = null;
                    },
                    itemBuilder: (context, item) {
                      return searchItemView(
                          item.name, AppMessages.area_text.toLowerCase());
                    },
                    itemFilter: (item, query) {
                      return item.name
                          .toLowerCase()
                          .startsWith(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a.name.compareTo(b.name);
                    },
                    itemSubmitted: (item) {
                      print("ITEM NAME-> ${item.name}");
                      searchMetropolitanAreaTextField
                          .textField.controller.text = item.name;
                      print(
                          "AREA TEXT->${searchMetropolitanAreaTextField.textField.controller.text}");
                      // businessProvider.selectedMetropolitanAreaNameFun(item.name);
                      businessProvider.selectedMetropolitanArea(item);
                      businessProvider.changeEditableAreaValue();
                    },
                    suggestions: businessProvider.listMetropolitanAreaInfo,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: businessProvider.isEditableArea,
            child: GestureDetector(
              onTap: () {
                businessProvider.changeEditableAreaValue();
                if (!businessProvider.isEditableArea) {
                  searchMetropolitanAreaTextField.textField.controller.text =
                      "";
                  businessProvider.selectedMetropolitanAreaInfo = null;
                  businessProvider.selectedMetroCityInfo = null;
                  if (searchCityTextField != null &&
                      searchCityTextField.textField.controller.text != null) {
                    searchMetropolitanAreaTextField.textField.controller.text =
                        "";
                  }
                }
              },
              child: Padding(
                padding:
                    EdgeInsets.only(top: 13, bottom: 13, left: 5, right: 0),
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: BaseColor.black_color,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget cityAutoCompleteTextFieldView() {
    return Consumer<BusinessUserProvider>(
        builder: (ctx, businessProvider, child) {
      return Row(
        children: [
          Expanded(
            child: AbsorbPointer(
              absorbing: businessProvider.isEditableCity,
              child: Theme(
                data: ThemeData(
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: BaseColor.border_txtfield_color,
                  ),
                ),
                child: Material(
                  shadowColor: BaseColor.shadow_color,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(25),
                  child: searchCityTextField =
                      AutoCompleteTextField<MetropolitanCityInfo>(
                    key: keyCity,
                    // controller: searchCityTextField,
                    style: TextStyle(
                      color: BaseColor.hint_color,
                      fontFamily: AppTextStyle.inter_font_family,
                      fontSize: 14,
                    ),
                    clearOnSubmit: false,
                    decoration: InputDecoration(
                      isDense: true,
                      // filled: true,
                      focusColor: BaseColor.pure_white_color,
                      contentPadding: EdgeInsets.only(left: 60, right: -40),
                      prefixIcon:
                          GlobalView().prefixIconView(AppImages.ic_location),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            BorderSide(color: BaseColor.border_txtfield_color),
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: BaseColor.border_txtfield_color)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: BaseColor.border_txtfield_color)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: BaseColor.border_txtfield_color)),
                      hintText: AppMessages.hint_city_name,
                      hintStyle: TextStyle(
                        color: BaseColor.hint_color.withOpacity(0.6),
                        fontFamily: AppTextStyle.inter_font_family,
                        fontSize: 14,
                      ),
                    ),
                    // textSubmitted: (value) {
                    //   businessProvider.changeEditableCityValue();
                    // },
                    // onFocusChanged: (value) {
                    //   businessProvider.changeEditableCityValue();
                    // },
                    itemBuilder: (context, item) {
                      return searchItemView(
                          item.name, AppMessages.city_text.toLowerCase());
                    },

                    itemFilter: (item, query) {
                      return item.name
                          .toLowerCase()
                          .startsWith(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a.name.compareTo(b.name);
                    },
                    itemSubmitted: (item) {
                      print("ITEM NAME-> ${item.name}");
                      searchCityTextField.textField.controller.text = item.name;
                      businessProvider.selectedCity(item);
                      print(
                          "AREA TEXT->${searchCityTextField.textField.controller.text}");
                      businessProvider.changeEditableCityValue();
                    },
                    suggestions: businessProvider.listCities,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: businessProvider.isEditableCity,
            child: GestureDetector(
              onTap: () {
                print("CIty suffix clicked");
                businessProvider.changeEditableCityValue();
                if (!businessProvider.isEditableCity) {
                  searchCityTextField.textField.controller.text = "";
                  businessProvider.selectedMetroCityInfo = null;
                }
              },
              child: Padding(
                padding:
                    EdgeInsets.only(top: 13, bottom: 13, left: 5, right: 0),
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: BaseColor.black_color,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget addPhotosorVideosView(BuildContext context) {
    print("PADDING-> ${DeviceSize().deviceWidth(context) / 30}");
    return Container(
      // color: Colors.green,
      child: Wrap(children: [
        MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Consumer<BusinessUserProvider>(
              builder: (context, businessUser, child) {
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: businessUser.listImageUrl.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: (0.8),
                  ),
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return index == businessUser.listImageUrl.length
                        ? GestureDetector(
                            onTap: () {
                              isVideo = true;
                              _showPicker(context, AppMessages.media_text);
                            },
                            child: Container(
                                padding: EdgeInsets.all(
                                    DeviceSize().deviceWidth(context) / 30),
                                decoration: BoxDecoration(
                                  // color: Colors.red,
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                      color: BaseColor.box_border_color),
                                ),
                                // height: 16,
                                // width: 53,
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Image.asset(
                                    AppImages.ic_add,
                                    // height: 16,
                                    // width: 16,
                                  ),
                                )),
                          )
                        : Stack(
                            children: [
                              // Container(
                              //   color: Colors.red,
                              //   child: Image.asset(
                              //     AppImages.photo2,
                              //     height: 160,
                              //     width: 160,
                              //     fit: BoxFit.fitHeight,
                              //   ),
                              // ),
                              Container(
                                // color: Colors.red,
                                decoration: BoxDecoration(
                                  // color: Colors.red,
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                      color: BaseColor.box_border_color),
                                ),
                                child: FadeInImage.assetNetwork(
                                  placeholder: AppImages.loader_gif_removeBG,
                                  image: businessUser.listImageUrl[index],
                                  fit: BoxFit.cover,
                                  height: DeviceSize().deviceWidth(context) / 3,
                                  width: DeviceSize().deviceWidth(context) / 3,
                                ),
                                //     Image.network(
                                //   businessUser.list_image_url[index],
                                // height: 160,
                                // width: 160,
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    print("Delete called");
                                    print(
                                        "listImageUrl LENGTH-> ${businessUser.listImageUrl.length}");
                                    if (businessUser.listImageUrl.isNotEmpty) {
                                      Provider.of<BusinessUserProvider>(context,
                                              listen: false)
                                          .removeImageFromList(index);
                                      // .deleteFromBusinessUserImagesList(
                                      //     index);
                                    }
                                  },
                                  child: Image.asset(
                                    AppImages.ic_trash,
                                    height:
                                        DeviceSize().deviceWidth(context) / 12,
                                    width:
                                        DeviceSize().deviceWidth(context) / 12,
                                  ),
                                ),
                              ),
                            ],
                          );
                  },
                );
              },
            ),
          ),
        ),
      ]),
    );
  }

  // Widget categoryTextFieldView() {
  //   return Material(
  //     shadowColor: BaseColor.shadow_color,
  //     elevation: 4,
  //     borderRadius: BorderRadius.circular(25),
  //     child: TextField(
  //       onTap: () {
  //         onClickCategoryView();
  //       },
  //       readOnly: true,
  //       controller: businessCategoryTextEditingController,
  //       cursorColor: BaseColor.border_txtfield_color,
  //       minLines: 1,
  //       maxLines: 3,
  //       textAlign: TextAlign.justify,
  //       style: TextStyle(
  //         color: BaseColor.hint_color,
  //         fontFamily: AppTextStyle.inter_font_family,
  //         fontSize: 14,
  //       ),
  //       // textAlign: AppTextStyle.start_text_align,
  //       decoration: InputDecoration(
  //         isDense: true,
  //         focusColor: BaseColor.pure_white_color,
  //         contentPadding: EdgeInsets.only(left: 60, right: -30),
  //         prefixIcon: GlobalView().prefixIconView(AppImages.ic_category),
  //         //  prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(25),
  //           borderSide: BorderSide(color: BaseColor.border_txtfield_color),
  //         ),
  //         disabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(25),
  //             borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
  //         border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(25),
  //             borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
  //         focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(25),
  //             borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
  //         hintText: AppMessages.hint_category_name,
  //         hintStyle: TextStyle(
  //           color: BaseColor.hint_color.withOpacity(0.6),
  //           fontFamily: AppTextStyle.inter_font_family,
  //           fontSize: 14,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget categoryView() =>
      Consumer<CategoriesListProvider>(builder: (_, categories, child) {
        print(
            "CATEGORY->> ${categories.selectedBusinessCategoryResponse.toJson()}");
        return Material(
          shadowColor: BaseColor.shadow_color,
          elevation: 4,
          borderRadius: BorderRadius.circular(25),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: BaseColor.border_txtfield_color),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.zero,
                    child: GlobalView().prefixIconView(AppImages.ic_category),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<CategoryResponse>(
                          isExpanded: true,
                          value: categories.selectedBusinessCategoryResponse,
                          iconSize: 25,
                          icon: Icon(Icons.arrow_drop_down,
                              color: BaseColor.border_txtfield_color, size: 25),
                          items: <CategoryResponse>[
                            for (var i = 0;
                                i < categories.listCategories.length;
                                i++)
                              categories.listCategories[i]
                          ].map((CategoryResponse value) {
                            return DropdownMenuItem<CategoryResponse>(
                              value: value,
                              child:
                                  //  Text(
                                  //   value.name,
                                  //   overflow: TextOverflow.ellipsis,
                                  //   style: TextStyle(
                                  //       fontFamily: AppTextStyle.inter_font_family,
                                  //       fontWeight: AppTextStyle.normal_font_weight,
                                  //       color: BaseColor.hint_color,
                                  //       fontSize: 14),
                                  // ),
                                  GlobalView().textViewWithStartAlign(
                                      value.name,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.normal_font_weight,
                                      BaseColor.hint_color,
                                      14),
                            );
                          }).toList(),
                          // hint: new GlobalView().textViewWithCenterAlign(
                          //     categories.listCategories[0].name,
                          //     AppTextStyle.inter_font_family,
                          //     AppTextStyle.normal_font_weight,
                          //     BaseColor.hint_color,
                          //     14),
                          onChanged: (selectedValue) {
                            // categories.selectedCategory = selectedValue;
                            categories
                                .selectedBusinessCategoryItem(selectedValue);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );
      });

  Widget metropolitanAreaView() => Consumer<BusinessUserProvider>(
        builder: (ctx, businessProvider, child) {
          return Material(
            shadowColor: BaseColor.shadow_color,
            elevation: 4,
            borderRadius: BorderRadius.circular(25),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: BaseColor.border_txtfield_color),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.zero,
                    child: GlobalView().prefixIconView(AppImages.ic_metro),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<MetropolitanAreaInfo>(
                          isExpanded: true,
                          value: businessProvider.selectedMetropolitanAreaInfo,
                          iconSize: 25,
                          icon: Icon(Icons.arrow_drop_down,
                              color: BaseColor.border_txtfield_color, size: 25),
                          items: <MetropolitanAreaInfo>[
                            for (var i = 0;
                                i <
                                    businessProvider
                                        .listMetropolitanAreaInfo.length;
                                i++)
                              businessProvider.listMetropolitanAreaInfo[i]
                          ].map((MetropolitanAreaInfo value2) {
                            return DropdownMenuItem<MetropolitanAreaInfo>(
                              value: value2,
                              child: new GlobalView().textViewWithStartAlign(
                                  value2.name,
                                  AppTextStyle.inter_font_family,
                                  AppTextStyle.normal_font_weight,
                                  BaseColor.hint_color,
                                  14),
                            );
                          }).toList(),
                          hint: new GlobalView().textViewWithCenterAlign(
                              businessProvider
                                          .listMetropolitanAreaInfo[0].name ==
                                      null
                                  ? "Area"
                                  : businessProvider
                                      .listMetropolitanAreaInfo[0].name,
                              AppTextStyle.inter_font_family,
                              AppTextStyle.normal_font_weight,
                              BaseColor.black_color.withOpacity(0.5),
                              16),
                          onChanged: (selectedValue) {
                            // categories.selectedCategory = selectedValue;
                            businessProvider
                                .selectedMetropolitanArea(selectedValue);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  Widget businessCityView() =>
      Consumer<BusinessUserProvider>(builder: (_, businessProvider, child) {
        return Material(
          shadowColor: BaseColor.shadow_color,
          elevation: 4,
          borderRadius: BorderRadius.circular(25),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: BaseColor.border_txtfield_color),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.zero,
                    child: GlobalView().prefixIconView(AppImages.ic_location),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<MetropolitanCityInfo>(
                          value: businessProvider.selectedMetroCityInfo,
                          iconSize: 25,
                          isExpanded: true,
                          icon: Icon(Icons.arrow_drop_down,
                              color: BaseColor.border_txtfield_color, size: 25),
                          items: <MetropolitanCityInfo>[
                            for (var j = 0;
                                j <
                                    businessProvider
                                        .selectedMetropolitanAreaInfo
                                        .cities
                                        .length;
                                j++)
                              businessProvider
                                  .selectedMetropolitanAreaInfo.cities[j]
                          ].map((MetropolitanCityInfo value) {
                            return DropdownMenuItem<MetropolitanCityInfo>(
                              value: value,
                              child: new GlobalView().textViewWithStartAlign(
                                  value.name,
                                  AppTextStyle.inter_font_family,
                                  AppTextStyle.normal_font_weight,
                                  BaseColor.hint_color,
                                  14),
                            );
                          }).toList(),
                          hint: new GlobalView().textViewWithCenterAlign(
                              businessProvider
                                  .selectedMetropolitanAreaInfo.cities[0].name,
                              AppTextStyle.inter_font_family,
                              AppTextStyle.normal_font_weight,
                              BaseColor.black_color.withOpacity(0.5),
                              16),
                          onChanged: (selectedValue) {
                            // categories.selectedCategory = selectedValue;
                            businessProvider.selectedCity(selectedValue);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );
      });

  Widget onlineBusinessCheckBoxView() {
    // return Container(
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container(
    //         height: 25,
    //         padding: EdgeInsets.zero,
    //         // color: Colors.green,
    //         child: Theme(
    //           data: ThemeData(
    //               unselectedWidgetColor: BaseColor.btn_gradient_end_color1,
    //               backgroundColor: BaseColor.btn_gradient_end_color1),
    //           child: Consumer<BusinessUserProvider>(
    //             builder: (_, listener, child) => Checkbox(
    //                 value:
    //                     // Provider.of<BusinessUserProvider>(context, listen: false)
    //                     listener.isOnlineBusinessValue,
    //                 checkColor: BaseColor.pure_white_color,
    //                 activeColor: BaseColor.btn_gradient_end_color1,
    //                 onChanged: (bool value) {
    //                   // Provider.of<BusinessUserProvider>(context, listen: false)
    //                   listener.setOnlineBusinessValue(value);
    //                 }),
    //           ),
    //         ),
    //       ),
    //       Expanded(
    //           child: GlobalView().textViewWithStartAlign(
    //               AppMessages.online_only_text,
    //               AppTextStyle.inter_font_family,
    //               AppTextStyle.medium_font_weight,
    //               BaseColor.forgot_pass_txt_color,
    //               16))
    //     ],
    //   ),
    // );
    print("SPACE between-> ${DeviceSize().deviceWidth(context) * 0.01}");
    return Container(
      // width:DeviceSize().deviceWidth(context) * 0.8,
      child: Consumer<BusinessUserProvider>(
        builder: (_, listener, child) => RadioGroup<String>.builder(
          // spacebetween: DeviceSize().deviceWidth(context) * 0.01,

          spacebetween: 2,
          horizontalAlignment: MainAxisAlignment.spaceEvenly,
          groupValue: listener.selectedBusiness,
          onChanged: (value) {
            // selectedBusiness = value;
            cityTextEditingController.text = "";
            if (searchCityTextField != null &&
                searchCityTextField.textField.controller.text != null) {
              searchMetropolitanAreaTextField.textField.controller.text = "";
            }

            listener.setBusinessTypeValue(value);
          },
          items: listener.listBusiness,
          itemBuilder: (item) => RadioButtonBuilder(
            item,
          ),
          activeColor: BaseColor.btn_gradient_end_color2,
          direction: Axis.horizontal,
        ),
      ),
    );
  }

  Widget ageConfirmationCheckBoxView() =>
      Consumer<BusinessUserProvider>(builder: (context, user, child) {
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
                      value: Provider.of<BusinessUserProvider>(context,
                              listen: false)
                          .isAgeCheckBoxValue,
                      checkColor: BaseColor.pure_white_color,
                      activeColor: BaseColor.btn_gradient_end_color1,
                      onChanged: (bool value) {
                        Provider.of<BusinessUserProvider>(context,
                                listen: false)
                            .setAgeCheckBoxValue();
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
      Consumer<BusinessUserProvider>(builder: (context, user, child) {
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
                      value: Provider.of<BusinessUserProvider>(context,
                              listen: false)
                          .isPrivacyCheckBoxValue,
                      checkColor: BaseColor.pure_white_color,
                      activeColor: BaseColor.btn_gradient_end_color1,
                      onChanged: (bool value) {
                        Provider.of<BusinessUserProvider>(context,
                                listen: false)
                            .setPrivacyCheckBoxValue();
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
                            UrlLauncher().launchUrl(ApiUrls.privacy_policy_url);
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

  Widget textFieldViewForBusinessGPSCoordinate(
          String image,
          TextEditingController controller,
          String hintText,
          TextAlign textAlign) =>
      Material(
        shadowColor: BaseColor.shadow_color,
        elevation: 4,
        borderRadius: BorderRadius.circular(25),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.map_route_name,
              arguments: TempLocationsArgs(false),
            );
          },
          child: TextField(
            controller: controller,
            cursorColor: BaseColor.border_txtfield_color,
            readOnly: true,
            enabled: false,
            style: TextStyle(
              color: BaseColor.hint_color,
              fontFamily: AppTextStyle.inter_font_family,
              fontSize: 14,
            ),
            textAlign: textAlign,
            decoration: InputDecoration(
              isDense: true,
              focusColor: BaseColor.pure_white_color,
              contentPadding: EdgeInsets.only(left: 60, right: -50),
              prefixIcon: GlobalView().prefixIconView(image),
              // suffixIcon: Padding(
              //   padding: EdgeInsets.only(left: 0, right: 10),
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (_) => MapScreen()));
              //     },
              //     child: Container(
              //       // color: Colors.red,
              //       padding: EdgeInsets.zero,
              //       width: 83,
              //       height: 15,
              //       alignment: Alignment.centerRight,
              //       child: GlobalView().textViewWithCenterAlign(
              //           AppMessages.currentLocationText,
              //           AppTextStyle.interFontFamily,
              //           AppTextStyle.normalFontWeight,
              //           BaseColor.btnGradientEndColor1,
              //           10),
              //     ),
              //   ),
              // ),
              //  prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: BaseColor.border_txtfield_color),
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      BorderSide(color: BaseColor.border_txtfield_color)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      BorderSide(color: BaseColor.border_txtfield_color)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      BorderSide(color: BaseColor.border_txtfield_color)),
              hintText: hintText,
              hintStyle: TextStyle(
                color: BaseColor.hint_color.withOpacity(0.6),
                fontFamily: AppTextStyle.inter_font_family,
                fontSize: 14,
              ),
            ),
          ),
        ),
      );

  void _onImageButtonPressed(String imageType, ImageSource source,
      {BuildContext context}) async {
    try {
      final ImagePicker _picker = new ImagePicker();
      final pickedFile = await _picker.getImage(
        source: source,
        // maxWidth: maxWidth,
        // maxHeight: maxHeight,
        imageQuality: 50,
      );

      String type = imageType == AppMessages.profile_text
          ? AppMessages.profile_text.toLowerCase()
          : AppMessages.media_text.toLowerCase();
      print("TYPE-> $type");
      print("source--> $source");

      if (widget.isEditable == false) {
        _imageFile = pickedFile;
        // Future<Uint8List> imageUrl = _imageFile.readAsBytes();
        Provider.of<BusinessUserProvider>(context, listen: false)
            .addToBusinessUserImagesList(_imageFile.path);
        print("_imageFile-->> ${_imageFile.path.toString()}");
        File file = File(_imageFile.path);
        String ext = p.extension(file.path);
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        print("fileName===-->> $fileName");
        // FileRequests().uploadImageToS3(file, fileName, ext);
        Provider.of<BusinessUserProvider>(context, listen: false)
            .getImageUrl(context, file, fileName, ext);
      } else {
        if (type == AppMessages.media_text.toLowerCase()) {
          PickedFile mediaFile;
          mediaFile = pickedFile;
          Provider.of<BusinessUserProvider>(context, listen: false)
              .addToBusinessUserImagesList(mediaFile.path);
          print("mediaFile-->> ${mediaFile.path.toString()}");
          File file = File(mediaFile.path);
          String ext = p.extension(file.path);
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          print("fileName===-->> $fileName");
          Provider.of<BusinessUserProvider>(context, listen: false)
              .getImageUrl(context, file, fileName, ext);
        } else {
          _imageFile = pickedFile;
          print("_imageFile-->> ${_imageFile.path.toString()}");
          imageFileBody = File(_imageFile.path);
          print("imageFileBody->> $imageFileBody");
          Provider.of<BusinessUserProvider>(context, listen: false)
              .setStandardUserImage(imageFileBody);
        }
      }
      // }
    } catch (e) {
      pickImageError = e;
    }
  }

  void _showPicker(context, String type) {
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
                        _onImageButtonPressed(type, ImageSource.gallery,
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

  void registerOnlineBusiness() {
    // String url = businessWebsiteTextEditingController.text;
    // if (!url.startsWith("http")) {
    //   url = "http://" + url;
    // }
    // print("Url-> $url");
    if (Provider.of<BusinessUserProvider>(context, listen: false)
            .isAgeCheckBoxValue &&
        Provider.of<BusinessUserProvider>(context, listen: false)
            .isPrivacyCheckBoxValue) {
      if (businessNameTextEditingController.text.isNotEmpty &&
          businessPhoneNumberTextEditingController.text.isNotEmpty &&
          ownerFirstNameTextEditingController.text.isNotEmpty &&
          lastNameTextEditingController.text.isNotEmpty &&
          userNameTextEditingController.text.isNotEmpty &&
          emailTextEditingController.text.isNotEmpty &&
          otherPhoneTextEditingController.text.isNotEmpty &&
          businessWebsiteTextEditingController.text.isNotEmpty) {
        if (ValidationUtils()
                .isUrlValidate(businessWebsiteTextEditingController.text) &&
            ValidationUtils()
                .isEmailValidate(emailTextEditingController.text) &&
            businessPhoneNumberTextEditingController.text.length == 10 &&
            otherPhoneTextEditingController.text.length == 10 &&
            Provider.of<BusinessUserProvider>(context, listen: false)
                .listBusinessUserImages
                .isNotEmpty) {
          Provider.of<BusinessUserProvider>(context, listen: false)
              .businessUserRegister(
            context,
            ownerFirstNameTextEditingController.text,
            lastNameTextEditingController.text,
            userNameTextEditingController.text,
            emailTextEditingController.text,
            businessNameTextEditingController.text,
            "",
            businessPhoneNumberTextEditingController.text,
            "",
            "",
            "",
            "",
            otherPhoneTextEditingController.text,
            2,
            Provider.of<BusinessUserProvider>(context, listen: false)
                        .isAgeCheckBoxValue ==
                    true
                ? 1
                : 0,
            Provider.of<BusinessUserProvider>(context, listen: false)
                        .isPrivacyCheckBoxValue ==
                    true
                ? 1
                : 0,
            Provider.of<CategoriesListProvider>(context, listen: false)
                .listSelectedCategoryId
                .join(','),
            Provider.of<BusinessUserProvider>(context, listen: false)
                .listImageUrl
                .join(','),
            0,
            0,
            businessWebsiteTextEditingController.text,
            Provider.of<BusinessUserProvider>(context, listen: false)
                        .selectedBusiness ==
                    AppMessages.online_text
                ? 1
                : 0,
            Provider.of<BusinessUserProvider>(context, listen: false)
                        .selectedBusiness ==
                    AppMessages.mobile_text
                ? 1
                : 0,
          );
        } else if (!ValidationUtils()
            .isUrlValidate(businessWebsiteTextEditingController.text)) {
          GlobalView().showToast(AppToastMessages.valid_website_message);
        } else if (businessPhoneNumberTextEditingController.text.length != 10 ||
            otherPhoneTextEditingController.text.length != 10) {
          GlobalView().showToast(AppToastMessages.valid_phoneno_message);
        } else if (Provider.of<BusinessUserProvider>(context, listen: false)
            .listImageUrl
            .isEmpty) {
          GlobalView().showToast(AppToastMessages.image_selection);
        } else if (!ValidationUtils()
            .isEmailValidate(emailTextEditingController.text)) {
          GlobalView().showToast(AppToastMessages.valid_email_message);
        }
      } else {
        GlobalView().showToast(AppToastMessages.empty_value_message);
      }
    }
  }

  void registerOfflineBusiness() {
    // print("VAlue-> ${searchCityTextField.textField.controller.text}");
    var provider = Provider.of<BusinessUserProvider>(context, listen: false);
    if (provider.selectedMetropolitanAreaInfo != null) {
      if (provider.selectedMetropolitanAreaInfo.name !=
          searchMetropolitanAreaTextField.textField.controller.text) {
        provider.setAreaCityResponseNull();
      }
    }
    if (provider.isAgeCheckBoxValue && provider.isPrivacyCheckBoxValue) {
      if (businessNameTextEditingController.text.isNotEmpty &&
          businessPhoneNumberTextEditingController.text.isNotEmpty &&
          // searchMetropolitanAreaTextField
          //     .textField.controller.text.isNotEmpty &&
          cityTextEditingController.text.isNotEmpty &&
          // searchCityTextField.textField.controller.text.isNotEmpty &&
          businessAddressTextEditingController.text.isNotEmpty &&
          ownerFirstNameTextEditingController.text.isNotEmpty &&
          lastNameTextEditingController.text.isNotEmpty &&
          userNameTextEditingController.text.isNotEmpty &&
          emailTextEditingController.text.isNotEmpty &&
          otherPhoneTextEditingController.text.isNotEmpty &&
          businessWebsiteTextEditingController.text.isNotEmpty) {
        if (ValidationUtils()
                .isUrlValidate(businessWebsiteTextEditingController.text) &&
            ValidationUtils()
                .isEmailValidate(emailTextEditingController.text) &&
            businessPhoneNumberTextEditingController.text.length == 10 &&
            otherPhoneTextEditingController.text.length == 10 &&
            provider.listBusinessUserImages.isNotEmpty &&
            businessGPSCoordinatesTextEditingController.text != "0.00.0") {
          provider.businessUserRegister(
            context,
            ownerFirstNameTextEditingController.text,
            lastNameTextEditingController.text,
            userNameTextEditingController.text,
            emailTextEditingController.text,
            businessNameTextEditingController.text,
            businessAddressTextEditingController.text,
            businessPhoneNumberTextEditingController.text,
            _latitude.toString(),
            _longitude.toString(),
            // Provider.of<BusinessUserProvider>(context, listen: false)
            //     .selectedMetroCityInfo
            //     .name,
            // Provider.of<BusinessUserProvider>(context, listen: false)
            //     .selectedMetropolitanAreaInfo
            //     .name,
            //  searchCityTextField != null &&
            //         searchCityTextField.textField.controller.text != null
            //     ? searchCityTextField.textField.controller.text
            //     : "",
            cityTextEditingController.text,
            searchMetropolitanAreaTextField.textField.controller.text,
            otherPhoneTextEditingController.text,
            2,
            provider.isAgeCheckBoxValue == true ? 1 : 0,
            provider.isPrivacyCheckBoxValue == true ? 1 : 0,
            Provider.of<CategoriesListProvider>(context, listen: false)
                .listSelectedCategoryId
                .join(','),
            provider.listImageUrl.join(','),
            provider.selectedMetropolitanAreaInfo != null
                ? provider.selectedMetropolitanAreaInfo.id
                // : metropolitanAreaTextEditingController.text,
                : 0,
            // searchMetropolitanAreaTextField
            //     .textField.controller.text,
            searchCityTextField != null &&
                    searchCityTextField.textField.controller.text.isNotEmpty
                ? provider.selectedMetroCityInfo != null
                    ? provider.selectedMetroCityInfo.id
                    : 0
                : 0,
            // searchCityTextField.textField.controller.text,
            businessWebsiteTextEditingController.text,
            Provider.of<BusinessUserProvider>(context, listen: false)
                        .selectedBusiness ==
                    AppMessages.online_text
                ? 1
                : 0,
            Provider.of<BusinessUserProvider>(context, listen: false)
                        .selectedBusiness ==
                    AppMessages.mobile_text
                ? 1
                : 0,
          );
        } else if (!ValidationUtils()
            .isUrlValidate(businessWebsiteTextEditingController.text)) {
          GlobalView().showToast(AppToastMessages.valid_website_message);
        } else if (businessGPSCoordinatesTextEditingController.text.isEmpty) {
          GlobalView().showToast(AppToastMessages.select_location_message);
        } else if (businessPhoneNumberTextEditingController.text.length != 10 ||
            otherPhoneTextEditingController.text.length != 10) {
          GlobalView().showToast(AppToastMessages.valid_phoneno_message);
        } else if (Provider.of<BusinessUserProvider>(context, listen: false)
            .listImageUrl
            .isEmpty) {
          GlobalView().showToast(AppToastMessages.image_selection);
        } else if (!ValidationUtils()
            .isEmailValidate(emailTextEditingController.text)) {
          GlobalView().showToast(AppToastMessages.valid_email_message);
        }
      } else {
        GlobalView().showToast(AppToastMessages.empty_value_message);
      }
    }
  }

  void onClickRegisterBtn({BuildContext context}) {
    if (Provider.of<BusinessUserProvider>(context, listen: false)
                .selectedBusiness ==
            AppMessages.online_text ||
        Provider.of<BusinessUserProvider>(context, listen: false)
                .selectedBusiness ==
            AppMessages.mobile_text) {
      registerOnlineBusiness();
    } else {
      registerOfflineBusiness();
    }
  }

  void updateOfflineBusinessData() {
    if (businessNameTextEditingController.text.isNotEmpty &&
        businessPhoneNumberTextEditingController.text.isNotEmpty &&
        // cityTextEditingController.text.isNotEmpty &&
        // metropolitanAreaTextEditingController.text.isNotEmpty &&
        businessAddressTextEditingController.text.isNotEmpty &&
        ownerFirstNameTextEditingController.text.isNotEmpty &&
        lastNameTextEditingController.text.isNotEmpty &&
        userNameTextEditingController.text.isNotEmpty &&
        emailTextEditingController.text.isNotEmpty &&
        otherPhoneTextEditingController.text.isNotEmpty) {
      if (ValidationUtils()
              .isUrlValidate(businessWebsiteTextEditingController.text) &&
          ValidationUtils().isEmailValidate(emailTextEditingController.text) &&
          businessPhoneNumberTextEditingController.text.length == 10 &&
          otherPhoneTextEditingController.text.length == 10 &&
          Provider.of<BusinessUserProvider>(context, listen: false)
              .listImageUrl
              .isNotEmpty &&
          businessGPSCoordinatesTextEditingController.text != "0.00.0") {
        Provider.of<BusinessUserProvider>(context, listen: false)
            .businessUserUpdateProfile(
          context,
          ownerFirstNameTextEditingController.text,
          lastNameTextEditingController.text,
          userNameTextEditingController.text,
          emailTextEditingController.text,
          businessNameTextEditingController.text,
          businessAddressTextEditingController.text,
          businessPhoneNumberTextEditingController.text,
          _latitude.toStringAsFixed(5),
          _longitude.toStringAsFixed(5),
          otherPhoneTextEditingController.text,
          Provider.of<CategoriesListProvider>(context, listen: false)
              .listSelectedCategoryId
              .join(','),
          Provider.of<BusinessUserProvider>(context, listen: false)
              .listImageUrl
              .join(','),
          Provider.of<BusinessUserProvider>(context, listen: false)
              .selectedMetropolitanAreaInfo
              .id,
          Provider.of<BusinessUserProvider>(context, listen: false)
              .selectedMetroCityInfo
              .id,
          cityTextEditingController.text,
          businessWebsiteTextEditingController.text,
          0,
          0,
          Provider.of<BusinessUserProvider>(context, listen: false).userImage ==
                  null
              ? File("")
              : Provider.of<BusinessUserProvider>(context, listen: false)
                  .userImage,
        );
      } else if (!ValidationUtils()
          .isUrlValidate(businessWebsiteTextEditingController.text)) {
        GlobalView().showToast(AppToastMessages.valid_website_message);
      } else if (businessGPSCoordinatesTextEditingController.text.isEmpty) {
        GlobalView().showToast(AppToastMessages.select_location_message);
      } else if (businessPhoneNumberTextEditingController.text.length != 10 ||
          otherPhoneTextEditingController.text.length != 10) {
        GlobalView().showToast(AppToastMessages.valid_phoneno_message);
      } else if (Provider.of<BusinessUserProvider>(context, listen: false)
          .listImageUrl
          .isEmpty) {
        GlobalView().showToast(AppToastMessages.image_selection);
      } else if (!ValidationUtils()
          .isEmailValidate(emailTextEditingController.text)) {
        GlobalView().showToast(AppToastMessages.valid_email_message);
      }
    } else {
      GlobalView().showToast(AppToastMessages.empty_value_message);
    }
  }

  void updateOnlineBusinessData() {
    if (businessNameTextEditingController.text.isNotEmpty &&
        businessPhoneNumberTextEditingController.text.isNotEmpty &&
        ownerFirstNameTextEditingController.text.isNotEmpty &&
        lastNameTextEditingController.text.isNotEmpty &&
        userNameTextEditingController.text.isNotEmpty &&
        emailTextEditingController.text.isNotEmpty &&
        otherPhoneTextEditingController.text.isNotEmpty) {
      if (ValidationUtils()
              .isUrlValidate(businessWebsiteTextEditingController.text) &&
          ValidationUtils().isEmailValidate(emailTextEditingController.text) &&
          businessPhoneNumberTextEditingController.text.length == 10 &&
          otherPhoneTextEditingController.text.length == 10 &&
          Provider.of<BusinessUserProvider>(context, listen: false)
              .listImageUrl
              .isNotEmpty) {
        Provider.of<BusinessUserProvider>(context, listen: false)
            .businessUserUpdateProfile(
          context,
          ownerFirstNameTextEditingController.text,
          lastNameTextEditingController.text,
          userNameTextEditingController.text,
          emailTextEditingController.text,
          businessNameTextEditingController.text,
          "",
          businessPhoneNumberTextEditingController.text,
          "",
          "",
          otherPhoneTextEditingController.text,
          Provider.of<CategoriesListProvider>(context, listen: false)
              .listSelectedCategoryId
              .join(','),
          Provider.of<BusinessUserProvider>(context, listen: false)
              .listImageUrl
              .join(','),
          0,
          0,
          cityTextEditingController.text,
          businessWebsiteTextEditingController.text,
          1,
          Provider.of<BusinessUserProvider>(context, listen: false)
                      .selectedBusiness ==
                  AppMessages.mobile_text
              ? 1
              : 0,
          Provider.of<BusinessUserProvider>(context, listen: false).userImage ==
                  null
              ? File("")
              : Provider.of<BusinessUserProvider>(context, listen: false)
                  .userImage,
        );
      } else if (!ValidationUtils()
          .isUrlValidate(businessWebsiteTextEditingController.text)) {
        GlobalView().showToast(AppToastMessages.valid_website_message);
      } else if (businessGPSCoordinatesTextEditingController.text.isEmpty) {
        GlobalView().showToast(AppToastMessages.select_location_message);
      } else if (businessPhoneNumberTextEditingController.text.length != 10 ||
          otherPhoneTextEditingController.text.length != 10) {
        GlobalView().showToast(AppToastMessages.valid_phoneno_message);
      } else if (Provider.of<BusinessUserProvider>(context, listen: false)
          .listImageUrl
          .isEmpty) {
        GlobalView().showToast(AppToastMessages.image_selection);
      } else if (!ValidationUtils()
          .isEmailValidate(emailTextEditingController.text)) {
        GlobalView().showToast(AppToastMessages.valid_email_message);
      }
    } else {
      GlobalView().showToast(AppToastMessages.empty_value_message);
    }
  }

  void onClickUpdateProfileBtn({BuildContext context}) {
    if (Provider.of<BusinessUserProvider>(context, listen: false)
                .selectedBusiness ==
            AppMessages.mobile_text ||
        Provider.of<BusinessUserProvider>(context, listen: false)
                .selectedBusiness ==
            AppMessages.online_text) {
      updateOnlineBusinessData();
    } else {
      updateOfflineBusinessData();
    }
  }

  void setRegisterData() {
    var provider = Provider.of<BusinessUserProvider>(context, listen: false);
    if (provider.centerLatitude == null && provider.centerLongitude == null) {
      businessGPSCoordinatesTextEditingController.text.isEmpty;
    } else {
      businessGPSCoordinatesTextEditingController.text =
          provider.centerLatitude.toStringAsFixed(5) +
              "/" +
              provider.centerLongitude.toStringAsFixed(5);
      var parts = businessGPSCoordinatesTextEditingController.text.split("/");
      _latitude = double.parse(parts[0]);
      _longitude = double.parse(parts[1]);

      print("_latitude===> $_latitude");
    }
  }

  void setProfileData() async {
    // if (Provider.of<BusinessUserProvider>(context, listen: false)
    //         .editProfileResponse !=
    //     null) {
    //   businessUserResponse =
    //       Provider.of<BusinessUserProvider>(context, listen: false)
    //           .editProfileResponse;
    var provider = Provider.of<BusinessUserProvider>(context, listen: false);
    provider.getBusinessUserProfile(context);

    String model = await PreferenceUtils.getObject(
        PreferenceUtils.keyBusinessUserProfileObject);

    businessUserResponse = BusinessUserResponse.fromJson(json.decode(model));

    setState(() {});
    print("isMobile-> ${businessUserResponse.isMobile}");
    if (businessUserResponse.isMobile == 1) {
      provider.setBusinessTypeValue(AppMessages.mobile_text);
    } else {
      if (businessUserResponse.isOnline == 1) {
        provider.setBusinessTypeValue(AppMessages.online_text);
      } else {
        provider.setBusinessTypeValue(AppMessages.physical_text);
      }
    }
    print("IS ONLINE->> ${businessUserResponse.isOnline}");
    print("MEDIA length-->> ${businessUserResponse.businessMedia.length}");
    _latitude = double.parse(businessUserResponse.latitude);
    _longitude = double.parse(businessUserResponse.latitude);
    // businessCategoryTextEditingController.text =
    //     businessUserResponse.category.name;
    businessNameTextEditingController.text = businessUserResponse.businessName;
    businessPhoneNumberTextEditingController.text =
        businessUserResponse.businessPhone;
    businessAddressTextEditingController.text =
        businessUserResponse.businessAddress;
    print("businessUserResponse->  ${businessUserResponse.toJson()}");
    print("City Name-> ${businessUserResponse.cityName}");
    cityTextEditingController.text = businessUserResponse.cityName;
    businessWebsiteTextEditingController.text =
        businessUserResponse.businessWebsite;
    businessGPSCoordinatesTextEditingController.text =
        double.parse(businessUserResponse.latitude).toStringAsFixed(5) +
            " / " +
            double.parse(businessUserResponse.longitude).toStringAsFixed(5);
    ownerFirstNameTextEditingController.text = businessUserResponse.firstName;
    lastNameTextEditingController.text = businessUserResponse.lastName;
    userNameTextEditingController.text = businessUserResponse.username;
    emailTextEditingController.text = businessUserResponse.email;
    otherPhoneTextEditingController.text = businessUserResponse.contact;
    if (businessUserResponse.metropolitanArea != null) {
      // metropolitanAreaTextEditingController.text =
      searchMetropolitanAreaTextField.textField.controller.text =
          businessUserResponse.metropolitanArea.name ?? "";
    }
    // if (businessUserResponse.city != null) {
    //   searchCityTextField.textField.controller.text =
    //       businessUserResponse.city.name;
    // }
    //  Provider.of<Category>(context, listen: false)
    // businessCategoryTextEditingController.text =
    //     businessUserResponse.category.name;
    if (businessUserResponse.businessMedia.isNotEmpty) {
      List<String> list = [];
      for (var i = 0; i < businessUserResponse.businessMedia.length; i++) {
        list.add(businessUserResponse.businessMedia[i].media);
        print("MEDIA NAME->> ${businessUserResponse.businessMedia[i].media}");
      }
      Provider.of<BusinessUserProvider>(context, listen: false)
          .addArrayToBusinessUserImagesList(list);
    }
    // listMediaImages.add()
    // }
  }

  void onClickCategoryView() {
    var provider = Provider.of<BusinessUserProvider>(context, listen: false);
    if (widget.isEditable &&
        provider.businessUserProfileResponse.user.isApproved == 1) {
      DialogUtils.displayDialogCallBack(
              context,
              "",
              AppMessages.change_category_text,
              AppMessages.change_category_message_text,
              AppMessages.change_category_sub_message_text,
              AppMessages.cancel_text,
              AppMessages.contact_text)
          .then((value) {
        if (value == AppMessages.contact_text) {
          UrlLauncher().openEmail(
              ApiUrls.admin_trendsee_email, AppMessages.change_category_text);
        }
      });
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CategorySelectionScreen(
                    userType: 1,
                  ))).then(onCallBack);
    }
  }

  FutureOr onCallBack(dynamic value) {
    var catProvider =
        Provider.of<CategoriesListProvider>(context, listen: false);
    businessCategoryTextEditingController.text =
        CategoryUtils().getCategoryName(catProvider.listSelectedCategories);
    if (widget.isEditable) {
      setProfileData();
    }
    // var provider = Provider.of<CategoriesListProvider>(context, listen: false);
    // businessCategoryTextEditingController.text =
    //     CategoryUtils().getCategoryName(provider.listSelectedCategories);
    print("Value-> $value");
  }
}
