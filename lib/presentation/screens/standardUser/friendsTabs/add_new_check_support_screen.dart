import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/base_response_provider.dart';
import 'package:trendoapp/providers/business_list_provider.dart';

// ignore: must_be_immutable
class AddNewCheckSupportScreen extends StatefulWidget {
  final int? businessId;
  final int? categoriesId;
  final String? categoriesName;
  final String? businessLatitude;
  final String? businessLongitude;
  final String? businessLocationName;
  final String? businessName;
   bool isScreenChange = false;

   AddNewCheckSupportScreen({
    super.key,
    this.businessId,
    this.categoriesName,
    this.categoriesId,
    this.businessLatitude,
    this.businessLongitude,
    this.businessName,
    this.businessLocationName,
  required this.isScreenChange,
  });

  @override
  State<AddNewCheckSupportScreen> createState() => _AddNewCheckSupportScreenState();
}

class _AddNewCheckSupportScreenState extends State<AddNewCheckSupportScreen> {
  TextEditingController locationTextEditingController = new TextEditingController();

  TextEditingController businessNameTextEditingController = new TextEditingController();

  TextEditingController commentTextEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    locationTextEditingController.text = widget.businessLocationName ?? '';
    businessNameTextEditingController.text = widget.businessName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GlobalView().safeAreaView(GestureDetector(
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
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: SingleChildScrollView(
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    GlobalView().sizedBoxView(47),
                                    Container(
                                      alignment: Alignment.topCenter,
                                      child: GlobalView()
                                          .textViewWithCenterAlign(AppMessages.add_new_checkin_title, AppTextStyle.inter_font_family, AppTextStyle.bold_font_weight, BaseColor.black_color, 18),
                                    ),
                                    Consumer<BusinessListProvider>(
                                      builder: (_, provider, child) {
                                        return businessNameView(context, provider);
                                      },
                                    ),
                                    GlobalView().sizedBoxView(10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 30),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 5),
                                        alignment: Alignment.centerLeft,
                                        child: GlobalView().textViewWithStartAlign(
                                            AppMessages.title_your_review + " (optional)", AppTextStyle.inter_font_family, AppTextStyle.normal_font_weight, BaseColor.black_color.withOpacity(0.5), 11),
                                      ),
                                    ),
                                    GlobalView().sizedBoxView(5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30,
                                      ),
                                      child: Container(
                                        height: 135,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: AssetImage(AppImages.rect), fit: BoxFit.contain),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.only(top: 5, bottom: 12),
                                          child: TextField(
                                            controller: commentTextEditingController,
                                            expands: true,
                                            maxLines: null,
                                            style: TextStyle(
                                              color: BaseColor.hint_color,
                                              fontFamily: AppTextStyle.inter_font_family,
                                              fontSize: 14,
                                            ),
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(60),
                                            ],
                                            cursorColor: BaseColor.black_color.withOpacity(0.5),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              focusColor: BaseColor.pure_white_color,
                                              contentPadding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              hintText: AppMessages.hint_write_comment,
                                              hintStyle: TextStyle(
                                                color: BaseColor.hint_color.withOpacity(0.6),
                                                fontFamily: AppTextStyle.inter_font_family,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GlobalView().sizedBoxView(40),
                                    Consumer<BusinessListProvider>(builder: (_, provider, child) {
                                      return GestureDetector(
                                        onTap: () {
                                          Provider.of<BaseResponseProvider>(context, listen: false).createFeed(
                                            context,
                                            commentTextEditingController.text.isEmpty ? "" : commentTextEditingController.text,
                                            widget.businessId.toString(),
                                            widget.categoriesId.toString(),
                                            widget.businessLatitude,
                                            widget.businessLongitude,
                                            widget.businessLocationName,
                                            isSupport: "1",
                                          );
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                            ),
                                            child: GlobalView().buttonFilled(context, AppMessages.submit_btn_text)),
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
                              height: 25,
                              width: 25,
                              child: GestureDetector(
                                  onTap: () {
                                    Provider.of<BusinessListProvider>(context, listen: false).isChecked = false;
                                    widget.isScreenChange == true ? Navigator.pushNamed(context, AppRoutes.timeline_route_name) : Navigator.pop(context);
                                  },
                                  child: GlobalView().assetImageView(AppImages.ic_back)),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        child: GlobalView().loaderView(),
                      );
              })),
    ));
  }

  Widget businessNameView(BuildContext context, BusinessListProvider provider) => Visibility(
        visible: true,
        child: Column(
          children: [
            GlobalView().sizedBoxView(35),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.centerLeft,
                child:
                    GlobalView().textViewWithCenterAlign(AppMessages.title_business_name, AppTextStyle.inter_font_family, AppTextStyle.normal_font_weight, BaseColor.black_color.withOpacity(0.5), 11),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GlobalView().textFieldViewReadOnly(AppImages.ic_business, businessNameTextEditingController, AppMessages.hint_business_name, AppTextStyle.start_text_align),
            ),
            GlobalView().sizedBoxView(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.centerLeft,
                child: GlobalView().textViewWithCenterAlign(AppMessages.title_category, AppTextStyle.inter_font_family, AppTextStyle.normal_font_weight, BaseColor.black_color.withOpacity(0.5), 11),
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
                        //   provider.verifiedUserResponse != null && provider.verifiedUserResponse.categories != null ? //CategoryUtils().getCategoryName(provider.verifiedUserResponse.categories!) :
                        widget.categoriesName ?? "Cafe",
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

  Widget textFieldViewForSelectLocation(String image, TextEditingController controller, String hintText, TextAlign textAlign, BuildContext context) => Column(
        children: [
          GlobalView().sizedBoxView(20),
          Container(
            alignment: Alignment.centerLeft,
            child: GlobalView().textViewWithStartAlign(AppMessages.title_location, AppTextStyle.inter_font_family, AppTextStyle.normal_font_weight, BaseColor.black_color.withOpacity(0.5), 11),
          ),
          GlobalView().sizedBoxView(5),
          Material(
            shadowColor: BaseColor.shadow_color,
            elevation: 4,
            borderRadius: BorderRadius.circular(25),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.select_location_for_add_new_checkin_route_name);
              },
              child: new TextField(
                enabled: false,
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
                      padding: EdgeInsets.only(left: 0, right: 10, top: 5, bottom: 5),
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
                    borderSide: BorderSide(color: BaseColor.border_txtfield_color),
                  ),
                  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
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
