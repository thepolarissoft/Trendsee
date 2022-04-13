// ignore_for_file: must_be_immutable, missing_return

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/providers/filter_provider.dart';

import '../global_view.dart';

class CityFilterView extends StatelessWidget {
  CityFilterView({
    Key key,
    // @required this.keyCity,
    @required this.citySearchController,
  }) : super(key: key);
  // AutoCompleteTextField searchCityTextField;
  // GlobalKey<AutoCompleteTextFieldState<String>> keyCity;
  //     new GlobalKey();
  TextEditingController citySearchController = TextEditingController();
  @override   
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(child: cityAutoCompleteTextFieldView(context)),
      ],
    );
  }

  Widget cityAutoCompleteTextFieldView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        GlobalView().textViewWithStartAlign(
            AppMessages.search_city_title,
            AppTextStyle.inter_font_family,
            AppTextStyle.normal_font_weight,
            BaseColor.forgot_pass_txt_color,
            18),
        GlobalView().sizedBoxView(10),
        Consumer<FilterProvider>(builder: (ctx, provider, child) {
          print("list City length->> ${provider.listCities}");
          return Theme(
            data: ThemeData(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: BaseColor.border_txtfield_color,
              ),
            ),
            child: Material(
                shadowColor: BaseColor.shadow_color,
                elevation: 4,
                borderRadius: BorderRadius.circular(25),
                child: TypeAheadField<String>(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: citySearchController,
                    autocorrect: false,
                    enableSuggestions: false,
                    style: TextStyle(
                      color: BaseColor.hint_color,
                      fontFamily: AppTextStyle.inter_font_family,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      // filled: true,
                      focusColor: BaseColor.pure_white_color,
                      contentPadding: EdgeInsets.only(left: 60, right: -40),
                      prefixIcon:
                          GlobalView().prefixIconView(AppImages.ic_location),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            BorderSide(color: BaseColor.border_txtfield_color),
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: BaseColor.border_txtfield_color)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: BaseColor.border_txtfield_color)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: BaseColor.border_txtfield_color)),
                      hintText: AppMessages.hint_city_name,
                      hintStyle: TextStyle(
                        color: BaseColor.hint_color.withOpacity(0.6),
                        fontFamily: AppTextStyle.inter_font_family,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    if (pattern.length >= 2)
                      return provider.searchByCity(context, pattern);
                  },
                  hideOnEmpty: true,
                  itemBuilder: (context, item) {
                    return searchItemView(
                        item, AppMessages.city_text.toLowerCase());
                  },
                  onSuggestionSelected: (item) {
                    print("ITEM NAME-> $item");
                    citySearchController.text = item;
                    provider.selectedCity(item);
                    print("AREA TEXT->${citySearchController.text}");
                    // provider.searchByCity(context);
                    // provider.changeEditableCityValue();
                    print("Suggestion-> $item");
                  },
                )),
          );
        }),
      ],
    );
  }

  Widget searchItemView(String data, String route) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: BaseColor.border_txtfield_color),
            child: Image.asset(
                route == AppMessages.area_text
                    ? AppImages.ic_metro
                    : AppImages.ic_location,
                height: 20,
                width: 20,
                color: BaseColor.pure_white_color),
          ),
          SizedBox(width: 10),
          Expanded(
            child:
                // GlobalView().textViewWithStartAlign(
                //     "item.name GlobalViewGlobalViewGlobalViewGlobalViewGlobalView",
                //     AppTextStyle.inter_font_family,
                //     AppTextStyle.normal_font_weight,
                //     BaseColor.black_color,
                //     14),
                Text(
              // "ABC Gold & silver jewellery manufacturer ABC Gold & silver jewellery manufacturer",
              data,
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: AppTextStyle.inter_font_family,
                fontWeight: AppTextStyle.normal_font_weight,
                color: BaseColor.black_color,
                fontSize: 14,
              ),
            ),
          ),
          Image.asset(AppImages.ic_back_search2,
              height: 15, width: 15, color: BaseColor.black_color),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
