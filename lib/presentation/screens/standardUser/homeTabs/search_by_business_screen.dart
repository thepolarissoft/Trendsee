import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/data/global/search_list_data.dart';
import 'package:trendoapp/data/models/search_by_business_response.dart';
import 'package:trendoapp/global/view/business_item_view.dart';
import 'package:trendoapp/global/view/category_view.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/header_view.dart';
import 'package:trendoapp/presentation/screens/standardUser/friendsTabs/business_details_screen.dart';
import 'package:trendoapp/providers/categories_list_provider.dart';
import 'package:trendoapp/providers/connection/connection_provider.dart';
import 'package:trendoapp/providers/filter_provider.dart';
import 'package:trendoapp/providers/search_by_business_provider.dart';
import 'package:trendoapp/utils/dialog_utils.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class SearchByBusinessScreen extends StatefulWidget {
  @override
  _SearchByBusinessScreenState createState() => _SearchByBusinessScreenState();
}

class _SearchByBusinessScreenState extends State<SearchByBusinessScreen>
    with TickerProviderStateMixin {
  // TabController _tabController;
  TextEditingController searchEditingController = new TextEditingController();
  int page = 1;
  ScrollController scrollController = new ScrollController();
  TextEditingController reasonEditingController = new TextEditingController();
  // String distanceRadius = "5";
  // FocusNode focusNode = new FocusNode();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      SearchListData()
          .initSearchData(context, searchEditingController.text, page);
    });
    // focusNode.addListener(() {});
    scrollController.addListener(() {
      // print("pixels ${scrollController.position.pixels}");
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreBusinessData();
      }
    });
  }

  void getMoreBusinessData() async {
    SearchByBusinessResponse searchByBusinessResponse =
        Provider.of<SearchByBusinessProvider>(context, listen: false)
            .searchByBusinessResponse;
    if (searchByBusinessResponse != null &&
        searchByBusinessResponse.place != null &&
        searchByBusinessResponse.place.nextPageUrl != null) {
      page++;
      Provider.of<SearchByBusinessProvider>(context, listen: false)
          .getSearchByBusinessList(
        context,
        page,
        searchEditingController.text,
        Provider.of<CategoriesListProvider>(context, listen: false)
            .selectedCategoryResponse
            .id
            .toString(),
        // filterModel.categoryId,
        StorageUtils.readStringValue(StorageUtils.keyLatitude),
        StorageUtils.readStringValue(StorageUtils.keyLongitude),
        Provider.of<FilterProvider>(context, listen: false).distanceRadius,
        Provider.of<FilterProvider>(context, listen: false)
            .selectedMetropolitanCityInfo,
      );
    } else {
      GlobalView()
          .showToast(AppMessages.no_feeds_available_with_filters_message);
    }
  }

  // void onClickLikedButton(){}

  @override
  Widget build(BuildContext context) {
    print(
        "IS INTERNET Search->${Provider.of<ConnectionProvider>(context).isInternetConnection} ");
    // filterModel.page = page;
    // filterModel.searchValue = searchEditingController.text;
    // filterModel.categoryId =
    //     Provider.of<CategoriesListProvider>(context, listen: false)
    //         .selectedCategoryResponse
    //         .id
    //         .toString();
    // filterModel.latitude =
    //     Provider.of<CurrentLocationProvider>(context, listen: false)
    //         .currentLocationPosition
    //         .latitude
    //         .toString();
    // filterModel.longitude =
    //     Provider.of<CurrentLocationProvider>(context, listen: false)
    //         .currentLocationPosition
    //         .longitude
    //         .toString();
    // filterModel.distance = distanceRadius;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        child: SafeArea(
          top: true,
          bottom: true,
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: false,
              backgroundColor: BaseColor.home_bg_color,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(200),
                // preferredSize: Size.fromHeight(260),
                child: AppBar(
                  flexibleSpace: Container(
                    // height: 150,
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22, right: 22),
                          child: HeaderView(AppMessages.search_title, "search"),
                        ),
                        GlobalView().sizedBoxView(15),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 22),
                                child: textfieldViewForSearchPeople(
                                    AppImages.ic_search,
                                    searchEditingController,
                                    AppMessages.hint_search_by_business_name,
                                    AppTextStyle.start_text_align),
                              ),
                            ),
                            // Container(
                            //   height: 52,
                            //   width: 52,
                            //   child: Image.asset(
                            //     AppImages.ic_sort,
                            //     // height: 50,
                            //     // width: 50,
                            //   ),
                            // ),
                          ],
                        ),
                        // GlobalView().sizedBoxView(10),
                        // Padding(
                        //   padding: EdgeInsets.zero,
                        //   child: GlobalView().buttonFilled(
                        //       context, AppMessages.find_near_by_business_text),
                        // ),
                        GlobalView().sizedBoxView(25),
                        CategoryView(
                          "search",
                        ),
                      ],
                    ),
                  ),
                  automaticallyImplyLeading: false,
                  backgroundColor: BaseColor.home_bg_color,
                  elevation: 0,
                  // bottom: TabBar(
                ),
              ),
              body:
                  // PlacesSearchTabScreen()
                  listBusinesses(),
            ),
          ),
        ),
      ),
    );
  }

  Widget listBusinesses() =>
      Consumer<SearchByBusinessProvider>(builder: (_, provider, child) {
        return Stack(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 26, right: 26, bottom: 5),
                child: Container(
                  // color: Colors.red,
                  child: provider.listBusiness.isNotEmpty
                      ? MediaQuery.removePadding(
                          context: context,
                          removeTop: false,
                          removeBottom: true,
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            itemCount: provider.listBusiness.length,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemBuilder: (_, index) =>
                                // Padding(
                                //   padding: EdgeInsets.only(bottom: 10, top: 10),
                                //   child: Column(
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       Container(
                                //         child: GlobalView().textViewWithStartAlign(
                                //             provider
                                //                 .listBusiness[index].businessName,
                                //             AppTextStyle.interFontFamily,
                                //             AppTextStyle.boldFontWeight,
                                //             BaseColor.blackColor,
                                //             18),
                                //       ),
                                //       Container(
                                //         child: GlobalView().textViewWithStartAlign(
                                //             provider.listBusiness[index]
                                //                 .businessAddress,
                                //             AppTextStyle.interFontFamily,
                                //             AppTextStyle.normalFontWeight,
                                //             BaseColor.blackColor.withOpacity(0.5),
                                //             16),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                GestureDetector(
                              onTap: () {
                                // if (provider.listBusiness.isNotEmpty) {
                                // provider.selectedBusinessItem(
                                //     provider.listBusiness[index]);
                                // }
                                // Navigator.pushNamed(
                                //     context,
                                //     AppRoutes
                                //         .business_liked_details_route_name);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BusinessDetailsScreen(
                                      businessId:
                                          provider.listBusiness[index].id,
                                    ),
                                  ),
                                );
                              },
                              child: BusinessItemView(
                                  verifiedUserResponse:
                                      provider.listBusiness[index],
                                  onClickLikeButton: () {
                                    if (provider.listBusiness[index].isLiked ==
                                        0) {
                                      provider.likeBusiness(context,
                                          provider.listBusiness[index]);
                                    } else {
                                      // DialogUtils().onClickLikedBusiness(
                                      //     context,
                                      //     provider,
                                      //     index,
                                      //     "",
                                      //     provider.listBusiness[index].id);
                                      DialogUtils.displayDislikeDialog(
                                        context,
                                        reasonEditingController,
                                        () {
                                          if (reasonEditingController
                                              .text.isNotEmpty) {
                                            provider.dislikeBusiness(
                                                context,
                                                provider.listBusiness[index],
                                                reasonEditingController.text,
                                                1,
                                                "");
                                          } else if (reasonEditingController
                                              .text.isEmpty) {
                                            GlobalView().showToast(
                                                AppToastMessages
                                                    .valid_reason_message);
                                          }
                                        },
                                      );
                                    }
                                  }),
                            ),
                          ),
                        )
                      : Container(
                          child: Center(
                          child: GlobalView().textViewWithCenterAlign(
                              AppMessages
                                  .no_feeds_available_with_filters_message,
                              AppTextStyle.inter_font_family,
                              AppTextStyle.semi_bold_font_weight,
                              BaseColor.black_color,
                              18),
                        )),
                )),
            Positioned(
              child: Visibility(
                visible: Provider.of<SearchByBusinessProvider>(context,
                        listen: false)
                    .isLoading,
                child: Container(
                  color: BaseColor.home_bg_color,
                  child: GlobalView().loaderView(),
                ),
              ),
            ),
          ],
        );
      });

  Widget textfieldViewForSearchPeople(
          String image,
          TextEditingController controller,
          String hintText,
          TextAlign textAlign) =>
      Material(
        shadowColor: BaseColor.shadow_color,
        elevation: 4,
        borderRadius: BorderRadius.circular(25),
        child: TextField(
          // focusNode: focusNode,
          controller: controller,
          cursorColor: BaseColor.border_txtfield_color,
          style: TextStyle(
            color: BaseColor.hint_color,
            fontFamily: AppTextStyle.inter_font_family,
            fontSize: 14,
          ),
          textDirection: TextDirection.ltr,
          textAlign: textAlign,
          onChanged: (String value) {
            // controller.text = value.trim();
            if (controller.text.indexOf(' ') >= 1) {
              print("contains spaces");
              controller.text = controller.text.replaceAll('  ', '');
            } else {
              if (controller.text.startsWith(' ')) {
                print("start called");
                controller.text = controller.text.trimLeft();
                controller.text = controller.text.replaceAll('  ', '');
              } else if (controller.text.endsWith(' ')) {
                print("end called");
                controller.text = controller.text.trimRight();
                controller.text = controller.text.replaceAll('  ', '');
              }
            }
            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length));
            print(" controller.text-> ${controller.text}");
            Provider.of<SearchByBusinessProvider>(context, listen: false)
                .listBusiness
                .clear();
            // if (controller.text.length > 0) {
            Provider.of<FilterProvider>(context, listen: false)
                .setSearchValue(controller.text);

            Provider.of<SearchByBusinessProvider>(context, listen: false)
                .getSearchByBusinessList(
              context,
              page,
              controller.text,
              Provider.of<CategoriesListProvider>(context, listen: false)
                  .selectedCategoryResponse
                  .id
                  .toString(),
              StorageUtils.readStringValue(StorageUtils.keyLatitude),
              StorageUtils.readStringValue(StorageUtils.keyLongitude),
              Provider.of<FilterProvider>(context, listen: false)
                  .distanceRadius,
              Provider.of<FilterProvider>(context, listen: false)
                  .selectedMetropolitanCityInfo,
            );
            // }
          },
          keyboardType: TextInputType.name,
          inputFormatters: <TextInputFormatter>[
            // FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9 ]+$')),
            // FilteringTextInputFormatter(RegExp(r'^[a-zA-Z0-9 ]+$'), allow: true)
            FilteringTextInputFormatter(RegExp("[a-zA-Z0-9 ]"), allow: true),
          ],
          decoration: InputDecoration(
            isDense: true,
            focusColor: BaseColor.pure_white_color,
            contentPadding: EdgeInsets.only(left: 60, right: -30),
            prefixIcon: Container(
              // height: 50,
              // width: 58,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 13, bottom: 13, left: 13, right: 13),
                child: Image.asset(
                  image,
                  height: 24,
                  width: 24,
                ),
              ),
            ),
            //  prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: BaseColor.border_txtfield_color),
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
            hintText: hintText,
            hintStyle: TextStyle(
              color: BaseColor.hint_color.withOpacity(0.6),
              fontFamily: AppTextStyle.inter_font_family,
              fontSize: 14,
            ),
          ),
        ),
      );
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();
      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}
