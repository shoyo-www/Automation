import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'fontsize.dart';

class AppTextStyle {
  static TextStyle normalTextStyle(double fontSize, Color textColor,{FontWeight? weight,FontStyle? style,TextDecoration? decoration}) {
    return GoogleFonts.inter(
        fontSize: fontSize,
        color: textColor,
        decorationColor: AppColor.appColor,
        decoration: decoration,
        fontStyle: style ?? FontStyle.normal,
        fontWeight: weight ?? FontWeight.w200
    );
  }

  static TextStyle themeBoldTextStyle({double? fontSize ,Color? color}) {
    return GoogleFonts.inter(
        fontSize: fontSize ?? FontSize.sp_24,
        color: color ?? Colors.black,
        fontWeight: FontWeight.bold
    );

  }
  static TextStyle themeBoldNormalTextStyle({double? fontSize ,Color? color}) {
    return  GoogleFonts.inter(
        fontSize: fontSize ?? FontSize.sp_24,
        color: color ?? Colors.black,
        fontWeight: FontWeight.w600
    );


  }
  static buttonTextStyle({Color? color,double? fontSize}) =>  GoogleFonts.inter(
      fontSize: fontSize ?? FontSize.sp_16,
      color: color ?? AppColor.white,
      fontWeight: FontWeight.w500
  );

  static bodyMediumTextStyle({Color? color}) =>  GoogleFonts.inter(
      fontSize: FontSize.sp_13,
      color: color ?? Colors.black,
      fontWeight: FontWeight.w500
  );
}