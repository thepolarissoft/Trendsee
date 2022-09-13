import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/notifications_provider.dart';
import 'package:trendoapp/utils/day_time_utils.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  ScrollController scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    Provider.of<NotificationsProvider>(context, listen: false)
        .notificationListResponse = null;
    Future.delayed(
        Duration.zero,
        () => Provider.of<NotificationsProvider>(context, listen: false)
            .getNotificationsList(context));
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        final provider =
            Provider.of<NotificationsProvider>(context, listen: false);
        if (provider.notificationListResponse!.notifications!.currentPage! <
            provider.notificationListResponse!.notifications!.lastPage!) {
          provider.getNotificationsList(context);
        } else {
          // GlobalView().showToast(AppMessages.no_more_data_text);
        }
      }
    });
  }

  // void getMoreNotificationsData() {
  //   NotificationListResponse notificationListResponse =
  //       Provider.of<NotificationsProvider>(context, listen: false)
  //           .notificationListResponse;
  //   if (notificationListResponse != null &&
  //       notificationListResponse.notifications != null &&
  //       notificationListResponse.notifications.nextPageUrl != null) {
  //     page++;
  //     Provider.of<NotificationsProvider>(context, listen: false)
  //         .getNotificationsList(context);
  //   } else {
  //     GlobalView().showToast(AppMessages.no_more_data_text);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BaseColor.pure_white_color,
      child: Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: Colors.red,
              image: DecorationImage(
                  image: AssetImage(
                    AppImages.background_image1,
                  ),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GlobalView().sizedBoxView(57),
                    Align(
                      alignment: Alignment.center,
                      child: GlobalView().textViewWithCenterAlign(
                          AppMessages.notifications_text,
                          AppTextStyle.inter_font_family,
                          AppTextStyle.bold_font_weight,
                          BaseColor.black_color,
                          18),
                    ),
                    Expanded(child: notificationListView(context)),
                  ],
                ),
                Positioned(
                  left: 20,
                  top: 57,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      AppImages.ic_back,
                      height: 25,
                      width: 25,
                    ),
                  ),
                ),
                Positioned(
                  child: Visibility(
                    visible:
                        Provider.of<NotificationsProvider>(context).isLoading,
                    child: Container(
                      // color: BaseColor.loader_bg_color,
                      child: GlobalView().loaderView(),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget notificationListView(BuildContext context) =>
      //  Visibility(
      //       visible: Provider.of<NotificationsProvider>(context)
      //           .iaAvailableNotificationData,
      //       child:
      Consumer<NotificationsProvider>(builder: (_, provider, child) {
        if (provider.listNotifiedUserInfo.isNotEmpty) {
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: ListView.builder(
                  controller: scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: provider.listNotifiedUserInfo.length,
                  itemBuilder: (_, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GlobalView().textViewWithStartAlign(
                                provider.listNotifiedUserInfo[index]
                                            .description !=
                                        null
                                    ? provider
                                        .listNotifiedUserInfo[index].description!
                                    : "Lorem ipsum dolor sit amet, consetetur drowny sadipscing elitr, sed diam nonumy eirmod.",
                                AppTextStyle.inter_font_family,
                                AppTextStyle.medium_font_weight,
                                BaseColor.black_color,
                                16),
                            GlobalView().textViewWithStartAlign(
                                DayTimeUtils().convertToAgo(provider
                                    .listNotifiedUserInfo[index].createdAt!),
                                AppTextStyle.inter_font_family,
                                AppTextStyle.medium_font_weight,
                                BaseColor.black_color.withOpacity(0.5),
                                12),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          );
        } else {
          return Visibility(
            visible: provider.isAvailableNotificationData,
            child: Container(
              child: Center(
                child: GlobalView().textViewWithCenterAlign(
                    AppMessages.no_notifications_text,
                    AppTextStyle.inter_font_family,
                    AppTextStyle.bold_font_weight,
                    BaseColor.black_color,
                    18),
              ),
            ),
          );
        }
      }
          // ),
          );
}
