// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/data/models/verified_user_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/utils/dialog_utils.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class MultipleBusinessUserListSreen extends StatelessWidget {
  MultipleBusinessUserListArgs args;
  MultipleBusinessUserListSreen({
    Key key,
    @required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GlobalView().sizedBoxView(
                            DeviceSize().deviceHeight(context) * 0.072),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  child: GlobalView().textViewWithCenterAlign(
                                      AppMessages.business_users_text,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.bold_font_weight,
                                      BaseColor.black_color,
                                      18),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  DialogUtils().onClickLogout(context);
                                },
                                child: Container(
                                  child: Image.asset(
                                    AppImages.ic_logout_filled,
                                    height: 55,
                                    width: 55,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        GlobalView().sizedBoxView(
                            DeviceSize().deviceHeight(context) * 0.02),
                        Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: ListView.builder(
                                  itemCount: args.listBusinessUsers.length,
                                  itemBuilder: (_, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (args.listBusinessUsers[index]
                                                .isApproved ==
                                            1) {
                                          // StorageUtils.writeStringValue(
                                          //     StorageUtils.keyToken,
                                          //     args.listBusinessUsers[index].token);
                                          // AccessToken().setTokenValue(
                                          //     StorageUtils.readStringValue(
                                          //         StorageUtils.keyToken));
                                          // PreferenceUtils.setStringValue(
                                          //     PreferenceUtils
                                          //         .keyBusinessUserProfileObject,
                                          //     json.encode(verifiedOtpResponse
                                          //         .businessUsers[0]));
                                          // PreferenceUtils.setIntValue(
                                          //     PreferenceUtils.keyUserId,
                                          //     verifiedOtpResponse
                                          //         .businessUsers[0].id);
                                          // Navigator.pushNamed(
                                          //     context,
                                          //     AppRoutes
                                          //         .business_timeline_route_name);
                                        } else {}
                                      },
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 42,
                                                width: 42,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey,
                                                  image: DecorationImage(
                                                      image: args
                                                                  .listBusinessUsers[
                                                                      index]
                                                                  .avatar !=
                                                              ""
                                                          ? NetworkImage(args
                                                              .listBusinessUsers[
                                                                  index]
                                                              .avatar)
                                                          : AssetImage(AppImages
                                                              .default_profile_Pic),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GlobalView().textViewWithStartAlign(
                                                        args
                                                            .listBusinessUsers[
                                                                index]
                                                            .businessName,
                                                        AppTextStyle
                                                            .inter_font_family,
                                                        AppTextStyle
                                                            .medium_font_weight,
                                                        BaseColor
                                                            .btn_gradient_end_color1,
                                                        16),
                                                    GlobalView().textViewWithStartAlign(
                                                        args
                                                            .listBusinessUsers[
                                                                index]
                                                            .username,
                                                        AppTextStyle
                                                            .inter_font_family,
                                                        AppTextStyle
                                                            .semi_bold_font_weight,
                                                        BaseColor.black_color,
                                                        18),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              GlobalView().textViewWithStartAlign(
                                                  args.listBusinessUsers[index]
                                                              .isApproved ==
                                                          1
                                                      ? AppMessages
                                                          .approved_text
                                                      : "",
                                                  AppTextStyle
                                                      .inter_font_family,
                                                  AppTextStyle
                                                      .medium_font_weight,
                                                  Color.fromARGB(
                                                      255, 12, 134, 67),
                                                  16),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                        // GlobalView().wrappedButtonFilledView(
                        //     context, AppMessages.logout_title),
                      ],
                    ),
                    // Positioned(
                    //   child: Visibility(
                    //     visible:
                    //         Provider.of<BusinessListProvider>(context).isLoading,
                    //     child: Container(
                    //       // color: Colors.red,
                    //       child: GlobalView().loaderView(),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                // );
                // }
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MultipleBusinessUserListArgs {
  List<VerifiedUserResponse> listBusinessUsers = [];
  MultipleBusinessUserListArgs({@required this.listBusinessUsers});
}
