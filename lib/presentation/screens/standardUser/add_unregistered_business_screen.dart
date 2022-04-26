import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/multiline_textfield.dart';
import 'package:trendoapp/providers/base_response_provider.dart';
import 'package:trendoapp/providers/business_list_provider.dart';
import 'package:trendoapp/providers/categories_list_provider.dart';
import 'package:trendoapp/utils/category_utils.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class AddUnregisteredBusinessScreen extends StatefulWidget {
  AddUnregisteredBusinessScreen({Key key}) : super(key: key);

  @override
  State<AddUnregisteredBusinessScreen> createState() =>
      _AddUnregisteredBusinessScreenState();
}

class _AddUnregisteredBusinessScreenState
    extends State<AddUnregisteredBusinessScreen> {
  TextEditingController businessNameTextEditingController =
      TextEditingController();
  TextEditingController categoryTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    categoryTextEditingController.text = CategoryUtils().getCategoryName(
        Provider.of<CategoriesListProvider>(context, listen: false)
            .listSelectedCategories);
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
                                        AppMessages
                                            .add_unregistered_business_title,
                                        AppTextStyle.inter_font_family,
                                        AppTextStyle.bold_font_weight,
                                        BaseColor.black_color,
                                        18),
                                  ),
                                  GlobalView().sizedBoxView(
                                      DeviceSize().deviceHeight(context) *
                                          0.02),
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
                                      AppTextStyle.start_text_align),
                                  GlobalView().sizedBoxView(5),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    alignment: Alignment.centerLeft,
                                    child: GlobalView().textViewWithCenterAlign(
                                        AppMessages.hint_category_name,
                                        AppTextStyle.inter_font_family,
                                        AppTextStyle.normal_font_weight,
                                        BaseColor.black_color.withOpacity(0.5),
                                        11),
                                  ),
                                  MultilineCategoryTextfield(
                                      controller:
                                          categoryTextEditingController),
                                  GlobalView().sizedBoxView(30),
                                  GestureDetector(
                                      onTap: () {
                                        onTapSubmit();
                                      },
                                      child: GlobalView().buttonFilled(context,
                                          AppMessages.submit_btn_text)),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                      // CommonGradientButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (_) =>
                      //                   AddUnregisteredBusinessScreen()));
                      //     },
                      //     title: AppMessages.next_text),
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
                    top: 60,
                    left: 21,
                    child: Container(
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

  void onTapSubmit() {
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    String businessUsername = timeStamp.toString();
    print("businessUsername $businessUsername");
    if (businessNameTextEditingController.text.isNotEmpty &&
        categoryTextEditingController.text.isNotEmpty) {
      Provider.of<BaseResponseProvider>(context, listen: false)
          .addUnregisteredBusiness(
              businessNameTextEditingController.text,
              StorageUtils.readStringValue(StorageUtils.keyLatitude),
              StorageUtils.readStringValue(StorageUtils.keyLongitude),
              Provider.of<CategoriesListProvider>(context, listen: false)
                  .listSelectedCategoryId
                  .join(','),
              context,
              businessUsername);
    } else {
      GlobalView().showToast(AppToastMessages.empty_business_name_message);
    }
  }
}
