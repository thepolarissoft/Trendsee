import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/data/models/verified_user_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/base_response_provider.dart';
import 'package:trendoapp/providers/business_list_provider.dart';
import 'package:trendoapp/utils/category_utils.dart';

// ignore: must_be_immutable
class AddNewCheckInPage extends StatefulWidget {
  @override
  State<AddNewCheckInPage> createState() => _AddNewCheckInPageState();
}

class _AddNewCheckInPageState extends State<AddNewCheckInPage> {
  TextEditingController locationTextEditingController =
      new TextEditingController();

  TextEditingController businessNameTextEditingController =
      new TextEditingController();

  TextEditingController commentTextEditingController =
      new TextEditingController();

  late CameraPosition _cameraPosition;

  GoogleMapController? _controller;

  Set<Marker> _markers = {};

  late BitmapDescriptor pinLocationIcon;

  late LatLng latlong;

  VerifiedUserResponse verifiedUserResponse = new VerifiedUserResponse();

  Future getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    // ignore: unrelated_type_equality_checks
    if (permission != PermissionStatus.granted) {
      LocationPermission permission = await Geolocator.requestPermission();
      // ignore: unrelated_type_equality_checks
      if (permission != PermissionStatus.granted) getLocation();
      return;
    }
    // if (permission != PermissionStatus.granted) {
    //   LocationPermission permission = await Geolocator.requestPermission();
    //   if (permission != PermissionStatus.granted) getLocation();
    //   return;
    // }
    getLocation();
  }

  void setCustomMapPin() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            AppImages.marker_map_icon)
        .then((onValue) {
      pinLocationIcon = onValue;
    });
  }

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);

    // ignore: unrelated_type_equality_checks
    if (verifiedUserResponse.latitude != null &&
        // ignore: unrelated_type_equality_checks
        verifiedUserResponse.latitude != null) {
      latlong = new LatLng(double.parse(verifiedUserResponse.latitude!),
          double.parse(verifiedUserResponse.longitude!));
    } else {
      latlong = new LatLng(position.latitude, position.longitude);
    }

    _cameraPosition = CameraPosition(target: latlong, zoom: 10.0);
    if (_controller != null)
      _controller!
          .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
    // final Uint8List markerIcon =
    //     await getBytesFromAsset(AppImages.marker_map_icon, 100);

    _markers.add(Marker(
        markerId: MarkerId("a"),
        draggable: true,
        position: latlong,
        icon: pinLocationIcon,
        onDragEnd: (_currentlatLng) {
          latlong = _currentlatLng;
        }));

    // _markers.add(Marker(
    //     markerId: MarkerId("1"), position: latlong, icon: pinLocationIcon));

    // getCurrentAddress();
  }

  @override
  void initState() {
    verifiedUserResponse =
        Provider.of<BusinessListProvider>(context, listen: false)
            .verifiedUserResponse;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // setCustomMapPin();
    // _cameraPosition = CameraPosition(target: LatLng(0, 0), zoom: 10.0);
    // getCurrentLocation();
    businessNameTextEditingController.text = verifiedUserResponse.businessName!;
    print("verifiedUserResponse->> ${verifiedUserResponse.businessName}");
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
          child: ListenableProvider<BaseResponseProvider>(
              create: (_) => BaseResponseProvider(),
              builder: (_, child) {
                return !Provider.of<BaseResponseProvider>(
                  context,
                  // listen: false
                ).isLoading
                    ? Stack(
                        children: [
                          // GlobalView().assetImageView(AppImages.backgroundImage1),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: SingleChildScrollView(
                              child: Center(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    GlobalView().sizedBoxView(47),
                                    Container(
                                      alignment: Alignment.topCenter,
                                      child: GlobalView()
                                          .textViewWithCenterAlign(
                                              AppMessages.add_new_checkin_title,
                                              AppTextStyle.inter_font_family,
                                              AppTextStyle.bold_font_weight,
                                              BaseColor.black_color,
                                              18),
                                    ),
                                    Consumer<BusinessListProvider>(
                                      builder: (_, provider, child) {
                                        return Visibility(
                                          visible: !provider.isChecked!,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: textFieldViewForSelectLocation(
                                                AppImages.ic_location,
                                                locationTextEditingController,
                                                AppMessages
                                                    .hint_select_location,
                                                AppTextStyle.start_text_align,
                                                context),
                                          ),
                                        );
                                      },
                                    ),
                                    Consumer<BusinessListProvider>(
                                      builder: (_, provider, child) {
                                        return Visibility(
                                          visible: provider.isChecked!,
                                          child: businessNameView(
                                              context, provider),
                                        );
                                      },
                                    ),
                                    GlobalView().sizedBoxView(10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        alignment: Alignment.centerLeft,
                                        child: GlobalView()
                                            .textViewWithStartAlign(
                                                AppMessages.title_your_review +
                                                    " (optional)",
                                                AppTextStyle.inter_font_family,
                                                AppTextStyle.normal_font_weight,
                                                BaseColor.black_color
                                                    .withOpacity(0.5),
                                                11),
                                      ),
                                    ),
                                    GlobalView().sizedBoxView(5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30,
                                      ),
                                      child: Container(
                                        height: 135,
                                        // width: 50,
                                        // width: ScreenSize().screenWidth(context) - 50,
                                        // padding: EdgeInsets.only(top: 5),
                                        decoration: BoxDecoration(
                                          // color: Colors.red,
                                          image: DecorationImage(
                                              image: AssetImage(AppImages.rect),
                                              fit: BoxFit.contain),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 12),
                                          child: TextField(
                                            controller:
                                                commentTextEditingController,
                                            expands: true,
                                            maxLines: null,
                                            style: TextStyle(
                                              color: BaseColor.hint_color,
                                              fontFamily: AppTextStyle
                                                  .inter_font_family,
                                              fontSize: 14,
                                            ),
                                            // maxLength: 60,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  60),
                                            ],
                                            cursorColor: BaseColor.black_color
                                                .withOpacity(0.5),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              focusColor:
                                                  BaseColor.pure_white_color,
                                              contentPadding: EdgeInsets.only(
                                                  left: 25,
                                                  right: 25,
                                                  top: 10,
                                                  bottom: 10),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              hintText: AppMessages
                                                  .hint_write_comment,
                                              hintStyle: TextStyle(
                                                color: BaseColor.hint_color
                                                    .withOpacity(0.6),
                                                fontFamily: AppTextStyle
                                                    .inter_font_family,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GlobalView().sizedBoxView(40),
                                    Consumer<BusinessListProvider>(
                                        builder: (_, provider, child) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (provider.isChecked!) {
                                            if (businessNameTextEditingController
                                                    .text.isNotEmpty &&
                                                verifiedUserResponse.id !=
                                                    null) {
                                              Provider.of<BusinessListProvider>(
                                                      context,
                                                      listen: false)
                                                  .isChecked = false;
                                              Provider.of<BaseResponseProvider>(
                                                      context,
                                                      listen: false)
                                                  .createFeed(
                                                      context,
                                                      commentTextEditingController.text
                                                              .isEmpty
                                                          ? ""
                                                          : commentTextEditingController
                                                              .text,
                                                      verifiedUserResponse.id
                                                          .toString(),
                                                      verifiedUserResponse
                                                          .categories![0].id
                                                          .toString(),
                                                      verifiedUserResponse
                                                          .businessLatitude,
                                                      verifiedUserResponse
                                                          .businessLongitude,
                                                      verifiedUserResponse
                                                          .locationName);
                                            } else {
                                              GlobalView().showToast(
                                                  AppToastMessages
                                                      .empty_value_message);
                                            }
                                          }
                                          // Navigator.pushNamed(
                                          //     context, AppRoutes.timelineRouteName);
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                            ),
                                            child: provider.isChecked!
                                                ? GlobalView().buttonFilled(
                                                    context,
                                                    AppMessages.submit_btn_text)
                                                : GlobalView()
                                                    .buttonFilledDisabled(
                                                        context,
                                                        AppMessages
                                                            .submit_btn_text)),
                                      );
                                    }),
                                  ],
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
                                    Provider.of<BusinessListProvider>(context,
                                            listen: false)
                                        .isChecked = false;
                                    Navigator.pushNamed(
                                        context, AppRoutes.timeline_route_name);
                                  },
                                  child: GlobalView()
                                      .assetImageView(AppImages.ic_back)),
                            ),
                          ),
                          // Positioned(
                          //   left: 35,
                          //   right: 35,
                          //   bottom: 50,
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       print(
                          //           "Category ID===>> ${verifiedUserResponse.category.id.toString()}");
                          //       if (commentTextEditingController
                          //               .text.isNotEmpty &&
                          //           businessNameTextEditingController
                          //               .text.isNotEmpty &&
                          //           verifiedUserResponse.id != null) {
                          //         Provider.of<BusinessListProvider>(context,
                          //                 listen: false)
                          //             .isChecked = false;
                          //         Provider.of<BaseResponseProvider>(context,
                          //                 listen: false)
                          //             .create_feed(
                          //                 context,
                          //                 commentTextEditingController.text,
                          //                 verifiedUserResponse.id.toString(),
                          //                 verifiedUserResponse.category.id
                          //                     .toString());
                          //       } else {
                          //         GlobalView().showToast(
                          //             AppToastMessages.emptyValueMessage);
                          //       }

                          //       // Navigator.pushNamed(
                          //       //     context, AppRoutes.timelineRouteName);
                          //     },
                          //     child: GlobalView().buttonFilled(
                          //         context, AppMessages.submitBtnText),
                          //   ),
                          // )

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
                      )
                    : Container(
                        // color: BaseColor.loader_bg_color,
                        child: GlobalView().loaderView(),
                      );
              })),
    );
  }

  Widget businessNameView(
          BuildContext context, BusinessListProvider provider) =>
      Visibility(
        visible: true,
        child: Column(
          children: [
            GlobalView().sizedBoxView(35),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       GlobalView().textViewWithStartAlign(
            //           AppMessages.title_location,
            //           AppTextStyle.inter_font_family,
            //           AppTextStyle.bold_font_weight,
            //           BaseColor.black_color,
            //           16),
            //       GestureDetector(
            //         onTap: () {
            //           Navigator.pushNamed(context,
            //               AppRoutes.select_location_for_add_new_checkin_route_name);
            //         },
            //         child: GlobalView().textViewWithStartAlign(
            //             "Change",
            //             AppTextStyle.inter_font_family,
            //             AppTextStyle.medium_font_weight,
            //             BaseColor.forgot_pass_txt_color,
            //             12),
            //       )
            //     ],
            //   ),
            // ),
            // GlobalView().sizedBoxView(10),
            // Container(
            //     // color: Colors.red,
            //     height: 120,
            //     child: GoogleMap(
            //       myLocationEnabled: true,
            //       initialCameraPosition: _cameraPosition,
            //       onMapCreated: (GoogleMapController controller) {
            //         _controller = (controller);
            //         _controller.animateCamera(
            //             CameraUpdate.newCameraPosition(_cameraPosition));
            //         // _markers.add(Marker(
            //         //     markerId: MarkerId("a"),
            //         //     draggable: true,
            //         //     position: latlong,
            //         //     icon: pinLocationIcon,
            //         //     onDragEnd: (_currentlatLng) {
            //         //       latlong = _currentlatLng;
            //         //     }));
            //       },
            //       // markers: _markers,
            //     )),
            // GlobalView().sizedBoxView(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.centerLeft,
                child: GlobalView().textViewWithCenterAlign(
                    AppMessages.title_business_name,
                    AppTextStyle.inter_font_family,
                    AppTextStyle.normal_font_weight,
                    BaseColor.black_color.withOpacity(0.5),
                    11),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GlobalView().textFieldViewReadOnly(
                  AppImages.ic_business,
                  businessNameTextEditingController,
                  AppMessages.hint_business_name,
                  AppTextStyle.start_text_align),
            ),
            GlobalView().sizedBoxView(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.centerLeft,
                child: GlobalView().textViewWithCenterAlign(
                    AppMessages.title_category,
                    AppTextStyle.inter_font_family,
                    AppTextStyle.normal_font_weight,
                    BaseColor.black_color.withOpacity(0.5),
                    11),
              ),
            ),
            categoryView(provider),
          ],
        ),
      );

  Widget categoryView(BusinessListProvider provider) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Material(
          shadowColor: BaseColor.shadow_color,
          elevation: 4,
          borderRadius: BorderRadius.circular(25),
          child: Container(
            // height: 50,
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
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: GlobalView().textViewWithStartAlign(
                        provider.verifiedUserResponse != null &&
                                provider.verifiedUserResponse.categories != null
                            ? CategoryUtils().getCategoryName(
                                provider.verifiedUserResponse.categories!)
                            : "Cafe",
                        AppTextStyle.inter_font_family,
                        AppTextStyle.normal_font_weight,
                        BaseColor.hint_color,
                        14),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget textFieldViewForSelectLocation(
          String image,
          TextEditingController controller,
          String hintText,
          TextAlign textAlign,
          BuildContext context) =>
      Column(
        children: [
          GlobalView().sizedBoxView(20),
          Container(
            // padding: EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.centerLeft,
            child: GlobalView().textViewWithStartAlign(
                AppMessages.title_location,
                AppTextStyle.inter_font_family,
                AppTextStyle.normal_font_weight,
                BaseColor.black_color.withOpacity(0.5),
                11),
          ),
          GlobalView().sizedBoxView(5),
          Material(
            shadowColor: BaseColor.shadow_color,
            elevation: 4,
            borderRadius: BorderRadius.circular(25),
            child: GestureDetector(
              onTap: () {
                // print("selectLocationForAddNewCheckInRouteName called");
                Navigator.pushNamed(context,
                    AppRoutes.select_location_for_add_new_checkin_route_name);
              },
              child: new TextField(
                enabled: false,
                // focusNode: _focus,
                controller: controller,
                cursorColor: BaseColor.border_txtfield_color,
                readOnly: true,
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
                  suffixIcon: Padding(
                      padding: EdgeInsets.only(
                          left: 0, right: 10, top: 5, bottom: 5),
                      child: Container(
                          padding: EdgeInsets.all(5),
                          width: 18,
                          height: 15,
                          child: Image.asset(
                            AppImages.ic_next,
                          ))),
                  //  prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide:
                        BorderSide(color: BaseColor.border_txtfield_color),
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
          ),
        ],
      );
}
