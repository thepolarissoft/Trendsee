// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';

import 'global_view.dart';

class MultilineCategoryTextfield extends StatelessWidget {
  MultilineCategoryTextfield({
    Key key,
    @required this.controller,
    this.onClick,
    this.prefixIcon,
    this.hintText,
  }) : super(key: key);
  TextEditingController controller;
  VoidCallback onClick;
  Widget prefixIcon;
  String hintText;
  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: BaseColor.shadow_color,
      elevation: 4,
      borderRadius: BorderRadius.circular(25),
      child: TextField(
        onTap: () {
          onClick();
        },
        readOnly: true,
        controller: controller,
        cursorColor: BaseColor.border_txtfield_color,
        minLines: 1,
        maxLines: 3,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: BaseColor.hint_color,
          fontFamily: AppTextStyle.inter_font_family,
          fontSize: 14,
        ),
        // textAlign: AppTextStyle.start_text_align,
        decoration: InputDecoration(
          isDense: true,
          focusColor: BaseColor.pure_white_color,
          contentPadding: EdgeInsets.only(left: 60, right: -30),
          prefixIcon:
              prefixIcon ?? GlobalView().prefixIconView(AppImages.ic_category),
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
          hintText: hintText ?? AppMessages.hint_category_name,
          hintStyle: TextStyle(
            color: BaseColor.hint_color.withOpacity(0.6),
            fontFamily: AppTextStyle.inter_font_family,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
