import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/appbutton.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';

class ReceptionScreen extends StatelessWidget {
  const ReceptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) { 
            if(orientation == Orientation.portrait) {
              return Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.w_12, right: Dimensions.w_12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const CommonAppbar(),
                    VerticalSpacing(height: Dimensions.h_8),
                    AppTextWidget(title: 'Contact the Hotel\nReceptionist',
                        style: AppTextStyle.themeBoldNormalTextStyle(
                            fontSize: FontSize.sp_24, color: AppColor.white)),
                    VerticalSpacing(height: Dimensions.h_10),
                    AppTextWidget(textOverflow: TextOverflow.visible,maxLines : 5,title: "We hope you're enjoying your stay with us! Our team is dedicated to ensuring your comfort and satisfaction throughout your time here. If you have any questions, doubts, or require assistance with anything at all, please don't hesitate to reach out to us",
                        style: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.neutral_400)),
                    const Spacer(),
                    Center(child: Image.asset('assets/chat.png',scale: 4)),
                    const Spacer(),
                    AppButton(onTap: () {
                      Get.toNamed(AppRoutes.chatScreen);
                    },title: 'Continue -->'),
                    VerticalSpacing(height: Dimensions.h_20)
                  ],
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.w_12, right: Dimensions.w_12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const CommonAppbar(),
                    VerticalSpacing(height: Dimensions.h_8),
                    AppTextWidget(title: 'Contact the Hotel\nReceptionist',
                        style: AppTextStyle.themeBoldNormalTextStyle(
                            fontSize: FontSize.sp_14, color: AppColor.white)),
                    VerticalSpacing(height: Dimensions.h_10),
                    AppTextWidget(textOverflow: TextOverflow.visible,maxLines : 5,title: "We hope you're enjoying your stay with us! Our team is dedicated to ensuring your comfort and satisfaction throughout your time here. If you have any questions, doubts, or require assistance with anything at all, please don't hesitate to reach out to us",
                        style: AppTextStyle.normalTextStyle(FontSize.sp_8, AppColor.neutral_400)),
                    VerticalSpacing(height: Dimensions.h_50),
                    Center(child: Image.asset('assets/chat.png',scale: 4)),
                    VerticalSpacing(height: Dimensions.h_50),
                    AppButton(style: AppTextStyle.buttonTextStyle(color: AppColor.black,fontSize: FontSize.sp_10),onTap: () {
                      Get.toNamed(AppRoutes.chatScreen);
                    },title: 'Continue -->'),
                    VerticalSpacing(height: Dimensions.h_20)
                  ],
                ),
              ),
            );
          },
        ));
  }
}
