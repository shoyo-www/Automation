import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/Presentation/aircon/aircon_controller.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/common_appbar.dart';
import 'package:hotelautomationapp/widgets/slider/slider.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';

class AirConScreen extends StatefulWidget {
  const AirConScreen({super.key});

  @override
  State<AirConScreen> createState() => _AirConScreenState();
}

class _AirConScreenState extends State<AirConScreen> {
  AirConController airConController = Get.put(AirConController());


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: airConController,
      builder: (controller) {
        return AppScaffold(
          isLoading: controller.loading,
            body: OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                if(orientation == Orientation.portrait) {
                  return Padding(
                    padding: EdgeInsets.only(left: Dimensions.w_10,right: Dimensions.w_10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CommonAppbar(),
                        VerticalSpacing(height: Dimensions.h_8),
                        AppTextWidget(title: 'Air Conditioner', style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_26,color:  AppColor.white)),
                        VerticalSpacing(height: Dimensions.h_30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10,vertical: Dimensions.h_15),
                              width: Dimensions.w_150,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColor.neutral_600),
                                  borderRadius: BorderRadius.circular(Dimensions.h_15)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: Dimensions.h_8),
                                        child: SizedBox(
                                            height: Dimensions.h_18,
                                            width: Dimensions.h_18,
                                            child: Image.asset('assets/airCon.png')),
                                      ),
                                      HorizontalSpacing(width: Dimensions.w_5),
                                      AppTextWidget(title: '${controller.airConValue.toStringAsFixed(0)}\u2103', style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_30,color:  AppColor.white)),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: Dimensions.w_5),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:  EdgeInsets.only(bottom: Dimensions.h_4),
                                          child: SizedBox(
                                              height: Dimensions.h_10,
                                              width: Dimensions.h_10,
                                              child: Image.asset('assets/water_drop.png')),
                                        ),
                                        HorizontalSpacing(width: Dimensions.w_5),
                                        AppTextWidget(title: '54%', style: AppTextStyle.normalTextStyle(FontSize.sp_13,AppColor.neutral_600)),
                                      ],
                                    ),
                                  ),
                                  VerticalSpacing(height: Dimensions.h_15),
                                  const Divider(color: AppColor.neutral_600),
                                  AppTextWidget(title: 'Air conditioner is ON', style: AppTextStyle.normalTextStyle(FontSize.sp_12,AppColor.white)),
                                  VerticalSpacing(height: Dimensions.h_10),
                                  Transform.scale(
                                      alignment: Alignment.centerLeft,
                                      scale: 0.7,
                                      child: CupertinoSwitch(activeColor: AppColor.appColor,value: controller.formated == "OFF" ? false : true, onChanged: (e) {
                                        controller.updateAc(context);
                                      }))

                                ],
                              ),
                            ),
                            HorizontalSpacing(width: Dimensions.w_8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    controller.setTemp('Auto');
                                    controller.setStatus(0);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left:Dimensions.w_10,right: Dimensions.w_40),
                                    height: Dimensions.h_50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.h_12),
                                        border: Border.all(
                                            color: controller.status == 0 ? AppColor.transparent :AppColor.neutral_600
                                        ),
                                        color: controller.status == 0 ? AppColor.appColor : AppColor.transparent
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: Dimensions.h_15,
                                          width: Dimensions.h_15,
                                          child: Image.asset('assets/auto.png',color: controller.status == 0 ? AppColor.black : AppColor.white,),
                                        ),
                                        HorizontalSpacing(width: Dimensions.w_8),
                                        AppTextWidget(title: 'Auto', style: AppTextStyle.normalTextStyle(FontSize.sp_13, controller.status == 0 ? AppColor.black : AppColor.white ,weight: FontWeight.w500))
                                      ],
                                    ),
                                  ),
                                ),
                                VerticalSpacing(height: Dimensions.h_10),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    controller.setTemp('Cooling');
                                    controller.setStatus(1);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left:Dimensions.w_10,right: Dimensions.w_23),
                                    height: Dimensions.h_50,
                                    decoration: BoxDecoration(
                                      color: controller.status == 1 ? AppColor.appColor : AppColor.transparent,
                                      borderRadius: BorderRadius.circular(Dimensions.h_12),
                                      border: Border.all(
                                          color: controller.status == 1 ? AppColor.transparent : AppColor.neutral_600
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: Dimensions.h_15,
                                          width: Dimensions.h_15,
                                          child: Image.asset('assets/cooling.png',color: controller.status == 1 ? AppColor.black : AppColor.white),
                                        ),
                                        HorizontalSpacing(width: Dimensions.w_8),
                                        AppTextWidget(title: 'Cooling', style: AppTextStyle.normalTextStyle(FontSize.sp_13, controller.status == 1 ? AppColor.black : AppColor.white,weight: FontWeight.w500))
                                      ],
                                    ),
                                  ),
                                ),
                                VerticalSpacing(height: Dimensions.h_10),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    controller.setTemp('Heating');
                                    controller.setStatus(2);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left:Dimensions.w_10,right: Dimensions.w_20),
                                    height: Dimensions.h_50,
                                    decoration: BoxDecoration(
                                        color: controller.status == 2 ? AppColor.appColor : AppColor.transparent,
                                        borderRadius: BorderRadius.circular(Dimensions.h_12),
                                        border: Border.all(
                                            color: controller.status == 2 ? AppColor.transparent : AppColor.neutral_600
                                        )
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: Dimensions.h_15,
                                          width: Dimensions.h_15,
                                          child: Image.asset('assets/heating.png', color: controller.status == 2 ? AppColor.black : AppColor.white),
                                        ),
                                        HorizontalSpacing(width: Dimensions.w_8),
                                        AppTextWidget(title: 'Heating', style: AppTextStyle.normalTextStyle(FontSize.sp_13, controller.status == 2 ? AppColor.black : AppColor.white,weight: FontWeight.w500))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            HorizontalSpacing(width: Dimensions.w_8),
                            RotatedBox(
                              quarterTurns: 3,
                              child: SizedBox(
                                  width: Dimensions.h_170,
                                  child: Stack(
                                    children: [
                                      AppSlider(
                                        onChanged: (e) {
                                          controller.updateValue(e);
                                        },
                                        max: 32,
                                        min: 16,
                                        controller: controller.sliderController,
                                        focusedMargin: EdgeInsets.zero,
                                        focusedHeight: Dimensions.h_50,
                                        unfocusedHeight: Dimensions.h_50,
                                        backgroundColor: AppColor.transparent,
                                        foregroundColor: AppColor.appColor,
                                        unfocusedOpacity: 1,
                                        initialProgress: controller.airConValue,
                                        padding: EdgeInsets.zero,
                                        onProgressUpdated: (e) {
                                          controller.updateValue(e);
                                        },
                                      ),
                                      Positioned(
                                        top: Dimensions.w_13,
                                        left: Dimensions.h_10,
                                        child: RotatedBox(quarterTurns: 1,
                                            child: Column(
                                              children: [
                                                AppTextWidget(title: "${controller.airConValue.toStringAsFixed(0)} ", style: AppTextStyle.normalTextStyle(
                                                    FontSize.sp_18,AppColor.black,weight: FontWeight.w500
                                                )),
                                              ],
                                            )),
                                      ),
                                      Positioned(
                                        top: Dimensions.w_20,
                                        left: Dimensions.h_25,
                                        child:  AppTextWidget(title: ".", style: AppTextStyle.themeBoldTextStyle(
                                          fontSize : FontSize.sp_18,color : AppColor.black,
                                        )),)
                                    ],
                                  )
                              ),
                            )
                          ],
                        ),
                      ],),
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(left: Dimensions.w_10,right: Dimensions.w_10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonAppbar(),
                      VerticalSpacing(height: Dimensions.h_8),
                      AppTextWidget(title: 'Air Conditioner', style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_15,color:  AppColor.white)),
                      VerticalSpacing(height: Dimensions.h_30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10,vertical: Dimensions.h_15),
                            width: Dimensions.w_120,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.neutral_600),
                                borderRadius: BorderRadius.circular(Dimensions.h_15)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: Dimensions.h_8),
                                      child: SizedBox(
                                          height: Dimensions.h_18,
                                          width: Dimensions.h_18,
                                          child: Image.asset('assets/airCon.png')),
                                    ),
                                    HorizontalSpacing(width: Dimensions.w_5),
                                    AppTextWidget(title: '${controller.airConValue.toStringAsFixed(0)}\u2103', style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_15,color:  AppColor.white)),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: Dimensions.w_5),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(bottom: Dimensions.h_4),
                                        child: SizedBox(
                                            height: Dimensions.h_10,
                                            width: Dimensions.h_10,
                                            child: Image.asset('assets/water_drop.png')),
                                      ),
                                      HorizontalSpacing(width: Dimensions.w_5),
                                      AppTextWidget(title: '54%', style: AppTextStyle.normalTextStyle(FontSize.sp_8,AppColor.neutral_600)),
                                    ],
                                  ),
                                ),
                                VerticalSpacing(height: Dimensions.h_15),
                                const Divider(color: AppColor.neutral_600),
                                AppTextWidget(title: 'Air conditioner is ON', style: AppTextStyle.normalTextStyle(FontSize.sp_8,AppColor.white)),
                                VerticalSpacing(height: Dimensions.h_10),
                                Transform.scale(
                                    alignment: Alignment.centerLeft,
                                    scale: 0.7,
                                    child: CupertinoSwitch(activeColor: AppColor.appColor,value: controller.formated == "OFF" ? false : true, onChanged: (e) {
                                      controller.updateAc(context);
                                    }))

                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  controller.setTemp('Auto');
                                  controller.setStatus(0);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left:Dimensions.w_10,right: Dimensions.w_40),
                                  height: Dimensions.h_50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.h_12),
                                      border: Border.all(
                                          color: controller.status == 0 ? AppColor.transparent :AppColor.neutral_600
                                      ),
                                      color: controller.status == 0 ? AppColor.appColor : AppColor.transparent
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: Dimensions.h_15,
                                        width: Dimensions.h_15,
                                        child: Image.asset('assets/auto.png',color: controller.status == 0 ? AppColor.black : AppColor.white,),
                                      ),
                                      HorizontalSpacing(width: Dimensions.w_8),
                                      AppTextWidget(title: 'Auto', style: AppTextStyle.normalTextStyle(FontSize.sp_8, controller.status == 0 ? AppColor.black : AppColor.white ,weight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                              ),
                              VerticalSpacing(height: Dimensions.h_10),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  controller.setTemp('Cooling');
                                  controller.setStatus(1);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left:Dimensions.w_10,right: Dimensions.w_8),
                                  height: Dimensions.h_50,
                                  decoration: BoxDecoration(
                                    color: controller.status == 1 ? AppColor.appColor : AppColor.transparent,
                                    borderRadius: BorderRadius.circular(Dimensions.h_12),
                                    border: Border.all(
                                        color: controller.status == 1 ? AppColor.transparent : AppColor.neutral_600
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: Dimensions.h_15,
                                        width: Dimensions.h_15,
                                        child: Image.asset('assets/cooling.png',color: controller.status == 1 ? AppColor.black : AppColor.white),
                                      ),
                                      HorizontalSpacing(width: Dimensions.w_8),
                                      AppTextWidget(title: 'Cooling', style: AppTextStyle.normalTextStyle(FontSize.sp_8, controller.status == 1 ? AppColor.black : AppColor.white,weight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                              ),
                              VerticalSpacing(height: Dimensions.h_10),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  controller.setTemp('Heating');
                                  controller.setStatus(2);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left:Dimensions.w_10,right: Dimensions.w_20),
                                  height: Dimensions.h_50,
                                  decoration: BoxDecoration(
                                      color: controller.status == 2 ? AppColor.appColor : AppColor.transparent,
                                      borderRadius: BorderRadius.circular(Dimensions.h_12),
                                      border: Border.all(
                                          color: controller.status == 2 ? AppColor.transparent : AppColor.neutral_600
                                      )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: Dimensions.h_15,
                                        width: Dimensions.h_15,
                                        child: Image.asset('assets/heating.png', color: controller.status == 2 ? AppColor.black : AppColor.white),
                                      ),
                                      HorizontalSpacing(width: Dimensions.w_8),
                                      AppTextWidget(title: 'Heating', style: AppTextStyle.normalTextStyle(FontSize.sp_8, controller.status == 2 ? AppColor.black : AppColor.white,weight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          RotatedBox(
                            quarterTurns: 3,
                            child: SizedBox(
                                width: Dimensions.h_350,
                                child: Stack(
                                  children: [
                                    AppSlider(
                                      onChanged: (e) {
                                        controller.updateValue(e);
                                      },
                                      max: 32,
                                      min: 16,
                                      controller: controller.sliderController,
                                      focusedMargin: EdgeInsets.zero,
                                      focusedHeight: Dimensions.h_50,
                                      unfocusedHeight: Dimensions.h_50,
                                      backgroundColor: AppColor.transparent,
                                      foregroundColor: AppColor.appColor,
                                      unfocusedOpacity: 1,
                                      initialProgress: controller.airConValue,
                                      padding: EdgeInsets.zero,
                                      onProgressUpdated: (e) {
                                        controller.updateValue(e);
                                      },
                                    ),
                                    Positioned(
                                      top: Dimensions.w_15,
                                      left: Dimensions.h_5,
                                      child: RotatedBox(quarterTurns: 1,
                                          child: Column(
                                            children: [
                                              AppTextWidget(title: "${controller.airConValue.toStringAsFixed(0)} ", style: AppTextStyle.normalTextStyle(
                                                  FontSize.sp_8,AppColor.black,weight: FontWeight.w500
                                              )),
                                            ],
                                          )),
                                    ),
                                    Positioned(
                                      top: Dimensions.h_20,
                                      left: Dimensions.h_18,
                                      child:  AppTextWidget(title: ".", style: AppTextStyle.themeBoldTextStyle(
                                        fontSize : FontSize.sp_8,color : AppColor.black,
                                      )),)
                                  ],
                                )
                            ),
                          )
                        ],
                      ),
                    ],),
                );
              },
            ));
      },
    );
  }
}
