import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  final double? height;
  final EdgeInsetsGeometry? margin;
  final String title;
  final double? borderRadius;
  final bool loading ;
  final  TextStyle? style;
  final void Function()? onTap;
  const AppButton({super.key, this.style,this.height,this.borderRadius, this.margin, required this.title, this.onTap, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: loading ? null : onTap,
            child: Container(
                margin: margin ?? EdgeInsets.only(left: Dimensions.w_10,right: Dimensions.w_10,top: Dimensions.h_10),
                height: height ?? Dimensions.h_40,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient:  const LinearGradient(
                        begin: Alignment.topLeft,
                        end:Alignment.bottomRight,
                        colors: [
                          Color(0xFFBD8C2A),
                          Color(0xFFF3E166),

                        ]),
                    borderRadius:  BorderRadius.circular(borderRadius ?? Dimensions.h_25)
                ),
                child: Center(child: loading ? const CupertinoActivityIndicator() : AppTextWidget(title: title, style: AppTextStyle.buttonTextStyle(color:  AppColor.black)))
            ),
          );
        }

  }
