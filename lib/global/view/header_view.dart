import 'package:flutter/material.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/global/view/filter/filter_view.dart';
import 'package:trendoapp/global/view/global_view.dart';

// ignore: must_be_immutable
class HeaderView extends StatelessWidget {
  // const HeaderView({Key key}) : super(key: key);
  String title;
  String route;
  // FilterModel filterModel;
  HeaderView(this.title, this.route);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      // height: title.toLowerCase() == "trend" ? 50 : 40,
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 5),
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child:
                          // GlobalView().assetImageView(AppImages.trendsee),
                          // title.toLowerCase() == "trend"
                          //     ?
                          GlobalView().textViewWithStartAlign(
                              title,
                              AppTextStyle.alphapipe_font_family,
                              AppTextStyle.bold_font_weight,
                              BaseColor.forgot_pass_txt_color,
                              30)
                      // : GlobalView().textViewWithCenterAlign(
                      //     title,
                      //     AppTextStyle.inter_font_family,
                      //     AppTextStyle.bold_font_weight,
                      //     BaseColor.black_color,
                      //     20),
                      ),
                  // Expanded(
                  //   child: GlobalView().textViewWithStartAlign(
                  //         AppMessages.homeSubTitle,
                  //          AppTextStyle.metropolisFontFamily,
                  //          AppTextStyle.normalFontWeight,
                  //          BaseColor.blackColor.withOpacity(0.5),
                  //         12),
                  // ),
                ],
              ),
            ),
          ),
          Visibility(
              visible: route.toLowerCase() == "businesslikes" ? false : true,
              child: FilterView(route)),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.notifications_route_name);
              //  Navigator.pushNamed(context, AppRoutes.select_business_address_from_map_route_name);
            },
            child:
                //  Container(
                //     height: 40,
                //     width: 40,
                //     // color: Colors.redAccent,
                //     child: Image.asset(
                //       AppImages.ic_bell_filled,
                //       height: 40,
                //       width: 40,
                //     )
                //     //  GlobalView().assetImageView(AppImages.ic_bell_filled),
                //     ),
                Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
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
                child: Image.asset(
                  AppImages.ic_notification,
                  height: 35,
                  width: 35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
