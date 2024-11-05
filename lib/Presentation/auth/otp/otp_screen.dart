import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/Presentation/auth/otp/otp_controller.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/constants/images.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/appbutton.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OtpController otpController = Get.put(OtpController());
    return  AppScaffold(
        body: Padding(
          padding: EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15,top: Dimensions.h_15),
          child: GetBuilder(
            init: otpController,
            id: ControllerBuilders.otpController,
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpacing(height: Dimensions.h_10),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: SizedBox(
                        height: Dimensions.h_25,
                        width: Dimensions.h_25,
                        child: Image.asset(Images.back)),
                  ),
                  VerticalSpacing(height: Dimensions.h_10),
                  AppTextWidget(title: '6-digit code', style: AppTextStyle.themeBoldTextStyle(
                      fontSize: FontSize.sp_26,
                      color: AppColor.white
                  )),
                  VerticalSpacing(height: Dimensions.h_8),
                  AppTextWidget(title: 'Code sent to +91 9876543210 unless you \nalready have an account', style: AppTextStyle.normalTextStyle(
                      FontSize.sp_12, AppColor.neutral_600
                  )),
                  VerticalSpacing(height: Dimensions.h_15),
                  PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: Dimensions.h_50,
                      fieldWidth: Dimensions.h_45,
                      inactiveFillColor: const Color(0xFF1A1A1A),
                      selectedFillColor: AppColor.darkCardColor,
                      activeFillColor: AppColor.darkCardColor,
                      activeColor: AppColor.darkCardColor,
                      activeBorderWidth: 0,
                      errorBorderColor: Colors.transparent,
                      selectedColor: AppColor.darkCardColor,
                      borderWidth: 0,
                      disabledColor: const Color(0xFF1A1A1A),
                      disabledBorderWidth: 0,
                      inactiveColor: const Color(0xFF1A1A1A),
                    ),
                    cursorColor: AppColor.white,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: controller.otpController,
                    keyboardType: TextInputType.number,
                    onCompleted: (v) {},
                    onChanged: (value) {},
                  ),
                  VerticalSpacing(height: Dimensions.h_10),
                  AppTextWidget(title: "Resend code in 00:18", style: AppTextStyle.normalTextStyle(
                      FontSize.sp_12, AppColor.neutral_600
                  )),
                  VerticalSpacing(height: Dimensions.h_10),
                  AppTextWidget(title: "Already have an account? Log in", style: AppTextStyle.normalTextStyle(
                      FontSize.sp_12, AppColor.white
                  )),
                  VerticalSpacing(height: Dimensions.h_50),
                  AppButton(loading: controller.loading,title: 'Verify',margin: EdgeInsets.zero,onTap: () {
                    controller.verifyOtp(context);
                  },)
                ],
              );
            },
          ),
        ));
  }
}
