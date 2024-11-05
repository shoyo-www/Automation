import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      required this.hintText,
        this.color,
        this.hintStyle,
        this.validator,
        this.height,
        this.contentPadding,
        this.borderEnable = true,
        this.inputFormatters,
        this.keyboardType,
        this.maxLines,
        required this.title,
        required this.controller,
        this.onChanged,
        this.radius,
        this.textStyle
      });
  final String hintText;
  final String title;
  final bool borderEnable;
  final double? height;
  final TextEditingController controller;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final Color? color;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final int? maxLines;
  final double? radius;
  final TextStyle? textStyle;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      cursorColor: Theme.of(context).shadowColor,
      controller: controller,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onChanged: onChanged,
      style: textStyle ?? AppTextStyle.normalTextStyle(FontSize.sp_14, AppColor.white),
      maxLines: maxLines ?? 1,
      cursorErrorColor: AppColor.neutral_600,
      cursorHeight: Dimensions.h_15,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      inputFormatters: inputFormatters ?? [RemoveEmojiInputFormatter()],
      decoration: InputDecoration(
          fillColor: color ?? Theme.of(context).cardColor,
          filled: true,
          isCollapsed: true,
          counterText: ' ',
        contentPadding: contentPadding ??  EdgeInsets.only(top: Dimensions.h_10,bottom: Dimensions.h_10,left: Dimensions.w_20),
          enabledBorder: OutlineInputBorder(
            borderSide:  borderEnable ? BorderSide(color: Theme.of(context).shadowColor.withOpacity(0.3)) : const BorderSide(color: AppColor.transparent),
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:  borderEnable ? BorderSide(color: Theme.of(context).shadowColor.withOpacity(0.3)) : const BorderSide(color: AppColor.transparent),
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:  borderEnable ? const BorderSide(width: 1, color: AppColor.neutral_600) : const BorderSide(color: AppColor.transparent),
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: borderEnable ? BorderSide(color: Theme.of(context).shadowColor.withOpacity(0.3)) : const BorderSide(color: AppColor.transparent),
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
          border: OutlineInputBorder(
            borderSide:  borderEnable ? BorderSide(color: Theme.of(context).shadowColor.withOpacity(0.3)) : const BorderSide(color: AppColor.transparent),
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
          errorStyle: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.red),
          hintText: hintText,
          hintStyle: hintStyle ?? AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.neutral_600)),
    );
  }
}


