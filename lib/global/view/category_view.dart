import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/data/global/home_list_data.dart';
import 'package:trendoapp/data/global/search_list_data.dart';
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
  int page;
  // FilterModel filterModel;
  @override
  void initState() {
    super.initState();
    // filterModel =
    //     Provider.of<FilterProvider>(context, listen: false).filterModel;
    // print("C Id-> ${filterModel.categoryId}");
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoriesListProvider>(context, listen: false)
          .selectedCategoryItem(
              Provider.of<CategoriesListProvider>(context, listen: false)
                  .listCategoriesForHome[0]);
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

  void onClickCategoryItem(
      BuildContext context, CategoriesListProvider categoriesProvider, index) {
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .homeFeedResponse = null;
    page = 1;
    // Provider.of<CategoriesListProvider>(context, listen: false).onClickCategory(
    //     Provider.of<CategoriesListProvider>(context, listen: false)
    //         .listCategoriesForHome[index],
    //     context);
    Provider.of<CategoriesListProvider>(context, listen: false)
        .selectedCategoryItem(
            Provider.of<CategoriesListProvider>(context, listen: false)
                .listCategoriesForHome[index]);
    if (widget.route.toLowerCase() == "home") {
      HomeListData().applyHomeData(context);
    } else if (widget.route.toLowerCase() == "search") {
      SearchListData().searchDataForCategories(context, page);
    } else if (widget.route.toLowerCase() == "businesslikes") {}
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesListProvider>(
        builder: (_, categoriesProvider, child) {
      return Container(
          height: 32,
          // color: Colors.green,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoriesProvider.listCategoriesForHome.length,
              itemBuilder: (_, index) {
                return Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                      onTap: () {
                        //  throw new Exception("Test Crash");
                        onClickCategoryItem(context, categoriesProvider, index);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color:
                                //  categoriesProvider
                                //         .listCategoriesForHome[index].isChecked
                                categoriesProvider
                                            .selectedCategoryResponse.name ==
                                        categoriesProvider
                                            .listCategories[index].name
                                    ? BaseColor.forgot_pass_txt_color
                                    : BaseColor.home_bg_color,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color:

                                    // categoriesProvider
                                    //         .listCategoriesForHome[index]
                                    //         .isChecked
                                    categoriesProvider.selectedCategoryResponse
                                                .name ==
                                            categoriesProvider
                                                .listCategories[index].name
                                        ? BaseColor.forgot_pass_txt_color
                                        : BaseColor.black_color
                                            .withOpacity(0.5))),
                        child: GlobalView().textViewWithCenterAlign(
                            categoriesProvider
                                .listCategoriesForHome[index].name,
                            AppTextStyle.lato_font_family,
                            AppTextStyle.normal_font_weight,

                            // categoriesProvider
                            //         .listCategoriesForHome[index].isChecked
                            categoriesProvider.selectedCategoryResponse.name ==
                                    categoriesProvider
                                        .listCategories[index].name
                                ? BaseColor.pure_white_color
                                : BaseColor.black_color.withOpacity(0.5),
                            12),
                      ),
                    ));
              })
          // Wrap(
          //     direction: Axis.horizontal,
          //     children: List<Widget>.generate(
          //         listCategories.length,
          //         (index) => Padding(
          //               padding: EdgeInsets.all(8.0),
          //               child: Text(listCategories[index]),
          //             ))),
          );
    });
  }
}
