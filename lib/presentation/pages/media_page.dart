import 'package:flutter/material.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/global_view.dart';

class MediaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: [
          GlobalView().assetImageView(AppImages.background_image1),
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: SizedBox(
                height: DeviceSize().deviceHeight(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GlobalView().sizedBoxView(80),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Container(
                    //         padding: EdgeInsets.symmetric(vertical: 9),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(16),
                    //           color: BaseColor.forgotPassTxtColor,
                    //         ),
                    //         child: GlobalView().textViewWithCenterAlign(
                    //             AppMessages.allText,
                    //             AppTextStyle.latoFontFamily,
                    //             AppTextStyle.mediumFontWeight,
                    //             BaseColor.pureWhiteColor,
                    //             12),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Expanded(
                    //       child: Container(
                    //         padding: EdgeInsets.symmetric(vertical: 9),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(16),
                    //           color: BaseColor.forgotPassTxtColor,
                    //         ),
                    //         child: GlobalView().textViewWithCenterAlign(
                    //             AppMessages.photosText,
                    //             AppTextStyle.latoFontFamily,
                    //             AppTextStyle.mediumFontWeight,
                    //             BaseColor.pureWhiteColor,
                    //             12),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Expanded(
                    //       child: Container(
                    //         padding: EdgeInsets.symmetric(vertical: 9),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(16),
                    //           color: BaseColor.forgotPassTxtColor,
                    //         ),
                    //         child: GlobalView().textViewWithCenterAlign(
                    //             AppMessages.videosText,
                    //             AppTextStyle.latoFontFamily,
                    //             AppTextStyle.mediumFontWeight,
                    //             BaseColor.pureWhiteColor,
                    //             12),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    GlobalView().sizedBoxView(10),
                    Expanded(
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GridView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: 30,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.95,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(20),
                                //   color: BaseColor.forgotPassTxtColor,
                                // ),
                                child: Image.asset(
                                  AppImages.photo1,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                      ),
                    ),
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
                    Navigator.pop(context);
                  },
                  child: GlobalView().assetImageView(AppImages.ic_back)),
            ),
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.topCenter,
              child: GlobalView().textViewWithCenterAlign(
                  AppMessages.media_text,
                  AppTextStyle.inter_font_family,
                  AppTextStyle.semi_bold_font_weight,
                  BaseColor.black_color,
                  22),
            ),
          ),
          Positioned(
            top: 65,
            right: 20,
            child: Container(
              alignment: Alignment.topCenter,
              child: GlobalView().textViewWithCenterAlign(
                  AppMessages.select_all_text,
                  AppTextStyle.inter_font_family,
                  AppTextStyle.medium_font_weight,
                  BaseColor.selected_tab_color,
                  12),
            ),
          ),
        ],
      ),
    );
  }
}
