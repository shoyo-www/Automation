import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/constants/images.dart';
import 'package:hotelautomationapp/data/datasource/local/local_storage.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/appbutton.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaColor: AppColor.darkScaffold,
      bottom: false,
      body: Column(
        children: [
          Container(
            height: Dimensions.h_450,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(image:AssetImage(Images.onBoarding),fit: BoxFit.cover),
            )
          ),
          VerticalSpacing(height: Dimensions.h_30),
          AppTextWidget(textAlign: TextAlign.center,title: Constants.onBoarding, style: AppTextStyle.normalTextStyle(
            FontSize.sp_15, AppColor.white
          )),
          const Spacer(),
          AppButton(title: LocalStorage.getBool(GetXStorageConstants.isLogin) == true ? "Let's Started" : 'Login',margin: EdgeInsets.symmetric(horizontal: Dimensions.w_40,),onTap: () {
            LocalStorage.writeBool(GetXStorageConstants.onBoarding, true);
            LocalStorage.getBool(GetXStorageConstants.isLogin) == true ? Get.toNamed(AppRoutes.dashBoard): Get.toNamed(AppRoutes.login);
          },),
          VerticalSpacing(height: Dimensions.h_20),

        ],
      ),
    );
  }
}
