import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';

class AppSearchTextField extends StatelessWidget {
  const AppSearchTextField(
      {super.key,
        required this.hintText,
        this.color,
        this.hintStyle,
        this.validator,
        this.filled = false,
        this.prefix = true,
        this.height,
        this.contentPadding,
        this.borderEnable = true,
        this.inputFormatters,
        this.keyboardType,
        required this.controller,
        this.onChanged,
      });
  final String hintText;
  final bool borderEnable;
  final double? height;
  final TextEditingController controller;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final Color? color;
  final bool filled;
  final bool prefix;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;


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
      cursorErrorColor: AppColor.neutral_600,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      inputFormatters: inputFormatters ?? [RemoveEmojiInputFormatter()],
      style: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.white),
      decoration: InputDecoration(
        prefixIcon: prefix ? SizedBox(
          height: Dimensions.h_10,
            width: Dimensions.h_10,
            child: Image.asset('assets/search.png',scale: 4,)) : const SizedBox.shrink(),
          fillColor: color ?? Theme.of(context).cardColor,
          filled: filled,
          isCollapsed: true,
          counterText: ' ',
          contentPadding: contentPadding ??  EdgeInsets.only(top: Dimensions.h_10,bottom: Dimensions.h_10,left: Dimensions.w_20),
          enabledBorder: OutlineInputBorder(
            borderSide:  borderEnable ? BorderSide(color: Theme.of(context).shadowColor.withOpacity(0.3)) : const BorderSide(color: AppColor.transparent),
            borderRadius: BorderRadius.circular(Dimensions.h_25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:  borderEnable ? BorderSide(color: Theme.of(context).shadowColor.withOpacity(0.3)) : const BorderSide(color: AppColor.transparent),
            borderRadius: BorderRadius.circular(Dimensions.h_25),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:  borderEnable ? const BorderSide(width: 1, color: AppColor.neutral_600) : const BorderSide(color: AppColor.transparent),
            borderRadius: BorderRadius.circular(Dimensions.h_25),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: borderEnable ? BorderSide(color: Theme.of(context).shadowColor.withOpacity(0.3)) : const BorderSide(color: AppColor.transparent),
            borderRadius: BorderRadius.circular(Dimensions.h_25),
          ),
          border: OutlineInputBorder(
            borderSide:  borderEnable ? BorderSide(color: Theme.of(context).shadowColor.withOpacity(0.3)) : const BorderSide(color: AppColor.transparent),
            borderRadius: BorderRadius.circular(Dimensions.h_25),
          ),
          errorStyle: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.red),
          hintText: hintText,
          hintStyle: hintStyle ?? AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.neutral_400)),
    );
  }
}