// import 'dart:io';
// import 'package:email_validator/email_validator.dart';
// import 'package:path/path.dart' as p;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:trendoapp/constants/app_images.dart';
// import 'package:trendoapp/constants/app_messages.dart';
// import 'package:trendoapp/constants/app_routes.dart';
// import 'package:trendoapp/constants/app_text_style.dart';
// import 'package:trendoapp/constants/app_toast_messages.dart';
// import 'package:trendoapp/constants/base_color.dart';
// import 'package:trendoapp/data/models/business_user_response.dart';
// import 'package:trendoapp/data/models/category_response.dart';
// import 'package:trendoapp/data/models/metropolitan_areas_list_response.dart';
// import 'package:trendoapp/global/view/global_view.dart';
// import 'package:trendoapp/providers/business_user_provider.dart';
// import 'package:trendoapp/providers/categories_list_provider.dart';
// import 'package:trendoapp/utils/category_utils.dart';

// class EditBusinessProfileScreen extends StatefulWidget {
//   @override
//   _EditBusinessProfileScreenState createState() =>
//       _EditBusinessProfileScreenState();
// }

// class _EditBusinessProfileScreenState extends State<EditBusinessProfileScreen> {
//   TextEditingController businessNameTextEditingController =
//       new TextEditingController();

//   TextEditingController businessPhoneNumberTextEditingController =
//       new TextEditingController();

//   TextEditingController metropolitanAreaTextEditingController =
//       new TextEditingController();

//   TextEditingController businessAddressTextEditingController =
//       new TextEditingController();

//   TextEditingController businessGPSCoordinatesTextEditingController =
//       new TextEditingController();

//   TextEditingController ownerFirstNameTextEditingController =
//       new TextEditingController();

//   TextEditingController lastNameTextEditingController =
//       new TextEditingController();

//   TextEditingController userNameTextEditingController =
//       new TextEditingController();

//   TextEditingController emailTextEditingController =
//       new TextEditingController();

//   TextEditingController dateofBirthTextEditingController =
//       new TextEditingController();

//   TextEditingController otherPhoneTextEditingController =
//       new TextEditingController();

//   TextEditingController businessCategoryTextEditingController =
//       new TextEditingController();

//   TextEditingController cityTextEditingController = new TextEditingController();

//   String category;
//   BusinessUserResponse businessUserResponse = new BusinessUserResponse();

//   File image;
//   PickedFile imageFile;
//   dynamic pickImageError;
//   bool isVideo = false;
//   List<String> listMediaImages = [];
//   double _latitude;
//   double _longitude;
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () {
//       setProfileData();
//     });
//   }

//   void setProfileData() {
//     if (Provider.of<BusinessUserProvider>(context, listen: false)
//             .editProfileResponse !=
//         null) {
//       businessUserResponse =
//           Provider.of<BusinessUserProvider>(context, listen: false)
//               .editProfileResponse;
//       print("MEDIA length-->> ${businessUserResponse.businessMedia.length}");
//       _latitude = double.parse(businessUserResponse.latitude);
//       _longitude = double.parse(businessUserResponse.latitude);
//       businessNameTextEditingController.text =
//           businessUserResponse.businessName;
//       businessPhoneNumberTextEditingController.text =
//           businessUserResponse.businessPhone;
//       businessAddressTextEditingController.text =
//           businessUserResponse.businessAddress;
//       businessGPSCoordinatesTextEditingController.text =
//           double.parse(businessUserResponse.latitude).toStringAsFixed(5) +
//               " / " +
//               double.parse(businessUserResponse.longitude).toStringAsFixed(5);
//       ownerFirstNameTextEditingController.text = businessUserResponse.firstName;
//       lastNameTextEditingController.text = businessUserResponse.lastName;
//       userNameTextEditingController.text = businessUserResponse.username;
//       emailTextEditingController.text = businessUserResponse.email;
//       otherPhoneTextEditingController.text = businessUserResponse.contact;
//       metropolitanAreaTextEditingController.text =
//           businessUserResponse.metropolitanArea.name ?? "";
//       cityTextEditingController.text = businessUserResponse.city.name;
//       businessCategoryTextEditingController.text =
//           // businessUserResponse.category.name;
//           CategoryUtils().getCategoryName(businessUserResponse.categories);
//       if (businessUserResponse.businessMedia.isNotEmpty) {
//         List<String> list = [];
//         for (var i = 0; i < businessUserResponse.businessMedia.length; i++) {
//           list.add(businessUserResponse.businessMedia[i].media);
//           print("MEDIA NAME->> ${businessUserResponse.businessMedia[i].media}");
//         }
//         Provider.of<BusinessUserProvider>(context, listen: false)
//             .addArrayToBusinessUserImagesList(list);
//       }
//       // listMediaImages.add()
//     }
//   }

//   void onClickSaveBtn({BuildContext context}) {
//     print(
//         "Latitude==-->>> ${Provider.of<BusinessUserProvider>(context, listen: false).centerLatitude.toString()}");
//     print(
//         "Longitude==-->>> ${Provider.of<BusinessUserProvider>(context, listen: false).centerLongitude.toString()}");
//     print("TEXT-->> ${businessGPSCoordinatesTextEditingController.text}");
//     print(
//         "Category value----===-->> ${Provider.of<CategoriesListProvider>(context, listen: false).selectedBusinessCategoryResponse.name}");
//     File file;
//     for (var i = 0;
//         i <
//             Provider.of<BusinessUserProvider>(context, listen: false)
//                 .listImageUrl
//                 .length;
//         i++) {
//       print(
//           "Media Images->> ${Provider.of<BusinessUserProvider>(context, listen: false).listImageUrl[i]}");
//     }
//     if (businessNameTextEditingController.text.isNotEmpty &&
//         businessPhoneNumberTextEditingController.text.isNotEmpty &&
//         // cityTextEditingController.text.isNotEmpty &&
//         // metropolitanAreaTextEditingController.text.isNotEmpty &&
//         businessAddressTextEditingController.text.isNotEmpty &&
//         ownerFirstNameTextEditingController.text.isNotEmpty &&
//         lastNameTextEditingController.text.isNotEmpty &&
//         userNameTextEditingController.text.isNotEmpty &&
//         emailTextEditingController.text.isNotEmpty &&
//         otherPhoneTextEditingController.text.isNotEmpty) {
//       if (EmailValidator.validate(emailTextEditingController.text) &&
//           businessPhoneNumberTextEditingController.text.length == 10 &&
//           otherPhoneTextEditingController.text.length == 10 &&
//           Provider.of<BusinessUserProvider>(context, listen: false)
//               .listImageUrl
//               .isNotEmpty &&
//           businessGPSCoordinatesTextEditingController.text != "0.00.0") {
//         Provider.of<BusinessUserProvider>(context, listen: false)
//             .businessUserUpdateProfile(
//           context,
//           ownerFirstNameTextEditingController.text,
//           lastNameTextEditingController.text,
//           userNameTextEditingController.text,
//           emailTextEditingController.text,
//           businessNameTextEditingController.text,
//           businessAddressTextEditingController.text,
//           businessPhoneNumberTextEditingController.text,
//           _latitude.toStringAsFixed(5),
//           _longitude.toStringAsFixed(5),
//           // Provider.of<BusinessUserProvider>(context, listen: false)
//           //     .centerLatitude
//           //     .toString(),
//           // Provider.of<BusinessUserProvider>(context, listen: false)
//           //     .centerLatitude
//           //     .toString(),
//           otherPhoneTextEditingController.text,
//           Provider.of<CategoriesListProvider>(context, listen: false)
//               .listSelectedCategoryId
//               .join(','),
//           Provider.of<BusinessUserProvider>(context, listen: false)
//               .listImageUrl
//               .join(','),
//           Provider.of<BusinessUserProvider>(context, listen: false)
//               .selectedMetropolitanAreaInfo
//               .id,
//           Provider.of<BusinessUserProvider>(context, listen: false)
//               .selectedMetroCityInfo
//               .id,
//           otherPhoneTextEditingController.text,
//           // Provider.of<BusinessUserProvider>(context, listen: false)
//           //         .isOnlineBusinessValue
//           //     ? 1
//           //     : 0,
//           0,
//           //  Provider.of<BusinessUserProvider>(context, listen: false)
//           //             .selectedBusiness ==
//           //         AppMessages.mobile_text
//           0,
//           file,
//         );
//       } else if (businessGPSCoordinatesTextEditingController.text.isEmpty) {
//         GlobalView().showToast(AppToastMessages.select_location_message);
//       } else if (businessPhoneNumberTextEditingController.text.length != 10 ||
//           otherPhoneTextEditingController.text.length != 10) {
//         GlobalView().showToast(AppToastMessages.valid_phoneno_message);
//       }
//       // else if (Provider.of<BusinessUserProvider>(context, listen: false)
//       //             .centerLatitude
//       //         // .toString()
//       //         ==
//       //         null &&
//       //     Provider.of<BusinessUserProvider>(context, listen: false)
//       //             .centerLongitude
//       //         // .toString()
//       //         ==
//       //         null) {
//       //   GlobalView().showToast(AppToastMessages.selectLocationMessage);
//       // }
//       else if (Provider.of<BusinessUserProvider>(context, listen: false)
//           .listImageUrl
//           .isEmpty) {
//         GlobalView().showToast(AppToastMessages.image_selection);
//       } else if (!EmailValidator.validate(emailTextEditingController.text)) {
//         GlobalView().showToast(AppToastMessages.valid_email_message);
//       }
//     } else {
//       GlobalView().showToast(AppToastMessages.empty_value_message);
//     }
//   }

//   void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
//     try {
//       final ImagePicker _picker = new ImagePicker();
//       final pickedFile = await _picker.getImage(
//         source: source,
//         // maxWidth: maxWidth,
//         // maxHeight: maxHeight,
//         imageQuality: 50,
//       );
//       print("source--> $source");
//       // if (isVideo) {
//       //   final PickedFile file = await _picker.getVideo(
//       //       source: source, maxDuration: const Duration(seconds: 10));
//       //   // await
//       //   print("Video file $file");
//       // } else {

//       imageFile = pickedFile;
//       // Future<Uint8List> imageUrl = imageFile.readAsBytes();
//       Provider.of<BusinessUserProvider>(context, listen: false)
//           .addToBusinessUserImagesList(imageFile.path);
//       // var outputAsUint8List;
//       // imageUrl
//       //     .then((value) => outputAsUint8List = new Uint8List.fromList(value));
//       // Provider.of<BusinessUserProvider>(context, listen: false)
//       //     .add_to_business_user_images_list(outputAsUint8List);
//       // print("outputAsUint8List-> $outputAsUint8List");

//       print("_imageFile-->> ${imageFile.path.toString()}");

//       File file = File(imageFile.path);
//       String ext = p.extension(file.path);
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       print("fileName===-->> $fileName");
//       // FileRequests().uploadImageToS3(file, fileName, ext);
//       Provider.of<BusinessUserProvider>(context, listen: false)
//           .getImageUrl(context, file, fileName, ext);

//       // }
//     } catch (e) {
//       pickImageError = e;
//     }
//   }

//   void _showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text('Photo Library'),
//                       onTap: () {
//                         _onImageButtonPressed(ImageSource.gallery,
//                             context: context);
//                         Navigator.of(context).pop();
//                       }),
//                   // new ListTile(
//                   //   leading: new Icon(Icons.photo_camera),
//                   //   title: new Text('Camera'),
//                   //   onTap: () {
//                   //     _onImageButtonPressed(ImageSource.camera,
//                   //         context: context);
//                   //     Navigator.of(context).pop();
//                   //   },
//                   // ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // return ListenableProvider<BusinessUserProvider>(
//     //     create: (_) => BusinessUserProvider(),
//     //     builder: (context, child) {

//     if (Provider.of<BusinessUserProvider>(context).centerLatitude == null &&
//         Provider.of<BusinessUserProvider>(context).centerLongitude == null) {
//       businessGPSCoordinatesTextEditingController.text.isEmpty;
//     } else {
//       businessGPSCoordinatesTextEditingController.text =
//           Provider.of<BusinessUserProvider>(context)
//                   .centerLatitude
//                   .toStringAsFixed(5) +
//               "/" +
//               Provider.of<BusinessUserProvider>(context)
//                   .centerLongitude
//                   .toStringAsFixed(5);
//       var parts = businessGPSCoordinatesTextEditingController.text.split("/");
//       _latitude = double.parse(parts[0]);
//       _longitude = double.parse(parts[1]);
//       print("_latitude===> $_latitude");
//     }
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         body: Container(
//           width: double.infinity,
//           height: double.infinity,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(
//                 AppImages.background_image1,
//               ),
//               fit: BoxFit.cover,
//               // alignment: Alignment.topCenter,
//             ),
//           ),
//           child:
//               Consumer<BusinessUserProvider>(builder: (_, businessUser, child) {
//             return !businessUser.isLoading
//                 ? Stack(
//                     children: [
//                       // GlobalView().assetImageView(AppImages.backgroundImage1),
//                       Padding(
//                         padding: EdgeInsets.all(16),
//                         child: SingleChildScrollView(
//                           child: Center(
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 30),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   GlobalView().sizedBoxView(47),
//                                   Container(
//                                     alignment: Alignment.topCenter,
//                                     child: GlobalView().textViewWithCenterAlign(
//                                         AppMessages.edit_business_profile_title,
//                                         AppTextStyle.inter_font_family,
//                                         AppTextStyle.semi_bold_font_weight,
//                                         BaseColor.black_color,
//                                         18),
//                                   ),
//                                   GlobalView().sizedBoxView(30),
//                                   GlobalView().textViewWithStartAlign(
//                                       AppMessages.public_info_msg,
//                                       AppTextStyle.inter_font_family,
//                                       AppTextStyle.medium_font_weight,
//                                       BaseColor.black_color,
//                                       12),
//                                   GlobalView().sizedBoxView(10),
//                                   Container(
//                                     padding: EdgeInsets.symmetric(vertical: 5),
//                                     alignment: Alignment.centerLeft,
//                                     child: GlobalView().textViewWithCenterAlign(
//                                         AppMessages.title_business_name,
//                                         AppTextStyle.inter_font_family,
//                                         AppTextStyle.normal_font_weight,
//                                         BaseColor.black_color.withOpacity(0.5),
//                                         11),
//                                   ),
//                                   GlobalView().textFieldView(
//                                       AppImages.ic_business,
//                                       businessNameTextEditingController,
//                                       AppMessages.hint_business_name,
//                                       AppTextStyle.start_text_align),
//                                   GlobalView().sizedBoxView(10),
//                                   Container(
//                                     padding: EdgeInsets.symmetric(vertical: 5),
//                                     alignment: Alignment.centerLeft,
//                                     child: GlobalView().textViewWithCenterAlign(
//                                         AppMessages.title_select_category,
//                                         AppTextStyle.inter_font_family,
//                                         AppTextStyle.normal_font_weight,
//                                         BaseColor.black_color.withOpacity(0.5),
//                                         11),
//                                   ),
//                                   // categoryView(),
//                                   GlobalView().textFieldViewReadOnly(
//                                       AppImages.ic_category,
//                                       businessCategoryTextEditingController,
//                                       AppMessages.hint_category_name,
//                                       AppTextStyle.start_text_align),
//                                   GlobalView().sizedBoxView(10),
//                                   Container(
//                                     padding: EdgeInsets.symmetric(vertical: 5),
//                                     alignment: Alignment.centerLeft,
//                                     child: GlobalView().textViewWithCenterAlign(
//                                         AppMessages.title_business_phone_number,
//                                         AppTextStyle.inter_font_family,
//                                         AppTextStyle.normal_font_weight,
//                                         BaseColor.black_color.withOpacity(0.5),
//                                         11),
//                                   ),
//                                   GlobalView().textFieldViewPhone(
//                                       AppImages.ic_phone,
//                                       businessPhoneNumberTextEditingController,
//                                       AppMessages.hint_business_phone_number,
//                                       AppTextStyle.start_text_align),
//                                   GlobalView().sizedBoxView(10),

//                                   Container(
//                                     padding: EdgeInsets.symmetric(vertical: 5),
//                                     alignment: Alignment.centerLeft,
//                                     child: GlobalView().textViewWithCenterAlign(
//                                         AppMessages.title_metropolitan_area,
//                                         AppTextStyle.inter_font_family,
//                                         AppTextStyle.normal_font_weight,
//                                         BaseColor.black_color.withOpacity(0.5),
//                                         11),
//                                   ),
//                                   GlobalView().textFieldViewReadOnly(
//                                       AppImages.ic_metro,
//                                       metropolitanAreaTextEditingController,
//                                       AppMessages.hint_metropolitan_area,
//                                       AppTextStyle.start_text_align),

//                                   // metropolitanAreaView(),
//                                   GlobalView().sizedBoxView(10),
//                                   Container(
//                                     padding: EdgeInsets.symmetric(vertical: 5),
//                                     alignment: Alignment.centerLeft,
//                                     child: GlobalView().textViewWithCenterAlign(
//                                         AppMessages.title_city,
//                                         AppTextStyle.inter_font_family,
//                                         AppTextStyle.normal_font_weight,
//                                         BaseColor.black_color.withOpacity(0.5),
//                                         11),
//                                   ),
//                                   GlobalView().textFieldViewReadOnly(
//                                       AppImages.ic_location,
//                                       cityTextEditingController,
//                                       AppMessages.hint_city_name,
//                                       AppTextStyle.start_text_align),

//                                   // businessCityView(),
//                                   GlobalView().sizedBoxView(10),

//                                   Container(
//                                     padding: EdgeInsets.symmetric(vertical: 5),
//                                     alignment: Alignment.centerLeft,
//                                     child: GlobalView().textViewWithCenterAlign(
//                                         AppMessages.title_business_address,
//                                         AppTextStyle.inter_font_family,
//                                         AppTextStyle.normal_font_weight,
//                                         BaseColor.black_color.withOpacity(0.5),
//                                         11),
//                                   ),
//                                   GlobalView().textFieldView(
//                                       AppImages.ic_location,
//                                       businessAddressTextEditingController,
//                                       AppMessages.hint_business_address,
//                                       AppTextStyle.start_text_align),
//                                   GlobalView().sizedBoxView(10),

//                                   Container(
//                                     padding: EdgeInsets.symmetric(vertical: 5),
//                                     alignment: Alignment.centerLeft,
//                                     child: GlobalView().textViewWithCenterAlign(
//                                         AppMessages
//                                             .title_business_gps_coordinates,
//                                         AppTextStyle.inter_font_family,
//                                         AppTextStyle.normal_font_weight,
//                                         BaseColor.black_color.withOpacity(0.5),
//                                         11),
//                                   ),
//                                   textFieldViewForBusinessGPSCoordinate(
//                                       context,
//                                       AppImages.ic_location,
//                                       businessGPSCoordinatesTextEditingController,
//                                       AppMessages.hint_business_gps_coordinates,
//                                       AppTextStyle.start_text_align),
//                                   GlobalView().sizedBoxView(30),
//                                   Container(
//                                     alignment: Alignment.centerLeft,
//                                     child: GlobalView().textViewWithCenterAlign(
//                                         AppMessages.add_photos_videos_text,
//                                         AppTextStyle.inter_font_family,
//                                         AppTextStyle.semi_bold_font_weight,
//                                         BaseColor.black_color,
//                                         16),
//                                   ),
//                                   GlobalView().sizedBoxView(27),
//                                   addPhotosorVideosView(context),
//                                   GlobalView().sizedBoxView(30),
//                                   Container(
//                                     alignment: Alignment.centerLeft,
//                                     child: GlobalView().textViewWithCenterAlign(
//                                         AppMessages.personal_info_text,
//                                         AppTextStyle.inter_font_family,
//                                         AppTextStyle.semi_bold_font_weight,
//                                         BaseColor.black_color,
//                                         16),
//                                   ),
//                                   GlobalView().sizedBoxView(10),
//                                   GlobalView().textViewWithStartAlign(
//                                       AppMessages.non_public_info_msg,
//                                       AppTextStyle.inter_font_family,
//                                       AppTextStyle.medium_font_weight,
//                                       BaseColor.black_color,
//                                       12),
//                                   GlobalView().sizedBoxView(27),
//                                   Container(
//                                     padding: EdgeInsets.symmetric(vertical: 5),
//                                     alignment: Alignment.centerLeft,
//                                     child: GlobalView().textViewWithCenterAlign(
//                                         AppMessages.title_owner_firstname,
//                                         AppTextStyle.inter_font_family,
//                                         AppTextStyle.normal_font_weight,
//                                         BaseColor.black_color.withOpacity(0.5),
//                                         11),
//                                   ),
//                                   GlobalView().textFieldView(
//                                       AppImages.ic_user,
//                                       ownerFirstNameTextEditingController,
//                                       AppMessages.hint_owner_firstname,
//                                       AppTextStyle.start_text_align),
//                                   GlobalView().sizedBoxView(10),
//                                   Container(
//                                     padding: EdgeInsets.symmetric(vertical: 5),
//                                     alignment: Alignment.centerLeft,
//                                     child: GlobalView().textViewWithCenterAlign(
//                                         AppMessages.title_lastname,
//                                         AppTextStyle.inter_font_family,
//                                         AppTextStyle.normal_font_weight,
//                                         BaseColor.black_color.withOpacity(0.5),
//                                         11),
//                                   ),
//                                   GlobalView().textFieldView(
//                                       AppImages.ic_user,
//                                       lastNameTextEditingController,
//                                       AppMessages.hint_lastname +
//                                           AppMessages.of_owner_text,
//                                       AppTextStyle.start_text_align),
//                                   GlobalView().sizedBoxView(10),
//                                   Container(
//                                     padding: EdgeInsets.symmetric(vertical: 5),
//                                     alignment: Alignment.centerLeft,
//                                     child: GlobalView().textViewWithCenterAlign(
//                                         AppMessages.title_username,
//                                         AppTextStyle.inter_font_family,
//                                         AppTextStyle.normal_font_weight,
//                                         BaseColor.black_color.withOpacity(0.5),
//                                         11),
//                                   ),
//                                   GlobalView().textFieldView(
//                                       AppImages.ic_user,
//                                       userNameTextEditingController,
//                                       AppMessages.hint_username_reg,
//                                       AppTextStyle.start_text_align),
//                                   GlobalView().sizedBoxView(10),
//                                   Container(
//                                     padding: EdgeInsets.symmetric(vertical: 5),
//                                     alignment: Alignment.centerLeft,
//                                     child: GlobalView().textViewWithCenterAlign(
//                                         AppMessages.title_email,
//                                         AppTextStyle.inter_font_family,
//                                         AppTextStyle.normal_font_weight,
//                                         BaseColor.black_color.withOpacity(0.5),
//                                         11),
//                                   ),
//                                   GlobalView().textFieldView(
//                                       AppImages.ic_email,
//                                       emailTextEditingController,
//                                       AppMessages.hint_email +
//                                           AppMessages.of_owner_text,
//                                       AppTextStyle.start_text_align),
//                                   GlobalView().sizedBoxView(10),
//                                   Container(
//                                     padding: EdgeInsets.symmetric(vertical: 5),
//                                     alignment: Alignment.centerLeft,
//                                     child: GlobalView().textViewWithCenterAlign(
//                                         AppMessages.title_other_phone_number,
//                                         AppTextStyle.inter_font_family,
//                                         AppTextStyle.normal_font_weight,
//                                         BaseColor.black_color.withOpacity(0.5),
//                                         11),
//                                   ),
//                                   GlobalView().textFieldViewPhone(
//                                       AppImages.ic_phone,
//                                       otherPhoneTextEditingController,
//                                       AppMessages.hint_other_phone_number,
//                                       AppTextStyle.start_text_align),
//                                   // GlobalView().sizedBoxView(10),
//                                   // Container(
//                                   //   padding: EdgeInsets.symmetric(vertical: 5),
//                                   //   alignment: Alignment.centerLeft,
//                                   //   child: GlobalView().textViewWithCenterAlign(
//                                   //       AppMessages.titleDateofBirth,
//                                   //       AppTextStyle.interFontFamily,
//                                   //       AppTextStyle.normalFontWeight,
//                                   //       BaseColor.blackColor.withOpacity(0.5),
//                                   //       11),
//                                   // ),
//                                   // GlobalView().textFieldView(
//                                   //     AppImages.ic_calendar,
//                                   //     dateofBirthTextEditingController,
//                                   //     AppMessages.hintDateofBirth +
//                                   //         AppMessages.ofOwnerText,
//                                   //     AppTextStyle.startTextAlign),
//                                   GlobalView().sizedBoxView(50),
//                                   // ageConfirmationCheckBoxView(),
//                                   // GlobalView().sizedBoxView(12),
//                                   // termsPolicyCheckBoxView(),

//                                   // Spacer(),
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 5, right: 5, bottom: 50, top: 30),
//                                     child:
//                                         //  Consumer<BusinessUserProvider>(
//                                         //     builder: (_, user, child) {
//                                         GestureDetector(
//                                       onTap: () {
//                                         print("SAVE btn Clicked");
//                                         onClickSaveBtn(context: context);
//                                       },
//                                       child: GlobalView().buttonFilled(context,
//                                           AppMessages.save_changes_btn_text),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 57,
//                         left: 21,
//                         child: Container(
//                           // color: Colors.red,
//                           height: 25,
//                           width: 25,
//                           child: GestureDetector(
//                               onTap: () {
//                                 Navigator.pop(context);
//                               },
//                               child: GlobalView()
//                                   .assetImageView(AppImages.ic_back)),
//                         ),
//                       ),
//                       // Consumer<BusinessUserProvider>(builder: (_, user, child) {
//                       //   return Visibility(
//                       //     visible:
//                       //         Provider.of<BusinessUserProvider>(context).isLoading,
//                       //     // visible: true,
//                       //     child: Positioned(
//                       //       child: Container(
//                       //         color: BaseColor.loaderBGColor,
//                       //         child: GlobalView().loaderView(),
//                       //       ),
//                       //     ),
//                       //   );
//                       // }),

//                       // Positioned(
//                       //   top: 57,
//                       //   left: 0,
//                       //   right: 0,
//                       //   child: Container(
//                       //     alignment: Alignment.topCenter,
//                       //     child: GlobalView().textView(
//                       //         AppMessages.businessUserRegisterText,
//                       //         AppTextStyle.poppinsFontFamily,
//                       //         AppTextStyle.semiBoldFontWeight,
//                       //         BaseColor.blackColor,
//                       //         18),
//                       //   ),
//                       // ),
//                       Positioned(
//                         child: Visibility(
//                           visible: Provider.of<BusinessUserProvider>(context,
//                                   listen: false)
//                               .isLoading,
//                           child: Container(
//                             // color: BaseColor.loader_bg_color,
//                             child: GlobalView().loaderView(),
//                           ),
//                         ),
//                       )
//                     ],
//                   )
//                 : Container(
//                     // color: BaseColor.loader_bg_color,
//                     child: GlobalView().loaderView(),
//                   );
//           }),
//         ),
//       ),
//     );
//     // });
//   }

//   Widget categoryView() =>
//       Consumer<CategoriesListProvider>(builder: (_, categories, child) {
//         return Material(
//           shadowColor: BaseColor.shadow_color,
//           elevation: 4,
//           borderRadius: BorderRadius.circular(25),
//           child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),
//                 border: Border.all(color: BaseColor.border_txtfield_color),
//               ),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.zero,
//                     child: GlobalView().prefixIconView(AppImages.ic_category),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 20),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<CategoryResponse>(
//                           value: categories.selectedBusinessCategoryResponse,
//                           iconSize: 25,
//                           icon: Icon(Icons.arrow_drop_down,
//                               color: BaseColor.border_txtfield_color, size: 25),
//                           items: <CategoryResponse>[
//                             for (var i = 0;
//                                 i < categories.listCategories.length;
//                                 i++)
//                               categories.listCategories[i]
//                           ].map((CategoryResponse value) {
//                             return DropdownMenuItem<CategoryResponse>(
//                               value: value,
//                               child: new GlobalView().textViewWithCenterAlign(
//                                   value.name,
//                                   AppTextStyle.inter_font_family,
//                                   AppTextStyle.normal_font_weight,
//                                   BaseColor.hint_color,
//                                   14),
//                             );
//                           }).toList(),
//                           hint: new GlobalView().textViewWithCenterAlign(
//                               categories.listCategories[0].name,
//                               AppTextStyle.inter_font_family,
//                               AppTextStyle.normal_font_weight,
//                               BaseColor.hint_color,
//                               14),
//                           onChanged: (selectedValue) {
//                             // categories.selectedCategory = selectedValue;
//                             categories
//                                 .selectedBusinessCategoryItem(selectedValue);
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )),
//         );
//       });

//   Widget metropolitanAreaView() =>
//       Consumer<BusinessUserProvider>(builder: (ctx, businessProvider, child) {
//         return Material(
//           shadowColor: BaseColor.shadow_color,
//           elevation: 4,
//           borderRadius: BorderRadius.circular(25),
//           child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),
//                 border: Border.all(color: BaseColor.border_txtfield_color),
//               ),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.zero,
//                     child: GlobalView().prefixIconView(AppImages.ic_metro),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 20),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<MetropolitanAreaInfo>(
//                           value: businessProvider.selectedMetropolitanAreaInfo,
//                           iconSize: 25,
//                           icon: Icon(Icons.arrow_drop_down,
//                               color: BaseColor.border_txtfield_color, size: 25),
//                           items: <MetropolitanAreaInfo>[
//                             for (var i = 0;
//                                 i <
//                                     businessProvider
//                                         .listMetropolitanAreaInfo.length;
//                                 i++)
//                               businessProvider.listMetropolitanAreaInfo[i]
//                           ].map((MetropolitanAreaInfo value2) {
//                             return DropdownMenuItem<MetropolitanAreaInfo>(
//                               value: value2,
//                               child: new GlobalView().textViewWithCenterAlign(
//                                   value2.name,
//                                   AppTextStyle.inter_font_family,
//                                   AppTextStyle.normal_font_weight,
//                                   BaseColor.hint_color,
//                                   14),
//                             );
//                           }).toList(),
//                           hint: new GlobalView().textViewWithCenterAlign(
//                               businessProvider
//                                           .listMetropolitanAreaInfo[0].name ==
//                                       null
//                                   ? "Area"
//                                   : businessProvider
//                                       .listMetropolitanAreaInfo[0].name,
//                               AppTextStyle.inter_font_family,
//                               AppTextStyle.normal_font_weight,
//                               BaseColor.hint_color,
//                               14),
//                           onChanged: (selectedValue) {
//                             // categories.selectedCategory = selectedValue;
//                             businessProvider
//                                 .selectedMetropolitanArea(selectedValue);
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )),
//         );
//       });

//   Widget businessCityView() =>
//       Consumer<BusinessUserProvider>(builder: (_, businessProvider, child) {
//         return Material(
//           shadowColor: BaseColor.shadow_color,
//           elevation: 4,
//           borderRadius: BorderRadius.circular(25),
//           child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),
//                 border: Border.all(color: BaseColor.border_txtfield_color),
//               ),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.zero,
//                     child: GlobalView().prefixIconView(AppImages.ic_location),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 20),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<MetropolitanCityInfo>(
//                           value: businessProvider.selectedMetroCityInfo,
//                           iconSize: 25,
//                           icon: Icon(Icons.arrow_drop_down,
//                               color: BaseColor.border_txtfield_color, size: 25),
//                           items: <MetropolitanCityInfo>[
//                             for (var j = 0;
//                                 j <
//                                     businessProvider
//                                         .selectedMetropolitanAreaInfo
//                                         .cities
//                                         .length;
//                                 j++)
//                               businessProvider
//                                   .selectedMetropolitanAreaInfo.cities[j]
//                           ].map((MetropolitanCityInfo value) {
//                             return DropdownMenuItem<MetropolitanCityInfo>(
//                               value: value,
//                               child: new GlobalView().textViewWithCenterAlign(
//                                   value.name,
//                                   AppTextStyle.inter_font_family,
//                                   AppTextStyle.normal_font_weight,
//                                   BaseColor.hint_color,
//                                   14),
//                             );
//                           }).toList(),
//                           hint: new GlobalView().textViewWithCenterAlign(
//                               businessProvider
//                                   .selectedMetropolitanAreaInfo.cities[0].name,
//                               AppTextStyle.inter_font_family,
//                               AppTextStyle.normal_font_weight,
//                               BaseColor.hint_color,
//                               14),
//                           onChanged: (selectedValue) {
//                             // categories.selectedCategory = selectedValue;
//                             businessProvider.selectedCity(selectedValue);
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )),
//         );
//       });

//   Widget textFieldViewForBusinessGPSCoordinate(
//           BuildContext context,
//           String image,
//           TextEditingController controller,
//           String hintText,
//           TextAlign textAlign) =>
//       Material(
//         shadowColor: BaseColor.shadow_color,
//         elevation: 4,
//         borderRadius: BorderRadius.circular(25),
//         child: GestureDetector(
//           onTap: () {
//             Navigator.pushNamed(context, AppRoutes.map_route_name);
//           },
//           child: TextField(
//             controller: controller,
//             cursorColor: BaseColor.border_txtfield_color,
//             readOnly: true,
//             enabled: false,
//             style: TextStyle(
//               color: BaseColor.hint_color,
//               fontFamily: AppTextStyle.inter_font_family,
//               fontSize: 14,
//             ),
//             textAlign: textAlign,
//             decoration: InputDecoration(
//               isDense: true,
//               focusColor: BaseColor.pure_white_color,
//               contentPadding: EdgeInsets.only(left: 60, right: -50),
//               prefixIcon: GlobalView().prefixIconView(image),
//               // suffixIcon: Padding(
//               //   padding: EdgeInsets.only(left: 0, right: 10),
//               //   child: GestureDetector(
//               //     onTap: () {
//               //       Navigator.push(context,
//               //           MaterialPageRoute(builder: (_) => MapScreen()));
//               //     },
//               //     child: Container(
//               //       // color: Colors.red,
//               //       padding: EdgeInsets.zero,
//               //       width: 83,
//               //       height: 15,
//               //       alignment: Alignment.centerRight,
//               //       child: GlobalView().textViewWithCenterAlign(
//               //           AppMessages.currentLocationText,
//               //           AppTextStyle.interFontFamily,
//               //           AppTextStyle.normalFontWeight,
//               //           BaseColor.btnGradientEndColor1,
//               //           10),
//               //     ),
//               //   ),
//               // ),
//               //  prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(25),
//                 borderSide: BorderSide(color: BaseColor.border_txtfield_color),
//               ),
//               disabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide:
//                       BorderSide(color: BaseColor.border_txtfield_color)),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide:
//                       BorderSide(color: BaseColor.border_txtfield_color)),
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide:
//                       BorderSide(color: BaseColor.border_txtfield_color)),
//               hintText: hintText,
//               hintStyle: TextStyle(
//                 color: BaseColor.hint_color.withOpacity(0.6),
//                 fontFamily: AppTextStyle.inter_font_family,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         ),
//       );

//   Widget addPhotosorVideosView(BuildContext context) => Container(
//         // color: Colors.green,
//         child: Wrap(children: [
//           MediaQuery.removePadding(
//             removeTop: true,
//             context: context,
//             child: Padding(
//               padding: EdgeInsets.only(bottom: 3),
//               child: Consumer<BusinessUserProvider>(
//                 builder: (context, businessUser, child) {
//                   return !businessUser.isLoading
//                       ? GridView.builder(
//                           physics: NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: businessUser.listImageUrl.length + 1,
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             crossAxisSpacing: 5,
//                             mainAxisSpacing: 5,
//                             childAspectRatio: (0.8),
//                           ),
//                           itemBuilder: (
//                             context,
//                             index,
//                           ) {
//                             return index == businessUser.listImageUrl.length
//                                 ? GestureDetector(
//                                     onTap: () {
//                                       isVideo = true;
//                                       _showPicker(context);
//                                     },
//                                     child: Container(
//                                         padding: EdgeInsets.all(20),
//                                         decoration: BoxDecoration(
//                                           // color: Colors.red,
//                                           shape: BoxShape.rectangle,
//                                           border: Border.all(
//                                               color:
//                                                   BaseColor.box_border_color),
//                                         ),
//                                         // height: 16,
//                                         // width: 53,
//                                         child: Padding(
//                                           padding: EdgeInsets.all(20),
//                                           child: Image.asset(
//                                             AppImages.ic_add,
//                                             // height: 16,
//                                             // width: 16,
//                                           ),
//                                         )),
//                                   )
//                                 : Stack(
//                                     children: [
//                                       // Container(
//                                       //   color: Colors.red,
//                                       //   child: Image.asset(
//                                       //     AppImages.photo2,
//                                       //     height: 160,
//                                       //     width: 160,
//                                       //     fit: BoxFit.fitHeight,
//                                       //   ),
//                                       // ),
//                                       Container(
//                                         // color: Colors.red,
//                                         decoration: BoxDecoration(
//                                           // color: Colors.red,
//                                           shape: BoxShape.rectangle,
//                                           border: Border.all(
//                                               color:
//                                                   BaseColor.box_border_color),
//                                         ),
//                                         child: FadeInImage.assetNetwork(
//                                           placeholder:
//                                               AppImages.loader_gif_removeBG,
//                                           image:
//                                               businessUser.listImageUrl[index],
//                                           fit: BoxFit.cover,
//                                           height: 160,
//                                           width: 160,
//                                         ),
//                                         //     Image.network(
//                                         //   businessUser.list_image_url[index],
//                                         // height: 160,
//                                         // width: 160,
//                                         //   fit: BoxFit.cover,
//                                         // ),
//                                       ),
//                                       Positioned(
//                                         top: 5,
//                                         right: 5,
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             if (businessUser
//                                                 .listImageUrl.isNotEmpty) {
//                                               Provider.of<BusinessUserProvider>(
//                                                       context,
//                                                       listen: false)
//                                                   .removeImageFromList(index);
//                                             }
//                                           },
//                                           child: Image.asset(
//                                             AppImages.ic_trash,
//                                             height: 36,
//                                             width: 36,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                           },
//                         )
//                       : Container();
//                 },
//               ),
//             ),
//           ),
//         ]),
//       );
// }
