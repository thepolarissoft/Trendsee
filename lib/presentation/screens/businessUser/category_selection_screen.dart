// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/common_gradient_button.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/screens/standardUser/add_unregistered_business_screen.dart';
import 'package:trendoapp/providers/business_list_provider.dart';
import 'package:trendoapp/providers/categories_list_provider.dart';

class CategorySelectionScreen extends StatefulWidget {
  CategorySelectionScreen({Key key, @required this.userType}) : super(key: key);
  int userType = 0; //0=standard user, 1=business user
  @override
  _CategorySelectionScreenState createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  ScrollController scrollController = new ScrollController();
  void getCategoryData() {
    var provider = Provider.of<CategoriesListProvider>(context, listen: false);
    provider.getCategoriesList(context).then((value) {
      for (var i = 0; i < provider.listCategories.length; i++) {
        for (var j = 0; j < provider.listSelectedCategoryId.length; j++) {
          if (provider.listCategories[i].id ==
              provider.listSelectedCategoryId[j]) {
            provider.listCategories[i].isChecked = true;
            // provider.listSelectedCategories.add(value)
          }
        }
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    var categoryProvider =
        Provider.of<CategoriesListProvider>(context, listen: false);
    // categoryProvider.listSelectedCategories.clear();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // getCategoryData();
      // categoryProvider.getCategoriesList(context);
      ApiManager(context).getCategoriesList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BaseColor.pure_white_color,
      child: SafeArea(
        top: false,
        bottom: true,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: Container(
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
                          padding:
                              EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Consumer<BusinessListProvider>(
                                builder: (_, location, child) {
                              return Column(
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  GlobalView().sizedBoxView(
                                      DeviceSize().deviceHeight(context) *
                                          0.052),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    child: GlobalView().textViewWithCenterAlign(
                                        AppMessages.choose_business_cat_title,
                                        AppTextStyle.inter_font_family,
                                        AppTextStyle.bold_font_weight,
                                        BaseColor.black_color,
                                        18),
                                  ),
                                  GlobalView().sizedBoxView(
                                      DeviceSize().deviceHeight(context) *
                                          0.02),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Container(
                                        height:
                                            DeviceSize().deviceHeight(context) -
                                                300,
                                        child: categoriesList(context),
                                      ),
                                    ),
                                  ),
                                  // GlobalView().sizedBoxView(
                                  //     DeviceSize().deviceHeight(context) * 0.02),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                      Consumer<CategoriesListProvider>(
                          builder: (_, provider, child) {
                        return Visibility(
                          visible: widget.userType == 0 ? true : false,
                          child: provider.listSelectedCategories.isNotEmpty
                              ? CommonGradientButton(
                                  onPressed: () {
                                    // provider.onClickSaveCategory();
                                    if (provider
                                        .listSelectedCategories.isNotEmpty) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  AddUnregisteredBusinessScreen()));
                                    } else {}
                                  },
                                  title: AppMessages.next_text)
                              : CommonGradientButton(
                                  onPressed: () {},
                                  title: AppMessages.next_text,
                                  gradientColors: [Colors.grey, Colors.grey],
                                ),
                        );
                      })
                    ],
                  ),
                  Positioned(
                    child: Visibility(
                      visible:
                          Provider.of<BusinessListProvider>(context).isLoading,
                      child: Container(
                        // color: Colors.red,
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
                            var provider = Provider.of<CategoriesListProvider>(
                                context,
                                listen: false);
                            provider.listSelectedCategories.clear();
                            for (var i = 0;
                                i < provider.listCategories.length;
                                i++) {
                              provider.listCategories[i].isChecked = false;
                            }
                            Navigator.pop(context);
                          },
                          child:
                              GlobalView().assetImageView(AppImages.ic_back)),
                    ),
                  ),
                ],
              ),
              // );
              // }
            ),
          ),
        ),
      ),
    );
  }

  Widget categoriesList(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Consumer<CategoriesListProvider>(
          builder: (_, provider, child) {
            // print("isAvailableData -> ${provider.isAvailableData}");
            if (provider.listCategories.isNotEmpty) {
              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: ListView.builder(
                  // shrinkWrap: true,
                  itemCount: provider.listCategories.length,
                  controller: scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    // print(
                    //     "Screen isChecked-> ${provider.listCategories[index].isChecked}");
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: GlobalView().textViewWithStartAlign(
                                      provider.listCategories[index].name,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.medium_font_weight,
                                      BaseColor.black_color,
                                      18),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            padding: EdgeInsets.zero,
                            // color: Colors.green,
                            child: Theme(
                              data: ThemeData(
                                  unselectedWidgetColor:
                                      BaseColor.btn_gradient_end_color1,
                                  backgroundColor:
                                      BaseColor.btn_gradient_end_color1),
                              child: Checkbox(
                                  value:
                                      provider.listCategories[index].isChecked,
                                  checkColor: BaseColor.pure_white_color,
                                  activeColor:
                                      BaseColor.btn_gradient_end_color1,
                                  onChanged: (bool value) {
                                    provider.changeCheckBoxValue(
                                        provider.listCategories[index], value);
                                    // setState(() {
                                    //   checkValue = value;
                                    // });
                                  }),
                              // CheckboxGroup(
                              //     labels: listLocation,
                              //     onSelected: (List<String> checked) =>
                              //         print(checked.toString())),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else {
              return Visibility(
                // visible: !provider.isAvailableData,
                child: Container(
                    // color: Colors.red,
                    child: Center(
                  child: GlobalView().textViewWithCenterAlign(
                      AppMessages.no_nearby_locations_available_text,
                      AppTextStyle.inter_font_family,
                      AppTextStyle.semi_bold_font_weight,
                      BaseColor.black_color,
                      18),
                )),
              );
            }
          },
        ),
      ),
    );
  }
}
