import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/Presentation/lights_control/light_switch_controller.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/common_appbar.dart';
import 'package:hotelautomationapp/widgets/master_light.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';
import 'package:lottie/lottie.dart';

class LightControlScreen extends StatelessWidget {
  const LightControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LightSwitchController lightSwitchController = Get.put(LightSwitchController());
    return GetBuilder(
      id: ControllerBuilders.lightController,
      init: lightSwitchController,
      builder: (controller) {
        return AppScaffold(
          isLoading: controller.loading,
          body: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              if(orientation == Orientation.portrait) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.w_15, right: Dimensions.w_15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CommonAppbar(),
                        VerticalSpacing(height: Dimensions.h_8),
                        AppTextWidget(title: 'Light Control',
                            style: AppTextStyle.themeBoldNormalTextStyle(
                                fontSize: FontSize.sp_26, color: AppColor.white)),
                        VerticalSpacing(height: Dimensions.h_30),
                        Container(
                          height: Dimensions.h_55,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.w_10, vertical: Dimensions.h_5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.h_30),
                              border: Border.all(
                                  color: AppColor.neutral_600
                              )
                          ),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    VerticalSpacing(height: Dimensions.h_6),
                                    AppTextWidget(title: 'Master Switch',
                                        style: AppTextStyle.themeBoldNormalTextStyle(
                                            fontSize: FontSize.sp_12,
                                            color: AppColor.neutral_500)),
                                    AppTextWidget(
                                        title: 'Turn on master switch, to turn on all the lights.',
                                        style: AppTextStyle.normalTextStyle(
                                            FontSize.sp_10, AppColor.neutral_500)),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: Dimensions.h_5, bottom: Dimensions.h_5),
                                  child: AppSwitch(
                                    iconOff: CupertinoIcons.power,
                                    iconOn: CupertinoIcons.power,
                                    colorOn: AppColor.darkCardColor,
                                    colorOff: AppColor.darkCardColor,
                                    width: Dimensions.w_70,
                                    value: false,
                                    textOff: '',
                                    iconBackColor: AppColor.appColor,
                                    textOn: '',
                                    onChanged: (bool state) {},
                                    onDoubleTap: () {},
                                    onSwipe: () {},
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        VerticalSpacing(height: Dimensions.h_30),
                        controller.lightSwitch.isNotEmpty  ?  GridView.builder(
                            itemCount: controller.lightSwitch.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 1 / 1.1,
                                crossAxisSpacing: Dimensions.w_10,
                                mainAxisSpacing: Dimensions.h_10),
                            itemBuilder: (c, i) {
                              Map<String, dynamic> statusMap = json.decode(
                                  controller.lightSwitch[i].status ?? '');
                              String status = statusMap.values.toString();
                              String formated =status.replaceAll('(', '').replaceAll(')', '');
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: Dimensions.h_180,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColor.neutral_600,
                                          width: 0.5,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.w_12),
                                      height: Dimensions.h_180,
                                      decoration: BoxDecoration(
                                          border:  Border(
                                            top: BorderSide(
                                                color: formated == 'ON' ?  AppColor.appColor : AppColor.transparent, width: formated == 'ON' ? 2 : 0.2),
                                          ),
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(child: Image.asset(
                                              'assets/Group 484218.png', scale: 5)),
                                          VerticalSpacing(height: Dimensions.h_20),
                                          AppTextWidget(
                                              title: controller.lightSwitch[i].name ??
                                                  '',
                                              style: AppTextStyle.normalTextStyle(
                                                  FontSize.sp_14, AppColor.white,
                                                  weight: FontWeight.w500
                                              )),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              AppTextWidget(
                                                  title: 'Power $formated',
                                                  style: AppTextStyle.normalTextStyle(
                                                      FontSize.sp_11,
                                                      AppColor.neutral_300)),
                                              Transform.scale(
                                                  alignment: Alignment.centerRight,
                                                  scale: 0.7,
                                                  child: AbsorbPointer(
                                                    absorbing: controller.buttonLoading,
                                                    child: CupertinoSwitch(
                                                        activeColor: AppColor.appColor,
                                                        value: formated == "OFF" ? false : true,
                                                        onChanged: (e) {
                                                          controller.updateLight(context, controller.lightSwitch[i].channelid ?? '');
                                                        }),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }) : (controller.loading == false ) ? Center(
                          child: Column(
                            children: [
                              VerticalSpacing(height: Dimensions.h_50),
                              Lottie.asset(width: Dimensions.h_150,'assets/no_data_found.json',fit: BoxFit.cover,height: Dimensions.h_150),
                              AppTextWidget(title: 'Oops! No Lights Found ', style: AppTextStyle.themeBoldNormalTextStyle(
                                  color: AppColor.white,fontSize: FontSize.sp_16
                              ))
                            ],
                          ),
                        ) : const SizedBox.shrink()
                      ],
                    ),
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.w_15, right: Dimensions.w_15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonAppbar(),
                      VerticalSpacing(height: Dimensions.h_8),
                      AppTextWidget(title: 'Light Control',
                          style: AppTextStyle.themeBoldNormalTextStyle(
                              fontSize: FontSize.sp_15, color: AppColor.white)),
                      VerticalSpacing(height: Dimensions.h_30),
                      Container(
                        height: Dimensions.h_55,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_10, vertical: Dimensions.h_5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.h_30),
                            border: Border.all(
                                color: AppColor.neutral_600
                            )
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  VerticalSpacing(height: Dimensions.h_6),
                                  AppTextWidget(title: 'Master Switch',
                                      style: AppTextStyle.themeBoldNormalTextStyle(
                                          fontSize: FontSize.sp_7,
                                          color: AppColor.neutral_500)),
                                  AppTextWidget(
                                      title: 'Turn on master switch, to turn on all the lights.',
                                      style: AppTextStyle.normalTextStyle(
                                          FontSize.sp_6, AppColor.neutral_500)),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: Dimensions.h_5, bottom: Dimensions.h_5),
                                child: AppSwitch(
                                  iconOff: CupertinoIcons.power,
                                  iconOn: CupertinoIcons.power,
                                  colorOn: AppColor.darkCardColor,
                                  colorOff: AppColor.darkCardColor,
                                  width: Dimensions.w_70,
                                  value: false,
                                  textOff: '',
                                  iconBackColor: AppColor.appColor,
                                  textOn: '',
                                  onChanged: (bool state) {},
                                  onDoubleTap: () {},
                                  onSwipe: () {},
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      VerticalSpacing(height: Dimensions.h_30),
                      controller.lightSwitch.isNotEmpty  ?  GridView.builder(
                        padding: EdgeInsets.zero,
                          itemCount: controller.lightSwitch.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2/1,
                              mainAxisSpacing: Dimensions.h_10,
                              crossAxisSpacing: Dimensions.w_10,
                          ),
                          itemBuilder: (c, i) {
                            Map<String, dynamic> statusMap = json.decode(
                                controller.lightSwitch[i].status ?? '');
                            String status = statusMap.values.toString();
                            String formated =status.replaceAll('(', '').replaceAll(')', '');
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    margin: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColor.neutral_600,
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.w_12),
                                    decoration: BoxDecoration(
                                        border:  Border(
                                          top: BorderSide(
                                              color: formated == 'ON' ?  AppColor.appColor : AppColor.transparent, width: formated == 'ON' ? 2 : 0.2),
                                        ),
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(child: Image.asset(
                                            'assets/Group 484218.png', scale: 5)),
                                        VerticalSpacing(height: Dimensions.h_15),
                                        AppTextWidget(
                                            title: controller.lightSwitch[i].name ??
                                                '',
                                            style: AppTextStyle.normalTextStyle(
                                                FontSize.sp_8, AppColor.white,
                                                weight: FontWeight.w500
                                            )),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            AppTextWidget(
                                                title: 'Power $formated',
                                                style: AppTextStyle.normalTextStyle(
                                                    FontSize.sp_6,
                                                    AppColor.neutral_300)),
                                            Transform.scale(
                                                alignment: Alignment.centerRight,
                                                scale: 0.7,
                                                child: AbsorbPointer(
                                                  absorbing: controller.buttonLoading,
                                                  child: CupertinoSwitch(
                                                      activeColor: AppColor.appColor,
                                                      value: formated == "OFF" ? false : true,
                                                      onChanged: (e) {
                                                        controller.updateLight(context, controller.lightSwitch[i].channelid ?? '');
                                                      }),
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }) : (controller.loading == false ) ? Center(
                        child: Column(
                          children: [
                            VerticalSpacing(height: Dimensions.h_50),
                            Lottie.asset(width: Dimensions.h_150,'assets/no_data_found.json',fit: BoxFit.cover,height: Dimensions.h_150),
                            AppTextWidget(title: 'Oops! No Lights Found ', style: AppTextStyle.themeBoldNormalTextStyle(
                                color: AppColor.white,fontSize: FontSize.sp_16
                            ))
                          ],
                        ),
                      ) : const SizedBox.shrink()
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
    );
  }
}
