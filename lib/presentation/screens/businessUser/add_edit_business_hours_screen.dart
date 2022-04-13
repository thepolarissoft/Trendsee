// ignore_for_file: must_be_immutable

import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/data/models/time_zone_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/business_user_provider.dart';
import 'package:trendoapp/utils/day_time_utils.dart';

class AddEditBusinessHoursScreen extends StatefulWidget {
  AddEditBusinessHoursScreen({Key key}) : super(key: key);

  @override
  State<AddEditBusinessHoursScreen> createState() =>
      _AddEditBusinessHoursScreenState();
}

class _AddEditBusinessHoursScreenState
    extends State<AddEditBusinessHoursScreen> {
  bool iosStyle = true;

  void onTimeChanged(TimeOfDay newTime, TextEditingController controller) {
    setState(() {
      // _time = newTime;
      controller.text = newTime.toString();
    });
  }

  TextEditingController businessTimeZoneController = TextEditingController();

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
                          padding: EdgeInsets.only(top: 16),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child:
                                //  Consumer<BusinessListProvider>(
                                //     builder: (_, location, child) {
                                //   return
                                Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                GlobalView().sizedBoxView(
                                    DeviceSize().deviceHeight(context) * 0.052),
                                Container(
                                  alignment: Alignment.topCenter,
                                  child: GlobalView().textViewWithCenterAlign(
                                      AppMessages.business_hours_text,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.bold_font_weight,
                                      BaseColor.black_color,
                                      18),
                                ),
                                GlobalView().sizedBoxView(
                                    DeviceSize().deviceHeight(context) * 0.02),
                                GlobalView().textViewWithCenterAlign(
                                    AppMessages.business_timezone_text,
                                    AppTextStyle.inter_font_family,
                                    AppTextStyle.normal_font_weight,
                                    BaseColor.black_color.withOpacity(0.5),
                                    11),
                                GlobalView().sizedBoxView(5),
                                timezoneSelectionView(),
                                GlobalView().sizedBoxView(20),
                                GlobalView().textViewWithCenterAlign(
                                    AppMessages.hours_text,
                                    AppTextStyle.inter_font_family,
                                    AppTextStyle.normal_font_weight,
                                    BaseColor.black_color.withOpacity(0.5),
                                    14),
                                GlobalView().sizedBoxView(5),
                                Expanded(child: weekWiseAddEditHours()),
                                GlobalView().sizedBoxView(20),
                                Consumer<BusinessUserProvider>(
                                  builder: (context, provider, child) {
                                    return GestureDetector(
                                      onTap: () {
                                        DayTimeUtils().convertLocalToUtc(
                                          list: provider.listBusinessHours,
                                          context: context,
                                          isOpenTime: true,
                                        );
                                        DayTimeUtils().convertLocalToUtc(
                                          list: provider.listBusinessHours,
                                          context: context,
                                          isOpenTime: false,
                                        );
                                        isEmptyValue()
                                            ? GlobalView().showToast(
                                                AppToastMessages
                                                    .select_both_message)
                                            : Provider.of<BusinessUserProvider>(
                                                    context,
                                                    listen: false)
                                                .addBusinessHours(context);
                                      },
                                      child: GlobalView().buttonFilled(
                                          context,
                                          // Provider.of<BusinessUserProvider>(context,
                                          //             listen: false)
                                          //         .businessUserProfileResponse
                                          //         .user
                                          //         .businessHours
                                          //         .isEmpty
                                          //     ? AppMessages.add_text
                                          //     : AppMessages.edit_text
                                          AppMessages.submit_btn_text),
                                    );
                                  },
                                ),
                              ],
                              //   );
                              // }
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    child: Visibility(
                      visible:
                          Provider.of<BusinessUserProvider>(context).isLoading,
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

  bool isEmptyValue() {
    bool isEmpty = false;
    var provider = Provider.of<BusinessUserProvider>(context, listen: false);
    for (var i = 0; i < provider.listBusinessHours.length; i++) {
      if (provider.listBusinessHours[i].isOpen) {
        print("Open time-> ${provider.listBusinessHours[i].openTime}");
        print("Close time-> ${provider.listBusinessHours[i].closeTime}");
        if ((provider.listBusinessHours[i].openTime == "-1" ||
            provider.listBusinessHours[i].closeTime == "-1")) {
          isEmpty = true;
          break;
        }
      }
    }
    return isEmpty;
  }

  Widget timezoneSelectionView() {
    return Consumer<BusinessUserProvider>(builder: (_, provider, child) {
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
                  child: GlobalView().prefixIconView(AppImages.ic_calendar),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<TimezoneInfo>(
                        isExpanded: true,
                        value: provider.selectedTimeZone,
                        iconSize: 25,
                        icon: Icon(Icons.arrow_drop_down,
                            color: BaseColor.border_txtfield_color, size: 25),
                        items: [
                          for (var i = 0;
                              i < provider.timeZoneResponse.timeZone.length;
                              i++)
                            provider.timeZoneResponse.timeZone[i]
                        ].map((v) {
                          return DropdownMenuItem<TimezoneInfo>(
                              value: v,
                              child: GlobalView().textViewWithStartAlign(
                                  v.value,
                                  AppTextStyle.inter_font_family,
                                  AppTextStyle.normal_font_weight,
                                  BaseColor.hint_color,
                                  14));
                        }).toList(),
                        hint: new GlobalView().textViewWithCenterAlign(
                            AppMessages.business_timezone_text,
                            AppTextStyle.inter_font_family,
                            AppTextStyle.normal_font_weight,
                            BaseColor.hint_color.withOpacity(0.6),
                            14),
                        onChanged: (value) {
                          // provider.selectedCategory = selectedValue;
                          provider.setTimezoneValue(value);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )),
      );
    });
  }

  Widget weekWiseAddEditHours() {
    return Consumer<BusinessUserProvider>(builder: (_, provider, child) {
      return MediaQuery.removePadding(
        removeTop: true,
        removeBottom: true,
        context: context,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: provider.listBusinessHours.length,
            itemBuilder: (_, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GlobalView().textViewWithStartAlign(
                              DayTimeUtils().getDay(
                                  provider.listBusinessHours[index].dayNumber),
                              AppTextStyle.inter_font_family,
                              AppTextStyle.medium_font_weight,
                              BaseColor.black_color,
                              18),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlutterSwitch(
                                width: 48,
                                height: 26,
                                value: provider.listBusinessHours[index].isOpen,
                                // value: provider.listBusinessHours[index].openTime ==
                                //             "-1" &&
                                //         provider.listBusinessHours[index].closeTime ==
                                //             "-1"
                                //     ? false
                                //     : true,
                                borderRadius: 20,
                                padding: 4,
                                activeColor: BaseColor.btn_gradient_end_color2,
                                // showOnOff: true,
                                onToggle: (value) {
                                  provider.setBusinessHourSwitchValue(index,
                                      provider.listBusinessHours[index], value);
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  child: GlobalView().textViewWithStartAlign(
                                      provider.listBusinessHours[index].isOpen
                                          ? AppMessages.open_text
                                          : AppMessages.closed_text,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.normal_font_weight,
                                      BaseColor.black_color,
                                      16))
                            ],
                          ),
                        )
                      ],
                    ),
                    Visibility(
                        visible: provider.listBusinessHours[index].isOpen
                            ? true
                            : false,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Row(
                            children: [
                              Expanded(
                                child: Consumer<BusinessUserProvider>(
                                    builder: (context, provider, widget) {
                                  // openBusinessTimeController.text = provider
                                  //     .listBusinessHours[index].openTime;
                                  // return selectTimeView(
                                  //     openBusinessTimeController,
                                  //     AppMessages.open_time_text, () {
                                  //   Navigator.of(context).push(
                                  //     showPicker(
                                  //         context: context,
                                  //         value: provider.openTime,
                                  //         onChange: (TimeOfDay _time) {
                                  //           // openBusinessTimeController.text =
                                  //           //     _time.format(context);
                                  //           provider.setOpenCloseTimeValue(
                                  //               _time, true);
                                  //           provider
                                  //               .setBusineddHoursOpenCloseValue(
                                  //                   true,
                                  //                   provider.listBusinessHours[
                                  //                       index],
                                  //                   _time);
                                  //         }),
                                  //   );
                                  // });
                                  return selectOpenTimeButton(() {
                                    Navigator.of(context).push(
                                      showPicker(
                                          context: context,
                                          value: provider.openTime,
                                          onChange: (TimeOfDay _time) {
                                            // openBusinessTimeController.text =
                                            //     _time.format(context);
                                            // provider.setOpenCloseTimeValue(
                                            //     _time, true);
                                            provider
                                                .setBusineddHoursOpenCloseValue(
                                                    true,
                                                    provider.listBusinessHours[
                                                        index],
                                                    _time,
                                                    context);
                                          }),
                                    );
                                  },
                                      provider
                                          .listBusinessHours[index].openTime);
                                }),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Consumer<BusinessUserProvider>(
                                    builder: (context, provider, widget) {
                                  return selectCloseTimeButton(() {
                                    Navigator.of(context).push(
                                      showPicker(
                                          context: context,
                                          value: provider.closeTime,
                                          onChange: (TimeOfDay _time) {
                                            // openBusinessTimeController.text =
                                            //     _time.format(context);
                                            // provider.setOpenCloseTimeValue(
                                            //     _time, false);
                                            provider
                                                .setBusineddHoursOpenCloseValue(
                                                    false,
                                                    provider.listBusinessHours[
                                                        index],
                                                    _time,
                                                    context);
                                          }),
                                    );
                                  },
                                      provider
                                          .listBusinessHours[index].closeTime);
                                }),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              );
            }),
      );
    });
  }

  Widget selectOpenTimeButton(Function onClick, String data) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: BaseColor.border_txtfield_color)),
        child: Center(
          child: GlobalView().textViewWithStartAlign(
              data == "-1" ? AppMessages.open_time_text : data,
              AppTextStyle.inter_font_family,
              AppTextStyle.normal_font_weight,
              BaseColor.hint_color,
              14),
        ),
      ),
    );
  }

  Widget selectCloseTimeButton(Function onClick, String data) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: BaseColor.border_txtfield_color)),
        child: Center(
          child: GlobalView().textViewWithStartAlign(
              data == "-1" ? AppMessages.close_time_text : data,
              AppTextStyle.inter_font_family,
              AppTextStyle.normal_font_weight,
              BaseColor.hint_color,
              14),
        ),
      ),
    );
  }
  // GlobalView().sizedBoxView(20),
  // GlobalView().textViewWithCenterAlign(
  //     AppMessages.business_open_time_text,
  //     AppTextStyle.inter_font_family,
  //     AppTextStyle.normal_font_weight,
  //     BaseColor.black_color.withOpacity(0.5),
  //     11),
  // GlobalView().sizedBoxView(5),
  // Consumer<BusinessUserProvider>(
  //     builder: (context, provider, widget) {
  //   return selectTimeView(
  //       openBusinessTimeController,
  //       AppMessages.business_open_time_text, () {
  //     Navigator.of(context).push(
  //       showPicker(
  //           context: context,
  //           value: provider.openTime,
  //           onChange: (TimeOfDay _time) {
  //             openBusinessTimeController.text =
  //                 _time.format(context);
  //             provider.setOpenCloseTimeValue(
  //                 _time, true);
  //           }),
  //     );
  //   });
  // }),
  // GlobalView().sizedBoxView(20),
  // GlobalView().textViewWithCenterAlign(
  //     AppMessages.business_close_time_text,
  //     AppTextStyle.inter_font_family,
  //     AppTextStyle.normal_font_weight,
  //     BaseColor.black_color.withOpacity(0.5),
  //     11),
  // GlobalView().sizedBoxView(5),
  // Consumer<BusinessUserProvider>(
  //     builder: (context, provider, widget) {
  //   return selectTimeView(
  //       closeBusinessTimeController,
  //       AppMessages.business_close_time_text, () {
  //     Navigator.of(context).push(
  //       showPicker(
  //           context: context,
  //           value: provider.closeTime,
  //           onChange: (TimeOfDay _time) {
  //             closeBusinessTimeController.text =
  //                 _time.format(context);
  //             provider.setOpenCloseTimeValue(
  //                 _time, false);
  //           }),
  //     );
  //     // showTimePicker(
  //     //     context: context,
  //     //     initialTime: TimeOfDay.now());
  //   });
  // }),
}

// class WeekWiseAddEditHours extends StatefulWidget {
//   WeekWiseAddEditHours({Key key}) : super(key: key);

//   @override
//   State<WeekWiseAddEditHours> createState() => _WeekWiseAddEditHoursState();
// }

// class _WeekWiseAddEditHoursState extends State<WeekWiseAddEditHours> {
//   TextEditingController openBusinessTimeController = TextEditingController();

//   TextEditingController closeBusinessTimeController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     // openBusinessTimeController.text=Provider<BusinessUserProvider>.of(context,listen:false).l
//     // openBusinessTimeController.text = "Open";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BusinessUserProvider>(builder: (_, provider, child) {
//       return MediaQuery.removePadding(
//         removeTop: true,
//         removeBottom: true,
//         context: context,
//         child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: provider.listBusinessHours.length,
//             itemBuilder: (_, index) {
//               return Container(
//                 padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: GlobalView().textViewWithStartAlign(
//                               DayTimeUtils().getDay(
//                                   provider.listBusinessHours[index].dayNumber),
//                               AppTextStyle.inter_font_family,
//                               AppTextStyle.medium_font_weight,
//                               BaseColor.black_color,
//                               18),
//                         ),
//                         Expanded(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               FlutterSwitch(
//                                 width: 48,
//                                 height: 26,
//                                 value: provider.listBusinessHours[index].isOpen,
//                                 // value: provider.listBusinessHours[index].openTime ==
//                                 //             "-1" &&
//                                 //         provider.listBusinessHours[index].closeTime ==
//                                 //             "-1"
//                                 //     ? false
//                                 //     : true,
//                                 borderRadius: 20,
//                                 padding: 4,
//                                 activeColor: BaseColor.btn_gradient_end_color2,
//                                 // showOnOff: true,
//                                 onToggle: (value) {
//                                   provider.setBusinessHourSwitchValue(
//                                       provider.listBusinessHours[index], value);
//                                 },
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Expanded(
//                                   child: GlobalView().textViewWithStartAlign(
//                                       provider.listBusinessHours[index].isOpen
//                                           ? AppMessages.open_text
//                                           : AppMessages.closed_text,
//                                       AppTextStyle.inter_font_family,
//                                       AppTextStyle.normal_font_weight,
//                                       BaseColor.black_color,
//                                       16))
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                     Visibility(
//                         visible: provider.listBusinessHours[index].isOpen
//                             ? true
//                             : false,
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 6),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Consumer<BusinessUserProvider>(
//                                     builder: (context, provider, widget) {
                                 
//                                   return selectOpenTimeButton(() {
//                                     Navigator.of(context).push(
//                                       showPicker(
//                                           context: context,
//                                           value: provider.openTime,
//                                           onChange: (TimeOfDay _time) {
//                                             // openBusinessTimeController.text =
//                                             //     _time.format(context);
//                                             provider.setOpenCloseTimeValue(
//                                                 _time, true);
//                                             provider
//                                                 .setBusineddHoursOpenCloseValue(
//                                                     true,
//                                                     provider.listBusinessHours[
//                                                         index],
//                                                     _time);
//                                           }),
//                                     );
//                                   },
//                                       provider
//                                           .listBusinessHours[index].openTime);
//                                 }),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Expanded(
//                                 child: Consumer<BusinessUserProvider>(
//                                     builder: (context, provider, widget) {
//                                   // closeBusinessTimeController.text = provider
//                                   //     .listBusinessHours[index].closeTime;
//                                   // return selectTimeView(
//                                   //     closeBusinessTimeController,
//                                   //     AppMessages.close_time_text, () {
//                                   //   Navigator.of(context).push(
//                                   //     showPicker(
//                                   //         context: context,
//                                   //         value: provider.closeTime,
//                                   //         onChange: (TimeOfDay _time) {
//                                   //           // closeBusinessTimeController.text =
//                                   //           //     _time.format(context);
//                                   //           provider.setOpenCloseTimeValue(
//                                   //               _time, false);
//                                   //           provider
//                                   //               .setBusineddHoursOpenCloseValue(
//                                   //                   false,
//                                   //                   provider.listBusinessHours[
//                                   //                       index],
//                                   //                   _time);
//                                   //         }),
//                                   //   );
//                                   // });
//                                   return selectCloseTimeButton(() {
//                                     Navigator.of(context).push(
//                                       showPicker(
//                                           context: context,
//                                           value: provider.closeTime,
//                                           onChange: (TimeOfDay _time) {
//                                             // openBusinessTimeController.text =
//                                             //     _time.format(context);
//                                             provider.setOpenCloseTimeValue(
//                                                 _time, false);
//                                             provider
//                                                 .setBusineddHoursOpenCloseValue(
//                                                     false,
//                                                     provider.listBusinessHours[
//                                                         index],
//                                                     _time);
//                                           }),
//                                     );
//                                   },
//                                       provider
//                                           .listBusinessHours[index].closeTime);
//                                 }),
//                               ),
//                             ],
//                           ),
//                         )),
//                   ],
//                 ),
//               );
//             }),
//       );
//     });
//   }

//   Widget selectOpenTimeButton(Function onClick, String data) {
//     return GestureDetector(
//       onTap: onClick,
//       child: Container(
//         height: 50,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(color: BaseColor.border_txtfield_color)),
//         child: Center(
//           child: GlobalView().textViewWithStartAlign(
//               data=="-1"?AppMessages.open_time_text:data,
//               AppTextStyle.inter_font_family,
//               AppTextStyle.normal_font_weight,
//               BaseColor.hint_color,
//               14),
//         ),
//       ),
//     );
//   }
// Widget selectCloseTimeButton(Function onClick, String data) {
//     return GestureDetector(
//       onTap: onClick,
//       child: Container(
//         height: 50,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(color: BaseColor.border_txtfield_color)),
//         child: Center(
//           child: GlobalView().textViewWithStartAlign(
//                data == "-1" ? AppMessages.close_time_text : data,
//               AppTextStyle.inter_font_family,
//               AppTextStyle.normal_font_weight,
//               BaseColor.hint_color,
//               14),
//         ),
//       ),
//     );
//   }
//   Widget selectTimeView(
//       TextEditingController controller, String hintText, VoidCallback onTap) {
//     return Material(
//       shadowColor: BaseColor.shadow_color,
//       elevation: 4,
//       borderRadius: BorderRadius.circular(25),
//       child: TextField(
//         readOnly: true,
//         controller: controller,
//         cursorColor: BaseColor.border_txtfield_color,
//         style: TextStyle(
//           color: BaseColor.hint_color,
//           fontFamily: AppTextStyle.inter_font_family,
//           fontSize: 14,
//         ),
//         textAlign: TextAlign.start,
//         onTap: () {
//           onTap();
//         },
//         decoration: InputDecoration(
//           isDense: true,
//           focusColor: BaseColor.pure_white_color,
//           // contentPadding: EdgeInsets.only(left: 60, right: -40),
//           // prefixIcon: GlobalView().prefixIconView(
//           //   AppImages.ic_calendar,
//           // ),
//           //  prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide(color: BaseColor.border_txtfield_color),
//           ),
//           disabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(25),
//               borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(25),
//               borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(25),
//               borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
//           hintText: hintText,
//           hintStyle: TextStyle(
//             color: BaseColor.hint_color.withOpacity(0.6),
//             fontFamily: AppTextStyle.inter_font_family,
//             fontSize: 14,
//           ),
//         ),
//       ),
//     );
//   }
// }
