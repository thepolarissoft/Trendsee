import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/data/models/category_response.dart';
import 'package:trendoapp/providers/categories_list_provider.dart';
import 'package:trendoapp/providers/home_feed_response_provider.dart';
import 'global_view.dart';

// ignore: must_be_immutable
class CategoryView extends StatefulWidget {
  // const CategoryView({Key key}) : super(key: key);
  String route;
  // CategoryView(this.page, this.route);

  CategoryView(this.route);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  int? page;
  // FilterModel filterModel;
  @override
  void initState() {
    super.initState();
    // filterModel =
    //     Provider.of<FilterProvider>(context, listen: false).filterModel;
    // print("C Id-> ${filterModel.categoryId}");
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // Provider.of<CategoriesListProvider>(context, listen: false)
      //     .selectedCategoryItem(
      //         Provider.of<CategoriesListProvider>(context, listen: false)
      //             .listCategoriesForHome[0]);
    });

    var provider = Provider.of<CategoriesListProvider>(context, listen: false);
    for (var i = 0; i < provider.listCategoriesForHome.length; i++) {
      provider.listCategoriesForHome[i].isChecked = false;
    }
    // provider.listFilteredCategoryId.clear();
    // provider.listCategoriesForHome[0].isChecked = true;
    // provider.listFilteredCategoryId.add(provider.listCategoriesForHome[0].id);
    // provider.selectedCategoryResponse = null;
  }

  void onClickCategoryItem(BuildContext context) {
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .homeFeedResponse = null;
    page = 1;
    // Provider.of<CategoriesListProvider>(context, listen: false)
    //     .selectedCategoryItem(
    //         Provider.of<CategoriesListProvider>(context, listen: false)
    //             .listCategoriesForHome[index]);

    // if (widget.route.toLowerCase() == "home") {
    //   HomeListData().applyHomeData(context);
    // } else if (widget.route.toLowerCase() == "search") {
    //   SearchListData().searchDataForCategories(context, page);
    // } else if (widget.route.toLowerCase() == "businesslikes") {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: categoryView(),
    );
  }

  Widget categoryView() =>
      Consumer<CategoriesListProvider>(builder: (_, categories, child) {
        print("CATEGORY->> ${categories.selectedCategoryResponse!.toJson()}");
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
                          value: categories.selectedCategoryResponse,
                          iconSize: 25,
                          icon: Icon(Icons.arrow_drop_down,
                              color: BaseColor.border_txtfield_color, size: 25),
                          items: <CategoryResponse>[
                            for (var i = 0;
                                i < categories.listCategoriesForHome.length;
                                i++)
                              categories.listCategoriesForHome[i]
                          ].map((CategoryResponse value) {
                            return DropdownMenuItem<CategoryResponse>(
                                value: value,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GlobalView()
                                          .textViewWithStartAlign(
                                              value.name!,
                                              AppTextStyle.inter_font_family,
                                              AppTextStyle.normal_font_weight,
                                              BaseColor.hint_color,
                                              14),
                                    ),
                                  ],
                                ));
                          }).toList(),
                          // hint: new GlobalView().textViewWithCenterAlign(
                          //     categories.listCategories[0].name,
                          //     AppTextStyle.inter_font_family,
                          //     AppTextStyle.normal_font_weight,
                          //     BaseColor.hint_color,
                          //     14),
                          onChanged: (selectedValue) {
                            // categories.selectedCategory = selectedValue;
                            categories.selectedCategoryItem(selectedValue);
                            onClickCategoryItem(context);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );
      });

  // Consumer<CategoriesListProvider>(
  //     builder: (_, categoriesProvider, child) {
  //   return Container(
  //       height: 32,
  //       // color: Colors.green,
  //       child:

  // ListView.builder(
  //     scrollDirection: Axis.horizontal,
  //     itemCount: categoriesProvider.listCategoriesForHome.length,
  //     itemBuilder: (_, index) {
  //       return Padding(
  //           padding: EdgeInsets.only(left: 20),
  //           child: GestureDetector(
  //             onTap: () {
  //               //  throw new Exception("Test Crash");
  //               onClickCategoryItem(context, categoriesProvider, index);
  //             },
  //             child: Container(
  //               padding:
  //                   EdgeInsets.symmetric(horizontal: 16, vertical: 6),
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                   color:
  //                       //  categoriesProvider
  //                       //         .listCategoriesForHome[index].isChecked
  //                       categoriesProvider
  //                                   .selectedCategoryResponse.name ==
  //                               categoriesProvider
  //                                   .listCategories[index].name
  //                           ? BaseColor.forgot_pass_txt_color
  //                           : BaseColor.home_bg_color,
  //                   borderRadius: BorderRadius.circular(20),
  //                   border: Border.all(
  //                       color:

  //                           // categoriesProvider
  //                           //         .listCategoriesForHome[index]
  //                           //         .isChecked
  //                           categoriesProvider.selectedCategoryResponse
  //                                       .name ==
  //                                   categoriesProvider
  //                                       .listCategories[index].name
  //                               ? BaseColor.forgot_pass_txt_color
  //                               : BaseColor.black_color
  //                                   .withOpacity(0.5))),
  //               child: GlobalView().textViewWithCenterAlign(
  //                   categoriesProvider
  //                       .listCategoriesForHome[index].name,
  //                   AppTextStyle.lato_font_family,
  //                   AppTextStyle.normal_font_weight,

  //                   // categoriesProvider
  //                   //         .listCategoriesForHome[index].isChecked
  //                   categoriesProvider.selectedCategoryResponse.name ==
  //                           categoriesProvider
  //                               .listCategories[index].name
  //                       ? BaseColor.pure_white_color
  //                       : BaseColor.black_color.withOpacity(0.5),
  //                   12),
  //             ),
  //           ));
  //     })

  // Wrap(
  //     direction: Axis.horizontal,
  //     children: List<Widget>.generate(
  //         listCategories.length,
  //         (index) => Padding(
  //               padding: EdgeInsets.all(8.0),
  //               child: Text(listCategories[index]),
  //             ))),
  //       );
  // });
}
