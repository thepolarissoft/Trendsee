// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/data/models/verified_user_response.dart';
import 'package:trendoapp/providers/business_list_provider.dart';

import 'global_view.dart';

class BusinessSelectionView extends StatelessWidget {
  VerifiedUserResponse verifiedUserResponse;
  // Widget checkBoxView;
  // VoidCallback onClickCheckbox;
  int index;
  BusinessSelectionView({
    Key key,
    @required this.verifiedUserResponse,
    // @required this.onClickCheckbox,
    @required this.index,
    // @required this.checkBoxView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: GlobalView().textViewWithStartAlign(
                      verifiedUserResponse.businessName,
                      AppTextStyle.inter_font_family,
                      AppTextStyle.bold_font_weight,
                      BaseColor.black_color,
                      18),
                ),
                Container(
                  child: GlobalView().textViewWithStartAlign(
                      verifiedUserResponse.isMobile == 1
                          ? AppMessages.mobile_business_text
                          : verifiedUserResponse.isOnline == 0
                              ? verifiedUserResponse.businessAddress
                              : AppMessages.online_business_text,
                      AppTextStyle.inter_font_family,
                      AppTextStyle.normal_font_weight,
                      BaseColor.black_color.withOpacity(0.5),
                      16),
                ),
                GlobalView().sizedBoxView(5),
                GlobalView().textViewWithStartAlign(
                    AppMessages.within +
                        verifiedUserResponse.distance +
                        AppMessages.miles_from_text,
                    AppTextStyle.inter_font_family,
                    AppTextStyle.semi_bold_font_weight,
                    BaseColor.forgot_pass_txt_color,
                    12)
              ],
            ),
          ),
          // checkBoxView,
          Container(
            height: 25,
            padding: EdgeInsets.zero,
            // color: Colors.green,
            child: Theme(
              data: ThemeData(
                  unselectedWidgetColor: BaseColor.btn_gradient_end_color1,
                  backgroundColor: BaseColor.btn_gradient_end_color1),
              child: Checkbox(
                  value: verifiedUserResponse.isChecked,
                  checkColor: BaseColor.pure_white_color,
                  activeColor: BaseColor.btn_gradient_end_color1,
                  onChanged: (bool value) {
                    // onClickCheckbox();
                    // provider.changeCheckBoxValue(index, value);
                    Provider.of<BusinessListProvider>(context, listen: false)
                        .changeCheckBoxValue(index, value);
                    print(
                        "CHECKED value-->> ${Provider.of<BusinessListProvider>(context, listen: false).businessListResponse.business.data[index].isChecked = value}");
                    // setState(() {
                    //   checkValue = value;
                    // });
                  }),
              // CheckboxGroup(
              //     labels: listLocation,
              //     onSelected: (List<String> checked) =>
              //         print(checked.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
