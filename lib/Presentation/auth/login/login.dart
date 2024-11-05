import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/Presentation/auth/login/login_controller.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/appbutton.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';
import 'package:hotelautomationapp/widgets/appTextfield.dart';
import 'package:hotelautomationapp/widgets/validators.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return AppScaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(Dimensions.h_20),
            child: const SizedBox.expand()),
        body: Padding(
          padding: EdgeInsets.only(
              left: Dimensions.w_15,
              right: Dimensions.w_15,
              top: Dimensions.h_15),
          child: GetBuilder(
            id: ControllerBuilders.loginController,
            init: loginController,
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpacing(height: Dimensions.h_20),
                  AppTextWidget(
                      title: 'Login',
                      style: AppTextStyle.themeBoldTextStyle(
                          fontSize: FontSize.sp_26, color: AppColor.white)),
                  VerticalSpacing(height: Dimensions.h_8),
                  AppTextWidget(
                      title:
                          'Welcome back! Please enter your phone number to \naccess your account',
                      style: AppTextStyle.normalTextStyle(
                          FontSize.sp_12, AppColor.neutral_600)),
                  VerticalSpacing(height: Dimensions.h_15),
                  Form(
                      key: controller.formKey,
                      child: AppTextField(
                          validator: Validator.phoneNumberValidate.call,
                          keyboardType: TextInputType.number,
                          borderEnable: false,
                          hintText: 'Mobile Number',
                          title: '',
                          controller: controller.phoneCont)),
                  AppTextWidget(
                      title: "Don't have a account ? Sign in",
                      style: AppTextStyle.normalTextStyle(
                          FontSize.sp_12, AppColor.white)),
                  VerticalSpacing(height: Dimensions.h_50),
                  AppButton(
                    loading: controller.loading,
                    title: 'Login',
                    margin: EdgeInsets.zero,
                    onTap: () {
                      if(controller.formKey.currentState!.validate()) {
                        controller.login(context);
                      }
                    },
                  )
                ],
              );
            },
          ),
        ));
  }
}
