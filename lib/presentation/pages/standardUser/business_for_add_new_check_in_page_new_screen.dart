import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/data/models/business_list_response.dart';
import 'package:trendoapp/data/models/category_response.dart';
import 'package:trendoapp/data/models/profile_response.dart';
import 'package:trendoapp/data/models/search_by_business_response.dart';
import 'package:trendoapp/data/models/verified_user_response.dart';
import 'package:trendoapp/global/view/common_gradient_button.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/show_alert_view.dart';
import 'package:trendoapp/presentation/screens/businessUser/category_selection_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/friendsTabs/add_new_check_support_screen.dart';
import 'package:trendoapp/providers/business_list_provider.dart';
import 'package:trendoapp/providers/categories_list_provider.dart';
import 'package:trendoapp/providers/filter_provider.dart';
import 'package:trendoapp/providers/search_by_business_provider.dart';
import 'package:trendoapp/utils/preference_utils.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class BusinessForAddNewCheckInPage extends StatefulWidget {
  String? route;
  BusinessForAddNewCheckInPage({this.route});
  @override
  _BusinessForAddNewCheckInPageState createState() => _BusinessForAddNewCheckInPageState();
}

class _BusinessForAddNewCheckInPageState extends State<BusinessForAddNewCheckInPage> {
  TextEditingController searchLocationTextEditingController = new TextEditingController();
  TextEditingController businessNameTextEditingController = new TextEditingController();
  List<String> listLocation = [];
  ScrollController scrollController = new ScrollController();
  ProfileResponse? profileResponse;
  // VerifiedUserResponse verifiedUserResponse = new VerifiedUserResponse();
  String? distanceRadius = "5";
  int selectedFilterValue = 0;
  // FilterProvider? filterProvider;
  SearchByBusinessResponse? searchByBusinessResponse;
  List<VerifiedUserResponse> listBusiness = [];
  BusinessListResponse? businessListResponse;
  bool isChecked = false;
  String businessNames = '';
  String categoriesName = '';
  String businessLatitude = '';
  String businessLongitude = '';
  String businessLocationName = '';
  int businessId = 0;
  int categoriesId = 0;

  @override
  void initState() {
    print("========++++++++++++++");
    super.initState();
    String model = PreferenceUtils.getObject(PreferenceUtils.keyStandardUserProfileObject);
    // log("Prefs model data--==> $model");
    profileResponse = ProfileResponse.fromJson(json.decode(model));
    // print("RADIUS-> ${Provider.of<FilterProvider>(context, listen: false).distanceRadius}");
    var businessListProvider = Provider.of<BusinessListProvider>(context, listen: false);
    businessListProvider.businessListResponse = null;
    newApplySearchDataForDistance(context, '5');
    businessListProvider.newGetBusinessList(
      context,
      StorageUtils.readStringValue(StorageUtils.keyLatitude),
      StorageUtils.readStringValue(StorageUtils.keyLongitude),
      "0.02",
      // Provider.of<FilterProvider>(context, listen: false).distanceRadius,
      // "100000000000000000000",
    );
    //Change By Vimesh
    // selectedFilterValue = widget.route == "search" ? 0 : 1;
    // Future.delayed(Duration.zero, () {
    //   Provider.of<FilterProvider>(context, listen: false).changeSegmentValue(route: AppMessages.city_text);
    //   Provider.of<FilterProvider>(context, listen: false).setDistanceRadius(distanceRadius);
    // });
    // print("RADIUS==-> ${Provider.of<FilterProvider>(context, listen: false).distanceRadius}");
    // businessListProvider.isChecked = false;
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
    //     if (businessListProvider.businessListResponse!.business!.currentPage! < businessListProvider.businessListResponse!.business!.lastPage!) {
    //       businessListProvider.getBusinessList(
    //         context,
    //         StorageUtils.readStringValue(StorageUtils.keyLatitude),
    //         StorageUtils.readStringValue(StorageUtils.keyLongitude),
    //         Provider.of<FilterProvider>(context, listen: false).distanceRadius,
    //       );
    //     } else {
    //       // GlobalView().showToast(AppMessages.no_more_data_text);
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Consumer<FilterProvider>(builder: (context, provider, child) {
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
                Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GlobalView().sizedBoxView(DeviceSize().deviceHeight(context) * 0.052),
                              Container(
                                alignment: Alignment.topCenter,
                                child: GlobalView().textViewWithCenterAlign(
                                  AppMessages.which_business_are_you_at,
                                  AppTextStyle.inter_font_family,
                                  AppTextStyle.bold_font_weight,
                                  BaseColor.black_color,
                                  18,
                                ),
                              ),
                              GlobalView().sizedBoxView(DeviceSize().deviceHeight(context) * 0.02),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    height: DeviceSize().deviceHeight(context) - 300,
                                    child: newLocationsList(context),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5, right: 5, bottom: DeviceSize().deviceHeight(context) * 0.01, top: DeviceSize().deviceHeight(context) * 0.02),
                                child: listBusiness.isNotEmpty
                                    ? isChecked
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => AddNewCheckSupportScreen(
                                                    businessName: businessNames,
                                                    categoriesName: categoriesName,
                                                    businessLatitude: businessLatitude,
                                                    businessLongitude: businessLongitude,
                                                    businessLocationName: businessLocationName,
                                                    businessId: businessId,
                                                    categoriesId: categoriesId,
                                                    isScreenChange: false,
                                                  ),
                                                ),
                                              );
                                              setState(() {});
                                            },
                                            child: GlobalView().buttonFilled(context, AppMessages.next_text),
                                          )
                                        : GlobalView().buttonFilledDisabled(context, AppMessages.next_text)
                                    : Container(),
                              ),
                              // GlobalView().sizedBoxView(
                              //     DeviceSize().deviceHeight(context) * 0.02),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //               CommonGradientButton(
                    //                   onPressed: () {
                    //                     // businessOpenFilterBottomSheet(
                    //                     //   context: context,
                    //                     //   distanceRadius: distanceRadius,
                    //                     //   filterProvider: provider,
                    //                     //   route: "search", //widget.route,
                    //                     //   selectedFilterValue: selectedFilterValue == "search" ? 0 : 1,
                    //                     // );
                    // print("____________++++++++++++==$selectedFilterValue");

                    //                     openFilterBottomSheet(
                    //                       context: context,
                    //                       distanceRadius: distanceRadius,
                    //                       filterProvider: provider,
                    //                       route: "search", //widget.route,
                    //                       selectedFilterValue: selectedFilterValue ,
                    //                     );

                    //                     // Navigator.push(
                    //                     //     context,
                    //                     //     MaterialPageRoute(
                    //                     //         builder: (_) => OnlineBusinessCheckInScreen()));
                    //                   },
                    //                   title: AppMessages.do_not_see_your_location),

                    GlobalView().sizedBoxView(5),
                    Visibility(
                      visible: profileResponse != null && profileResponse!.user != null && profileResponse!.user!.isAdmin == 1 ? true : false,
                      child: Column(
                        children: [
                          GlobalView().dividerView(),
                          GlobalView().sizedBoxView(5),
                          CommonGradientButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CategorySelectionScreen(
                                              userType: 0,
                                            )));
                              },
                              title: AppMessages.add_unregistered_business_title),
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  child: Visibility(
                    visible: Provider.of<BusinessListProvider>(context).isLoading,
                    child: Container(
                      // color: BaseColor.loader_bg_color,
                      child: GlobalView().loaderView(),
                    ),
                  ),
                ),
                Positioned(
                  top: 57,
                  left: 21,
                  child: Container(
                    height: 25,
                    width: 25,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: GlobalView().assetImageView(AppImages.ic_back)),
                  ),
                ),
              ],
            ),
            // );
            // }
          ),
        );
      }),
    );
  }

  // Widget textfieldViewForSearchLocation(String image, TextEditingController controller, String hintText, TextAlign textAlign) => Material(
  //       shadowColor: BaseColor.shadow_color,
  //       elevation: 4,
  //       borderRadius: BorderRadius.circular(25),
  //       child: TextField(
  //         controller: controller,
  //         cursorColor: BaseColor.border_txtfield_color,
  //         style: TextStyle(
  //           color: BaseColor.hint_color,
  //           fontFamily: AppTextStyle.inter_font_family,
  //           fontSize: 14,
  //         ),
  //         textAlign: textAlign,
  //         decoration: InputDecoration(
  //           isDense: true,
  //           focusColor: BaseColor.pure_white_color,
  //           contentPadding: EdgeInsets.only(left: 60, right: -30),
  //           prefixIcon: Container(
  //             // height: 50,
  //             // width: 58,
  //             child: Padding(
  //               padding: EdgeInsets.only(top: 13, bottom: 13, left: 13, right: 13),
  //               child: Image.asset(
  //                 image,
  //                 height: 24,
  //                 width: 24,
  //               ),
  //             ),
  //           ),
  //           //  prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
  //           enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(25),
  //             borderSide: BorderSide(color: BaseColor.border_txtfield_color),
  //           ),
  //           disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
  //           border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
  //           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
  //           hintText: hintText,
  //           hintStyle: TextStyle(
  //             color: BaseColor.hint_color.withOpacity(0.6),
  //             fontFamily: AppTextStyle.inter_font_family,
  //             fontSize: 14,
  //           ),
  //         ),
  //       ),
  //     );

  Widget newLocationsList(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Consumer<BusinessListProvider>(
          builder: (_, provider, child) {
            print("isAvailableData -> ${provider.isAvailableData}");
            if (listBusiness.isNotEmpty) {
              return ListView.separated(
                separatorBuilder: ((context, index) {
                  return Divider(
                    color: Colors.black,
                  );
                }),
                shrinkWrap: true,
                itemCount: listBusiness.length,
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (_, index) => Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: GlobalView().textViewWithStartAlign(listBusiness[index].businessName!, AppTextStyle.inter_font_family, AppTextStyle.bold_font_weight, BaseColor.black_color, 18),
                          ),
                          Container(
                            child: GlobalView().textViewWithStartAlign(
                                listBusiness[index].isMobile == 1
                                    ? AppMessages.mobile_business_text
                                    : listBusiness[index].isOnline == 0
                                        ? listBusiness[index].businessAddress!
                                        : AppMessages.online_business_text,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.normal_font_weight,
                                BaseColor.black_color.withOpacity(0.5),
                                16),
                          ),
                          GlobalView().sizedBoxView(5),
                          GlobalView().textViewWithStartAlign(AppMessages.within + listBusiness[index].distance! + AppMessages.miles_from_text, AppTextStyle.inter_font_family,
                              AppTextStyle.semi_bold_font_weight, BaseColor.forgot_pass_txt_color, 12)
                        ],
                      ),
                    ),
                    // Text(listBusiness[index].isChecked.toString()),
                    // checkBoxView,
                    Container(
                      height: 25,
                      padding: EdgeInsets.zero,
                      child: Theme(
                        data: ThemeData(unselectedWidgetColor: BaseColor.btn_gradient_end_color1, backgroundColor: BaseColor.btn_gradient_end_color1),
                        child: Checkbox(
                            value: listBusiness[index].isChecked,
                            checkColor: BaseColor.pure_white_color,
                            activeColor: BaseColor.btn_gradient_end_color1,
                            onChanged: (bool? value) {
                              newChangeCheckBoxValue(listBusiness[index].id!, value!);
                              businessNames = listBusiness[index].businessName!;
                              categoriesName = newGetCategoryName(listBusiness[index].categories!);
                              businessLatitude = listBusiness[index].latitude!;
                              businessLongitude = listBusiness[index].longitude!;
                              businessLocationName = listBusiness[index].locationName ?? '';
                              businessId = listBusiness[index].id!;
                              categoriesId = newGetCategoryId(listBusiness[index].categories!);
                              print("_+_+_+_+_++++__+_+____${listBusiness[index].businessName!}");
                              print("_+_+_+_+_++++__+_+____${newGetCategoryName(listBusiness[index].categories!)}");
                              print("_+_+_+_+_++++__+_+____${listBusiness[index].latitude!}");
                              print("_+_+_+_+_++++__+_+____${listBusiness[index].longitude!}");
                              print("_+_+_+_+_++++__+_+____${listBusiness[index].locationName}");
                              print("_+_+_+_+_++++__+_+____${listBusiness[index].id!}");
                              print("_+_+_+_+_++++__+_+____${newGetCategoryId(listBusiness[index].categories!)}");
                            }),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Visibility(
                visible: !provider.isAvailableData,
                child: Container(
                  child: Center(
                    child: GlobalView().textViewWithCenterAlign(
                      AppMessages.no_nearby_locations_available_text,
                      AppTextStyle.inter_font_family,
                      AppTextStyle.semi_bold_font_weight,
                      BaseColor.black_color,
                      18,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void newGetSearchByBusinessList(
    BuildContext context,
    int page,
    String searchValue,
    String categoryId,
    String latitude,
    String longitude,
    String? distance,
    String? cityName,
  ) {
    ApiManager(context)
        .getSearchByBusinessList(
      page.toString(),
      searchValue,
      categoryId,
      latitude,
      longitude,
      distance,
      cityName,
    )
        .then((response) {
      print('*- ${response.place!.currentPage}');
      print('*-*- ${response.place!.data}');
      print('*-*-*- ${response.place!.lastPage}');
      print('*-*-*-* ${response.place!.firstPageUrl}');
      print('*-*-*-*- ${response.place!.lastPageUrl}');
      searchByBusinessResponse = response;
      print('*- ${searchByBusinessResponse!.place!.currentPage}');
      print('*-*- ${searchByBusinessResponse!.place!.data}');
      print('*-*-*- ${searchByBusinessResponse!.place!.lastPage}');
      print('*-*-*-* ${searchByBusinessResponse!.place!.firstPageUrl}');
      print('*-*-*-*- ${searchByBusinessResponse!.place!.lastPageUrl}');
      if (searchByBusinessResponse!.statuscode == 200) {
        if (searchByBusinessResponse != null && searchByBusinessResponse!.place != null && searchByBusinessResponse!.place!.data != null) {
          if (searchByBusinessResponse!.place!.data!.isNotEmpty) {
            if (page == 1) {
              listBusiness.clear();
              listBusiness.addAll(searchByBusinessResponse!.place!.data!);
            } else {
              listBusiness.addAll(searchByBusinessResponse!.place!.data!);
            }
          }
          setState(() {});
          print("searchByBusinessResponse-> ${searchByBusinessResponse!.place!.data!.length}");
        }
      }
    }).catchError((onError) {
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                newGetSearchByBusinessList(context, page, searchValue, categoryId, latitude, longitude, distance, cityName);
              },
              exception: onError)
          .showAlertDialog();
    });
  }

  void newApplySearchDataForDistance(BuildContext context, String? distanceRadius) async {
    print("Distance Radius-->> ${Provider.of<FilterProvider>(context, listen: false).distanceRadius}");
    print("Selected Metropolitan City-->> ${Provider.of<FilterProvider>(context, listen: false).selectedMetropolitanCityInfo}");

    Provider.of<SearchByBusinessProvider>(context, listen: false).listBusiness.clear();
    newGetSearchByBusinessList(
      context,
      1,
      Provider.of<FilterProvider>(context, listen: false).searchValue,
      Provider.of<CategoriesListProvider>(context, listen: false).selectedCategoryResponse!.id.toString(),
      StorageUtils.readStringValue(StorageUtils.keyLatitude),
      StorageUtils.readStringValue(StorageUtils.keyLongitude),
      Provider.of<FilterProvider>(context, listen: false).distanceRadius,
      Provider.of<FilterProvider>(context, listen: false).selectedMetropolitanCityInfo,
    );
  }

  void newChangeCheckBoxValue(int index, bool value) {
    print(listBusiness.length);
    // listBusiness.indexWhere((element) {
    //   setState(() {});
    //   return (element.id == index) ? element.isChecked = !element.isChecked! : element.isChecked = false;
    // });
    for (var i = 0; i < listBusiness.length; i++) {
      if (listBusiness[i].id == index) {
        listBusiness[i].isChecked = value;
      } else {
        listBusiness[i].isChecked = false;
      }
    }
    isCheck();
  }

  isCheck() {
    for (var i = 0; i < listBusiness.length; i++) {
      if (listBusiness[i].isChecked == true) {
        isChecked = true;
        setState(() {});
      }
    }
  }

  String categoryName = "";
  String newGetCategoryName(List<CategoryResponse> listCategory) {
    for (var i = 0; i < listCategory.length; i++) {
      categoryName = categoryName + listCategory[i].name!;
      if (i != listCategory.length - 1) {
        categoryName = categoryName + " and ";
      }
    }
    return categoryName;
  }

  int categoryId = 0;
  int newGetCategoryId(List<CategoryResponse> listCategory) {
    for (var i = 0; i < listCategory.length; i++) {
      categoryId = listCategory[i].id!;
    }
    return categoryId;
  }

  //   String businessName = '';
  // String getbusinessName(List<VerifiedUserResponse> listBusiness) {
  //   for (var i = 0; i < listBusiness.length; i++) {
  //     businessName =  listBusiness[i].businessName!;
  //   }
  //   return businessName;
  // }

}

//business address
//business name

class BusinessForAddNewCheckInPageScreen extends StatelessWidget {
  String? route;
  BusinessForAddNewCheckInPageScreen({this.route});
  @override
  Widget build(BuildContext context) {
    return GlobalView().safeAreaView(BusinessForAddNewCheckInPage());
  }
}
