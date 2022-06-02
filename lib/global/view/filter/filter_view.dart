import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/data/global/home_list_data.dart';
import 'package:trendoapp/data/global/search_list_data.dart';
import 'package:trendoapp/global/view/category_view.dart';
import 'package:trendoapp/global/view/filter/city_filter_view.dart';
import 'package:trendoapp/global/view/filter/distance_filter_view.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/business_user_provider.dart';
import 'package:trendoapp/providers/categories_list_provider.dart';
import 'package:trendoapp/providers/filter_provider.dart';
import 'package:trendoapp/providers/home_feed_response_provider.dart';

// ignore: must_be_immutable
class FilterView extends StatefulWidget {
  // const FilterView({Key key}) : super(key: key);
  String route;

  FilterView(this.route);

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  double value = 40;
  int selectedRadiusValue = 1;
  String distanceRadius = "5";
  AutoCompleteTextField searchCityTextField;
  GlobalKey<AutoCompleteTextFieldState<String>> keyCity = new GlobalKey();
  TextEditingController cityTextEditingController = new TextEditingController();
  int selectedFilterValue = 0;
  String filterText = AppMessages.by_city_text;
  FilterProvider filterProvider;
  // TextEditingController citySearchController = TextEditingController();
  final Map<int, Widget> myTabs = <int, Widget>{
    0: GlobalView().textViewWithCenterAlign(
      "1",
      AppTextStyle.inter_font_family,
      AppTextStyle.medium_font_weight,
      BaseColor.black_color,
      14,
    ),
    1: GlobalView().textViewWithCenterAlign(
      "5",
      AppTextStyle.inter_font_family,
      AppTextStyle.medium_font_weight,
      BaseColor.black_color,
      14,
    ),
    // 2: GlobalView().textViewWithCenterAlign(
    //     "20",
    //     AppTextStyle.inter_font_family,
    //     AppTextStyle.medium_font_weight,
    //     BaseColor.black_color,
    //     14),
    // 3: GlobalView().textViewWithCenterAlign(
    //     "30",
    //     AppTextStyle.inter_font_family,
    //     AppTextStyle.medium_font_weight,
    //     BaseColor.black_color,
    //     14),
    // 4: GlobalView().textViewWithCenterAlign(
    //     "50",
    //     AppTextStyle.inter_font_family,
    //     AppTextStyle.medium_font_weight,
    //     BaseColor.black_color,
    //     14),
    // 5: GlobalView().textViewWithCenterAlign(
    //     "70",
    //     AppTextStyle.inter_font_family,
    //     AppTextStyle.medium_font_weight,
    //     BaseColor.black_color,
    //     14),
  };
  final Map<int, Widget> myFilterTabs = <int, Widget>{
    0: GlobalView().textViewWithCenterAlign(
      AppMessages.by_city_text,
      AppTextStyle.inter_font_family,
      AppTextStyle.medium_font_weight,
      BaseColor.grey_color,
      14,
    ),
    1: GlobalView().textViewWithCenterAlign(
      AppMessages.by_distance_text,
      AppTextStyle.inter_font_family,
      AppTextStyle.medium_font_weight,
      BaseColor.grey_color,
      14,
    ),
  };
  Map<int, Widget> listTabs = new Map();
  List<int> list = [1, 2, 3, 4, 5];
  // FilterModel filterModel;
  @override
  void initState() {
    super.initState();
    selectedFilterValue = widget.route == "search" ? 0 : 1;
    print("distanceRadius=-=> $distanceRadius");
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .homeFeedResponse = null;

    Future.delayed(Duration.zero, () {
      Provider.of<FilterProvider>(context, listen: false)
          .changeSegmentValue(route: AppMessages.city_text);
      Provider.of<FilterProvider>(context, listen: false)
          .setDistanceRadius(distanceRadius);
    });
    // filterModel =
    //     Provider.of<FilterProvider>(context, listen: false).filterModel;
  }

  @override
  Widget build(BuildContext context) {
    filterProvider = Provider.of<FilterProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (BuildContext context,
                void Function(void Function()) setState) {
              return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                          // height: ScreenSize().screenHeight(context) - 600,
                          decoration: BoxDecoration(
                            color: BaseColor.pure_white_color,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  titleView(context),
                                  GlobalView().sizedBoxView(10),
                                  CategoryView(widget.route),
                                  GlobalView().sizedBoxView(20),
                                  widget.route == "search"
                                      ? Container(
                                          padding: EdgeInsets.all(2),
                                          width:
                                              DeviceSize().deviceWidth(context),
                                          decoration: BoxDecoration(
                                            color: BaseColor.grey_color,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            // border: Border.all(color: BaseColor.grey_color),
                                          ),
                                          child:
                                              CupertinoSlidingSegmentedControl(
                                            padding: EdgeInsets.all(0),
                                            groupValue: selectedFilterValue,
                                            children: {
                                              0: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: GlobalView()
                                                    .textViewWithCenterAlign(
                                                  AppMessages.by_city_text,
                                                  AppTextStyle
                                                      .inter_font_family,
                                                  AppTextStyle
                                                      .semi_bold_font_weight,
                                                  selectedFilterValue == 0
                                                      ? BaseColor
                                                          .pure_white_color
                                                      : BaseColor.grey_color,
                                                  16,
                                                ),
                                              ),
                                              1: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: GlobalView()
                                                    .textViewWithCenterAlign(
                                                  AppMessages.by_distance_text,
                                                  AppTextStyle
                                                      .inter_font_family,
                                                  AppTextStyle
                                                      .semi_bold_font_weight,
                                                  selectedFilterValue == 1
                                                      ? BaseColor
                                                          .pure_white_color
                                                      : BaseColor.grey_color,
                                                  16,
                                                ),
                                              ),
                                            },
                                            backgroundColor:
                                                BaseColor.pure_white_color,
                                            thumbColor:
                                                BaseColor.forgot_pass_txt_color,
                                            onValueChanged: (i) {
                                              setState(
                                                () {
                                                  selectedFilterValue = i;
                                                  // print("Value-> ${myTabs[i]}");
                                                  Text list = myFilterTabs[i];
                                                  distanceRadius = list.data;
                                                  // print("Distance Radius-> $distanceRadius");
                                                  // Provider.of<FilterProvider>(context,
                                                  //         listen: false)
                                                  //     .setDistanceRadius(distanceRadius);
                                                  Provider.of<FilterProvider>(
                                                          context,
                                                          listen: false)
                                                      .changeSegmentValue(
                                                          route: i == 0
                                                              ? AppMessages
                                                                  .city_text
                                                              : AppMessages
                                                                  .radius_text);
                                                },
                                              );
                                            },
                                          ),
                                        )
                                      : Container(),
                                  // categoriesView(),
                                  GlobalView().sizedBoxView(20),
                                  selectedFilterValue == 0
                                      ? CityFilterView(
                                          filterProvider: filterProvider,
                                          // citySearchController:
                                          //     citySearchController,
                                        )
                                      : DistanceFilterView(),
                                  // cityAutoCompleteTextFieldView(),
                                  // cityTextFieldView(),
                                  // GlobalView().sizedBoxView(20),
                                  // distanceRadiusView(setState, context),
                                  GlobalView().sizedBoxView(25),
                                  resetApplyView(context),
                                  GlobalView().sizedBoxView(20),
                                ],
                              ),
                            ),
                          ))));
            });
          },
        );
      },
      child: Container(
        // height: 40,
        // width: 40,
        // child: Image.asset(
        //   AppImages.ic_sort,
        //   height: 40,
        //   width: 40,
        // ),
        // color: Colors.red,
        child: widget.route.toLowerCase() == "search"
            ? Container(
                child: Container(
                padding: EdgeInsets.only(
                  top: 1,
                  bottom: 1,
                  left: 16,
                  right: 6,
                ),
                decoration: BoxDecoration(
                    color: BaseColor.pure_white_color,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: BaseColor.black_color.withOpacity(0.1),
                        blurRadius: 6,
                        offset: Offset(3, 6),
                        // spreadRadius:6,
                      ),
                    ]),
                child: Row(
                  children: [
                    GlobalView().textViewWithCenterAlign(
                        AppMessages.filter_text,
                        AppTextStyle.inter_font_family,
                        AppTextStyle.bold_font_weight,
                        BaseColor.black_color,
                        16),
                    Container(
                      // height: 40,
                      // width: 40,
                      child: Image.asset(
                        AppImages.ic_filter,
                        height: 35,
                        width: 35,
                      ),
                    )
                  ],
                ),
              ))
            : GlobalView()
                .wrappedButtonFilledView(context, AppMessages.near_me_text),
      ),
    );
  }

  void onClickApplyButton() {
    print("Apply Clicked");

    if (widget.route.toLowerCase() == "search") {
      if (Provider.of<BusinessUserProvider>(context, listen: false)
          .isCitySelected) {
        selectedRadiusValue = 0;
        filterProvider.setDistanceRadius('0');
      } else {
        filterProvider.citySearchController.text = "";
        filterProvider.setCityValue("");
      }
    }

    // else {
    //   Provider.of<FilterProvider>(context, listen: false)
    //       .setDistanceRadius(distanceRadius);
    // }
    filterProvider.setCityValue(cityTextEditingController.text);
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .homeFeedResponse = null;
    print(Provider.of<BusinessUserProvider>(context, listen: false)
        .isCitySelected);
    print("City-> ${filterProvider.selectedMetropolitanCityInfo}");

    if (widget.route.toLowerCase() == "home") {
      HomeListData().applyHomeData(context);
      Navigator.pop(context);
    } else if (widget.route.toLowerCase() == "search") {
      print(
          "IS CITY SELECTED ${Provider.of<BusinessUserProvider>(context, listen: false).isCitySelected}");
      if (Provider.of<BusinessUserProvider>(context, listen: false)
              .isCitySelected &&
          // filterProvider.citySearchController.text == "" &&
          filterProvider.selectedMetropolitanCityInfo == "") {
        print("Toast called");
        GlobalView().showToast(AppToastMessages.enter_city_for_filter_message);
      } else {
        SearchListData().applySearchDataForDistance(context, distanceRadius);
        Navigator.pop(context);
      }
      // SearchListData().applySearchDataForDistance(context, distanceRadius);
      // Navigator.pop(context);
    }

    // Provider.of<FilterProvider>(context, listen: false)
    //     .selectedMetropolitanCityInfo = "";
    //     citySearchController.text = "";
  }

  void onClickResetButton() {
    cityTextEditingController.text = "";
    filterProvider.setCityValue(cityTextEditingController.text);
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .homeFeedResponse = null;
    filterProvider.setDistanceRadius("5");
    if (widget.route.toLowerCase() == "home") {
      HomeListData().resetHomeData(context);
    } else if (widget.route.toLowerCase() == "search") {
      SearchListData().resetSearchDataForDistance(context);
    }

    Navigator.pop(context);
    Provider.of<FilterProvider>(context, listen: false)
        .selectedMetropolitanCityInfo = "";
    filterProvider.citySearchController.text = "";
  }

  Widget titleView(BuildContext context) => Row(
        children: [
          Expanded(
            child: GlobalView().textViewWithStartAlign(
                AppMessages.filter_text,
                AppTextStyle.inter_font_family,
                AppTextStyle.semi_bold_font_weight,
                BaseColor.black_color,
                18),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              size: 20,
            ),
          ),
        ],
      );
  Widget resetApplyView(BuildContext context) => Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                print("Reset Clicked");
                setState(() {
                  selectedRadiusValue = 1;
                });
                onClickResetButton();
              },
              child:
                  GlobalView().buttonFilled2(context, AppMessages.reset_text),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: GestureDetector(
                onTap: () {
                  onClickApplyButton();
                },
                child:
                    GlobalView().buttonFilled(context, AppMessages.apply_text)),
          ),
        ],
      );
  Widget categoriesView() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalView().textViewWithStartAlign(
              AppMessages.categories_text,
              AppTextStyle.inter_font_family,
              AppTextStyle.medium_font_weight,
              BaseColor.black_color,
              16),
          Consumer<CategoriesListProvider>(builder: (_, provider, child) {
            return Container(
              // color: Colors.red,
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ...provider.listCategoriesForHome
                      .map(
                        (item) => CheckboxListTile(
                          value: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          title: GlobalView().textViewWithStartAlign(
                              item.name,
                              AppTextStyle.inter_font_family,
                              AppTextStyle.medium_font_weight,
                              BaseColor.black_color,
                              16),
                          checkColor: BaseColor.pure_white_color,
                          activeColor: BaseColor.forgot_pass_txt_color,
                          onChanged: (v) {},
                        ),
                      )
                      .toList()
                ],
              ),
            );
          })
        ],
      );
  Widget cityTextFieldView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        GlobalView().textViewWithStartAlign(
            AppMessages.search_by_city_title,
            AppTextStyle.inter_font_family,
            AppTextStyle.medium_font_weight,
            BaseColor.black_color,
            16),
        GlobalView().sizedBoxView(10),
        Consumer<BusinessUserProvider>(builder: (ctx, businessProvider, child) {
          print("list City length->> ${businessProvider.listCities}");
          return Row(
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
                    value: businessProvider.isCitySelected,
                    checkColor: BaseColor.pure_white_color,
                    activeColor: BaseColor.btn_gradient_end_color1,
                    onChanged: (bool value) {
                      if (Provider.of<BusinessUserProvider>(context,
                              listen: false)
                          .isDistanceRadiusSelected) {}
                      cityTextEditingController.text = "";
                      businessProvider.changeFilterCheckBoxValue(
                          route: AppMessages.city_text, value: value);
                    },
                  ),
                ),
              ),
              Expanded(
                child: AbsorbPointer(
                  absorbing:
                      Provider.of<BusinessUserProvider>(context, listen: false)
                              .isCitySelected
                          ? false
                          : true,
                  child: GlobalView().textFieldView(
                      AppImages.ic_location,
                      cityTextEditingController,
                      AppMessages.hint_city_name,
                      AppTextStyle.start_text_align),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget distanceRadiusView(setState, context) =>
      Consumer<BusinessUserProvider>(builder: (_, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlobalView().textViewWithStartAlign(
                AppMessages.distance_radius_text,
                AppTextStyle.inter_font_family,
                AppTextStyle.medium_font_weight,
                BaseColor.black_color,
                16),
            GlobalView().sizedBoxView(10),
            Row(
              children: [
                Container(
                  height: 25,
                  padding: EdgeInsets.zero,
                  // color: Colors.green,
                  child: Theme(
                    data: ThemeData(
                        unselectedWidgetColor:
                            BaseColor.btn_gradient_end_color1,
                        backgroundColor: BaseColor.btn_gradient_end_color1),
                    child: Checkbox(
                        value: Provider.of<BusinessUserProvider>(context,
                                listen: false)
                            .isDistanceRadiusSelected,
                        checkColor: BaseColor.pure_white_color,
                        activeColor: BaseColor.btn_gradient_end_color1,
                        onChanged: (bool value) {
                          if (Provider.of<BusinessUserProvider>(context,
                                  listen: false)
                              .isDistanceRadiusSelected) {}
                          cityTextEditingController.text = "";
                          // provider.changeSegmentValue(
                          //     route: AppMessages.radius_text);
                        }),
                  ),
                ),
                Expanded(
                  child: Container(
                    // color: Colors.green,
                    padding: EdgeInsets.zero,
                    // width: ScreenSize().screenWidth(context)-25,
                    child: SliderTheme(
                      data: SliderThemeData(
                        trackShape: CustomTrackShape(),
                      ),
                      child:
                          // SfSlider(
                          //   min: 0.0,
                          //   max: 100.0,
                          //   value: _value,
                          //   interval: 20,
                          //   showTicks: false,
                          //   showLabels: false,
                          //   enableTooltip: false,
                          //   minorTicksPerInterval: 1,
                          //   activeColor: BaseColor.forgot_pass_txt_color,
                          //   inactiveColor: BaseColor.unselected_tab_color,
                          //   onChanged: (dynamic value) {
                          //     setState(() {
                          //       _value = value;
                          //     });
                          //   },
                          // ),
                          //     Slider(
                          //   min: 0,
                          //   max: 100,
                          //   value: _value,
                          //   activeColor: BaseColor.forgot_pass_txt_color,
                          //   inactiveColor: BaseColor.unselected_tab_color,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       _value = value;
                          //     });
                          //   },
                          // ),
                          Container(
                        width: DeviceSize().deviceWidth(context) - 50,
                        child: CupertinoSlidingSegmentedControl(
                          groupValue: selectedRadiusValue,
                          children: myTabs,
                          // backgroundColor: BaseColor.btn_gradient_start_color2,
                          // thumbColor: BaseColor.btn_gradient_end_color1,
                          onValueChanged: (i) {
                            setState(
                              () {
                                selectedRadiusValue = i;
                                // print("Value-> ${myTabs[i]}");
                                Text list = myTabs[i];
                                distanceRadius = list.data;
                                print("Distance Radius-> $distanceRadius");
                                Provider.of<FilterProvider>(context,
                                        listen: false)
                                    .setDistanceRadius(distanceRadius);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      });

  Widget citiesView(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          GlobalView().textViewWithStartAlign(
              AppMessages.city_text,
              AppTextStyle.inter_font_family,
              AppTextStyle.medium_font_weight,
              BaseColor.black_color,
              16),
          Consumer<CategoriesListProvider>(builder: (_, provider, child) {
            return Container(
              // color: Colors.red,
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ...provider.listCategoriesForHome
                      .map(
                        (item) => CheckboxListTile(
                          value: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          title: GlobalView().textViewWithStartAlign(
                              item.name,
                              AppTextStyle.inter_font_family,
                              AppTextStyle.medium_font_weight,
                              BaseColor.black_color,
                              16),
                          checkColor: BaseColor.pure_white_color,
                          activeColor: BaseColor.forgot_pass_txt_color,
                          onChanged: (v) {},
                        ),
                      )
                      .toList()
                ],
              ),
            );
          })
        ],

        // ListView.builder(
        //     itemCount: provider.listCategoriesForHome.length,
        //     shrinkWrap: true,
        //     physics: AlwaysScrollableScrollPhysics(),
        //     itemBuilder: (BuildContext context, int index) {
        //       return new Card(
        //         child: new Container(
        //           padding: new EdgeInsets.all(10.0),
        //           child: Column(
        //             children: <Widget>[
        //               new CheckboxListTile(
        //                 controlAffinity: ListTileControlAffinity.leading,
        //                   activeColor: Colors.pink[300],
        //                   dense: true,
        //                   //font change
        //                   title: new Text(
        //                     provider.listCategoriesForHome[index].name,
        //                     style: TextStyle(
        //                         fontSize: 14,
        //                         fontWeight: FontWeight.w600,
        //                         letterSpacing: 0.5),
        //                   ),
        //                   // value: provider.listCategoriesForHome[index].isCheck,
        //                   value: true,
        //                   // secondary: Container(
        //                   //   height: 50,
        //                   //   width: 50,
        //                   //   child: Image.asset(
        //                   //     checkBoxListTileModel[index].img,
        //                   //     fit: BoxFit.cover,
        //                   //   ),
        //                   // ),
        //                   onChanged: (bool val) {
        //                     // itemChange(val, index);
        //                   })
        //             ],
        //           ),
        //         ),
        //       );
        //     });

        // CheckboxGroup(
        //       labels: [
        //         for (var i = 0; i < provider.listCategoriesForHome.length; i++)
        //           provider.listCategoriesForHome[i].name
        //       ].map((String value) => value).toList(),
        //       orientation: GroupedButtonsOrientation.VERTICAL,
        //     );
      );
  // Widget cityAutoCompleteTextFieldView() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisSize: MainAxisSize.max,
  //     children: [
  //       GlobalView().textViewWithStartAlign(
  //           AppMessages.search_city_title,
  //           AppTextStyle.inter_font_family,
  //           AppTextStyle.normal_font_weight,
  //           BaseColor.forgot_pass_txt_color,
  //           18),
  //       GlobalView().sizedBoxView(10),
  //       Consumer<BusinessUserProvider>(builder: (ctx, businessProvider, child) {
  //         print("list City length->> ${businessProvider.listCities}");
  //         return Theme(
  //           data: ThemeData(
  //             textSelectionTheme: TextSelectionThemeData(
  //               cursorColor: BaseColor.border_txtfield_color,
  //             ),
  //           ),
  //           child: Material(
  //             shadowColor: BaseColor.shadow_color,
  //             elevation: 4,
  //             borderRadius: BorderRadius.circular(25),
  //             child: searchCityTextField =
  //                 AutoCompleteTextField<MetropolitanCityInfo>(
  //               key: keyCity,
  //               // controller: searchCityTextField,
  //               style: TextStyle(
  //                 color: BaseColor.hint_color,
  //                 fontFamily: AppTextStyle.inter_font_family,
  //                 fontSize: 14,
  //               ),
  //               clearOnSubmit: false,
  //               decoration: InputDecoration(
  //                 isDense: true,
  //                 // filled: true,
  //                 focusColor: BaseColor.pure_white_color,
  //                 contentPadding: EdgeInsets.only(left: 60, right: -40),
  //                 prefixIcon:
  //                     GlobalView().prefixIconView(AppImages.ic_location),
  //                 enabledBorder: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(25),
  //                   borderSide:
  //                       BorderSide(color: BaseColor.border_txtfield_color),
  //                 ),
  //                 disabledBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(25),
  //                     borderSide:
  //                         BorderSide(color: BaseColor.border_txtfield_color)),
  //                 border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(25),
  //                     borderSide:
  //                         BorderSide(color: BaseColor.border_txtfield_color)),
  //                 focusedBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(25),
  //                     borderSide:
  //                         BorderSide(color: BaseColor.border_txtfield_color)),
  //                 hintText: AppMessages.hint_city_name,
  //                 hintStyle: TextStyle(
  //                   color: BaseColor.hint_color.withOpacity(0.6),
  //                   fontFamily: AppTextStyle.inter_font_family,
  //                   fontSize: 14,
  //                 ),
  //               ),
  //               // textSubmitted: (value) {
  //               //   businessProvider.changeEditableCityValue();
  //               // },
  //               // onFocusChanged: (value) {
  //               //   businessProvider.changeEditableCityValue();
  //               // },
  //               itemBuilder: (context, item) {
  //                 print("Item-> $item");
  //                 return searchItemView(
  //                     item.name, AppMessages.city_text.toLowerCase());
  //               },
  //               itemFilter: (item, query) {
  //                 return item.name
  //                     .toLowerCase()
  //                     .startsWith(query.toLowerCase());
  //               },
  //               itemSorter: (a, b) {
  //                 return a.name.compareTo(b.name);
  //               },
  //               itemSubmitted: (item) {
  //                 print("ITEM NAME-> ${item.name}");
  //                 searchCityTextField.textField.controller.text = item.name;
  //                 businessProvider.selectedCity(item);
  //                 print(
  //                     "AREA TEXT->${searchCityTextField.textField.controller.text}");
  //                 businessProvider.changeEditableCityValue();
  //               },
  //               suggestions: businessProvider.listCities,
  //             ),
  //           ),
  //         );
  //       }),
  //     ],
  //   );
  // }

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
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

//  showModalBottomSheet<void>(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//         context: context,
//         isScrollControlled: true,
//         builder: (BuildContext context) {
//           return StatefulBuilder(builder: (BuildContext context,
//               void Function(void Function()) setState) {
//             return GestureDetector(
//               onTap: () {
//                 FocusScope.of(context).unfocus();
//               },
//               child: Padding(
//                 padding: EdgeInsets.only(
//                     bottom: MediaQuery.of(context).viewInsets.bottom),
//                 child: Container(
//                   // height: ScreenSize().screenHeight(context) - 600,
//                   decoration: BoxDecoration(
//                     color: BaseColor.pure_white_color,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     ),
//                   ),
//                   child: SingleChildScrollView(
//                     physics: AlwaysScrollableScrollPhysics(),
//                     child: Padding(
//                       padding: const EdgeInsets.all(25),
//                       child: Column(
//                         // mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.max,
//                         children: <Widget>[
//                           titleView(context),
//                           GlobalView().sizedBoxView(20),
//                           // categoriesView(),
//                           // GlobalView().sizedBoxView(20),
//                           // cityAutoCompleteTextFieldView(),
//                           cityTextFieldView(),
//                           GlobalView().sizedBoxView(20),
//                           distanceRadiusView(setState, context),
//                           GlobalView().sizedBoxView(25),
//                           resetApplyView(context),
//                           GlobalView().sizedBoxView(20),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           });
//         },
//       );
