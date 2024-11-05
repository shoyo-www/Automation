import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/Presentation/Home/homeController.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/data/datasource/local/local_storage.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/master_light.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<QuickCalls> quickCalls = [
    QuickCalls(
        image: 'assets/telephone.png',
        title: 'Call Reception',
        subtitle: 'Need help? Call\nreception!'),
    QuickCalls(
        image: 'assets/tea.png',
        title: 'Tea',
        subtitle: 'Need a break?\nTea is coming!'),
    QuickCalls(
        image: 'assets/cookie.png',
        title: 'Snack',
        subtitle: 'Peckish? Snack\ntime!'),
  ];


  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: ControllerBuilders.homeController,
      init: homeController,
      builder: (controller) {
        return AppScaffold(
          isLoading: controller.isLoading,
          body: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              if(orientation == Orientation.portrait) {
                return Padding(
                  padding:
                  EdgeInsets.only(left: Dimensions.w_15, right: Dimensions.w_15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                            title: ' Welcome,',
                            style: AppTextStyle.normalTextStyle(
                                FontSize.sp_18, AppColor.neutral_500)),
                        AppTextWidget(
                            title:
                            '${LocalStorage.getString(GetXStorageConstants.userName)} 👋🏻',
                            style: AppTextStyle.themeBoldNormalTextStyle(
                                fontSize: FontSize.sp_26, color: AppColor.white)),
                        VerticalSpacing(height: Dimensions.h_4),
                        AppTextWidget(
                            title:
                            ' Room ${LocalStorage.getString(GetXStorageConstants.userRoomNo)}, ${LocalStorage.getString(GetXStorageConstants.category)}',
                            style: AppTextStyle.normalTextStyle(
                                FontSize.sp_12, AppColor.neutral_500)),
                        VerticalSpacing(height: Dimensions.h_30),
                        Container(
                          height: Dimensions.h_55,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.w_20, vertical: Dimensions.h_5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.h_30),
                              border: Border.all(color: AppColor.neutral_600)),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    VerticalSpacing(height: Dimensions.h_6),
                                    AppTextWidget(
                                        title: 'Doors are closed',
                                        style: AppTextStyle.themeBoldNormalTextStyle(
                                            fontSize: FontSize.sp_12,
                                            color: AppColor.neutral_500)),
                                    AppTextWidget(
                                        title: 'Switch to open or close the doors',
                                        style: AppTextStyle.normalTextStyle(
                                            FontSize.sp_11, AppColor.neutral_500)),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: Dimensions.h_5, bottom: Dimensions.h_5),
                                  child: AppSwitch(
                                    iconOff: Icons.lock_open,
                                    iconOn: Icons.lock,
                                    colorOn: AppColor.darkCardColor,
                                    colorOff: AppColor.darkCardColor,
                                    width: Dimensions.w_70,
                                    value: false,
                                    textOff: '',
                                    textOn: '',
                                    onChanged: (bool state) {},
                                    onDoubleTap: () {},
                                    onSwipe: () {
                                      // TTLock.controlLock('', TTControlAction.unlock,(lockTime, electricQuantity, uniqueId) {
                                      //   print('success');
                                      // }, (errorCode, errorMsg) {
                                      //   print('errorCode');
                                      // });
                                    },
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        VerticalSpacing(height: Dimensions.h_25),
                        Row(
                          children: [
                            AppTextWidget(
                                title: 'Room ',
                                style: AppTextStyle.normalTextStyle(
                                    FontSize.sp_17, AppColor.neutral_500,
                                    weight: FontWeight.w400)),
                            AppTextWidget(
                                title: 'Scenes',
                                style: AppTextStyle.normalTextStyle(
                                    FontSize.sp_17, AppColor.white,
                                    weight: FontWeight.w400,
                                    style: FontStyle.italic)),
                          ],
                        ),
                        VerticalSpacing(height: Dimensions.h_15),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.roomScene.length ?? 0,
                            itemBuilder: (c, i) {
                              return Container(
                                margin: EdgeInsets.only(bottom: Dimensions.h_10),
                                height: Dimensions.h_50,
                                width: double.infinity,
                                padding:
                                EdgeInsets.symmetric(horizontal: Dimensions.w_12),
                                decoration: BoxDecoration(
                                    color: AppColor.darkCardColor,
                                    borderRadius:
                                    BorderRadius.circular(Dimensions.h_15)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                            height: Dimensions.h_35,
                                            width: Dimensions.h_35,
                                            child: Image.asset(
                                                'assets/Frame 1504 (1).png')),
                                        HorizontalSpacing(width: Dimensions.w_10),
                                        AppTextWidget(
                                            title: controller.roomScene[i].name ?? '',
                                            style: AppTextStyle.normalTextStyle(
                                                FontSize.sp_15, AppColor.white,
                                                weight: FontWeight.w400)),
                                      ],
                                    ),
                                    Transform.scale(
                                        scale: 0.8,
                                        child: CupertinoSwitch(
                                            activeColor: AppColor.appColor,
                                            value: controller.roomScene[i].isSelected,
                                            onChanged: (e) {
                                              controller.roomScene[i].isSelected = e;
                                              setState(() {});
                                            }))
                                  ],
                                ),
                              );
                            }),
                        VerticalSpacing(height: Dimensions.h_25),
                        Row(
                          children: [
                            AppTextWidget(
                                title: 'Quick ',
                                style: AppTextStyle.normalTextStyle(
                                    FontSize.sp_17, AppColor.neutral_500,
                                    weight: FontWeight.w400)),
                            AppTextWidget(
                                title: 'Calls',
                                style: AppTextStyle.normalTextStyle(
                                    FontSize.sp_17, AppColor.white,
                                    weight: FontWeight.w400,
                                    style: FontStyle.italic)),
                          ],
                        ),
                        VerticalSpacing(height: Dimensions.h_15),
                        SizedBox(
                          height: Dimensions.h_120,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.quickCalls.length,
                              itemBuilder: (c, i) {
                                return Container(
                                  width: Dimensions.w_135,
                                  margin: EdgeInsets.only(right: Dimensions.w_15),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(Dimensions.h_10),
                                      color: AppColor.darkCardColor),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: Dimensions.h_30,
                                          width: Dimensions.h_30,
                                          child: Image.asset(quickCalls[i].image)),
                                      VerticalSpacing(height: Dimensions.h_10),
                                      AppTextWidget(
                                          title: controller.quickCalls[i].name ?? '',
                                          style: AppTextStyle.normalTextStyle(
                                            FontSize.sp_14,
                                            Colors.white,
                                            weight: FontWeight.w500,
                                          )),
                                      AppTextWidget(
                                          maxLines: 2,
                                          textOverflow: TextOverflow.visible,
                                          textAlign: TextAlign.center,
                                          title:
                                          controller.quickCalls[i].description ??
                                              '',
                                          style: AppTextStyle.normalTextStyle(
                                            FontSize.sp_12,
                                            Colors.white,
                                            weight: FontWeight.w300,
                                          )),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        VerticalSpacing(height: Dimensions.h_25),
                        Row(
                          children: [
                            AppTextWidget(
                                title: 'Quick ',
                                style: AppTextStyle.normalTextStyle(
                                    FontSize.sp_17, AppColor.neutral_500,
                                    weight: FontWeight.w400)),
                            AppTextWidget(
                                title: 'Actions',
                                style: AppTextStyle.normalTextStyle(
                                    FontSize.sp_17, AppColor.white,
                                    weight: FontWeight.w400,
                                    style: FontStyle.italic)),
                          ],
                        ),
                        VerticalSpacing(height: Dimensions.h_15),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  LocalStorage.writeBool(GetXStorageConstants.serviceBack, true);
                                  Get.toNamed(AppRoutes.service);
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        height: Dimensions.h_140,
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
                                            horizontal: Dimensions.w_12,
                                            vertical: Dimensions.h_10),
                                        height: Dimensions.h_140,
                                        decoration: BoxDecoration(
                                            border: const Border(
                                              top: BorderSide(
                                                  color: Color(0xFFEC804F), width: 2),
                                            ),
                                            borderRadius: BorderRadius.circular(30)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                    height: Dimensions.h_18,
                                                    width: Dimensions.h_18,
                                                    child: Image.asset(
                                                        'assets/serviceRequest.png')),
                                                Container(
                                                  padding:
                                                  EdgeInsets.all(Dimensions.h_5),
                                                  height: Dimensions.h_22,
                                                  width: Dimensions.h_22,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: AppColor.appColor)),
                                                  child: Image.asset(
                                                      'assets/up_arrow.png'),
                                                )
                                              ],
                                            ),
                                            VerticalSpacing(height: Dimensions.h_15),
                                            AppTextWidget(
                                                title: 'Service',
                                                style: AppTextStyle.normalTextStyle(
                                                    FontSize.sp_14, AppColor.white,
                                                    weight: FontWeight.w500)),
                                            AppTextWidget(
                                                title: 'Request',
                                                style: AppTextStyle.normalTextStyle(
                                                    FontSize.sp_14, AppColor.white,
                                                    weight: FontWeight.w500)),
                                            VerticalSpacing(height: Dimensions.h_8),
                                            AppTextWidget(
                                                title: 'From 8:00 am - 11:pm',
                                                style: AppTextStyle.normalTextStyle(
                                                    FontSize.sp_11,
                                                    AppColor.neutral_400))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            HorizontalSpacing(width: Dimensions.w_10),
                            Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Get.toNamed(AppRoutes.lightControl);
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        height: Dimensions.h_140,
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
                                            horizontal: Dimensions.w_12,
                                            vertical: Dimensions.h_10),
                                        height: Dimensions.h_140,
                                        decoration: BoxDecoration(
                                            border: const Border(
                                              top: BorderSide(
                                                  color: Color(0xFF6CB528), width: 2),
                                            ),
                                            borderRadius: BorderRadius.circular(30)),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                    height: Dimensions.h_18,
                                                    width: Dimensions.h_18,
                                                    child: Image.asset(
                                                        'assets/lightsControl.png')),
                                                Container(
                                                  padding:
                                                  EdgeInsets.all(Dimensions.h_5),
                                                  height: Dimensions.h_22,
                                                  width: Dimensions.h_22,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: AppColor.appColor)),
                                                  child: Image.asset(
                                                      'assets/up_arrow.png'),
                                                )
                                              ],
                                            ),
                                            VerticalSpacing(height: Dimensions.h_12),
                                            AppTextWidget(
                                                title: 'Lights',
                                                style: AppTextStyle.normalTextStyle(
                                                    FontSize.sp_14, AppColor.white,
                                                    weight: FontWeight.w500)),
                                            AppTextWidget(
                                                title: 'Control',
                                                style: AppTextStyle.normalTextStyle(
                                                    FontSize.sp_14, AppColor.white,
                                                    weight: FontWeight.w500)),
                                            Stack(
                                              children: [
                                                Row(
                                                  children: [
                                                    Transform.scale(
                                                        alignment: Alignment.centerLeft,
                                                        scale: 0.6,
                                                        child: CupertinoSwitch(
                                                            activeColor:
                                                            AppColor.appColor,
                                                            value: controller.masterValue,
                                                            onChanged: (e) {
                                                              controller.toggleValue(e);
                                                            })),
                                                  ],
                                                ),
                                                Positioned(
                                                    top: Dimensions.h_10,
                                                    right: Dimensions.w_20,
                                                    child: AppTextWidget(
                                                        title: 'Master Switch',
                                                        style: AppTextStyle
                                                            .normalTextStyle(
                                                            FontSize.sp_11,
                                                            AppColor
                                                                .neutral_400)))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        VerticalSpacing(height: Dimensions.h_15),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Get.toNamed(AppRoutes.airCon);
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        height: Dimensions.h_140,
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
                                            horizontal: Dimensions.w_12,
                                            vertical: Dimensions.h_10),
                                        height: Dimensions.h_140,
                                        decoration: BoxDecoration(
                                            border: const Border(
                                              top: BorderSide(
                                                  color: Color(0xFFE1AABC), width: 2),
                                            ),
                                            borderRadius: BorderRadius.circular(30)),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                    height: Dimensions.h_18,
                                                    width: Dimensions.h_18,
                                                    child: Image.asset(
                                                        'assets/airCon.png')),
                                                Container(
                                                  padding:
                                                  EdgeInsets.all(Dimensions.h_5),
                                                  height: Dimensions.h_22,
                                                  width: Dimensions.h_22,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: AppColor.appColor)),
                                                  child: Image.asset(
                                                      'assets/up_arrow.png'),
                                                )
                                              ],
                                            ),
                                            VerticalSpacing(height: Dimensions.h_12),
                                            AppTextWidget(
                                                title: 'Air',
                                                style: AppTextStyle.normalTextStyle(
                                                    FontSize.sp_14, AppColor.white,
                                                    weight: FontWeight.w500)),
                                            AppTextWidget(
                                                title: 'Conditioner',
                                                style: AppTextStyle.normalTextStyle(
                                                    FontSize.sp_14, AppColor.white,
                                                    weight: FontWeight.w500)),
                                            Transform.scale(
                                                alignment: Alignment.centerLeft,
                                                scale: 0.6,
                                                child: CupertinoSwitch(
                                                    activeColor: AppColor.appColor,
                                                    value: controller.airConValue,
                                                    onChanged: (e) {
                                                      controller.toggleValueAirCon(e);
                                                    })),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            HorizontalSpacing(width: Dimensions.w_10),
                            Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Get.toNamed(AppRoutes.foodOrder);
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        height: Dimensions.h_140,
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
                                            horizontal: Dimensions.w_12,
                                            vertical: Dimensions.h_10),
                                        height: Dimensions.h_140,
                                        decoration: BoxDecoration(
                                            border: const Border(
                                              top: BorderSide(
                                                  color: Color(0xFFF5D545), width: 2),
                                            ),
                                            borderRadius: BorderRadius.circular(30)),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                    height: Dimensions.h_18,
                                                    width: Dimensions.h_18,
                                                    child: Image.asset(
                                                        'assets/food.png')),
                                                Container(
                                                  padding:
                                                  EdgeInsets.all(Dimensions.h_5),
                                                  height: Dimensions.h_22,
                                                  width: Dimensions.h_22,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: AppColor.appColor)),
                                                  child: Image.asset(
                                                      'assets/up_arrow.png'),
                                                )
                                              ],
                                            ),
                                            VerticalSpacing(height: Dimensions.h_13),
                                            AppTextWidget(
                                                title: 'Food ',
                                                style: AppTextStyle.normalTextStyle(
                                                    FontSize.sp_14, AppColor.white,
                                                    weight: FontWeight.w500)),
                                            AppTextWidget(
                                                title: 'Order',
                                                style: AppTextStyle.normalTextStyle(
                                                    FontSize.sp_14, AppColor.white,
                                                    weight: FontWeight.w500)),
                                            VerticalSpacing(height: Dimensions.h_8),
                                            AppTextWidget(
                                                title: 'From 8:00 am - 11: pm',
                                                style: AppTextStyle.normalTextStyle(
                                                    FontSize.sp_11,
                                                    AppColor.neutral_400))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        VerticalSpacing(height: Dimensions.h_15),
                      ],
                    ),
                  ),
                );
              }
              return Padding(
                padding:
                EdgeInsets.only(left: Dimensions.w_15, right: Dimensions.w_15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                          title: ' Welcome,',
                          style: AppTextStyle.normalTextStyle(
                              FontSize.sp_10, AppColor.neutral_500)),
                      AppTextWidget(
                          title:
                          '${LocalStorage.getString(GetXStorageConstants.userName)} 👋🏻',
                          style: AppTextStyle.themeBoldNormalTextStyle(
                              fontSize: FontSize.sp_16, color: AppColor.white)),
                      VerticalSpacing(height: Dimensions.h_4),
                      AppTextWidget(
                          title:
                          ' Room ${LocalStorage.getString(GetXStorageConstants.userRoomNo)}, ${LocalStorage.getString(GetXStorageConstants.category)}',
                          style: AppTextStyle.normalTextStyle(
                              FontSize.sp_7, AppColor.neutral_500)),
                      VerticalSpacing(height: Dimensions.h_30),
                      Container(
                        height: Dimensions.h_55,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_20, vertical: Dimensions.h_5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.h_30),
                            border: Border.all(color: AppColor.neutral_600)),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  VerticalSpacing(height: Dimensions.h_6),
                                  AppTextWidget(
                                      title: 'Doors are closed',
                                      style: AppTextStyle.themeBoldNormalTextStyle(
                                          fontSize: FontSize.sp_7,
                                          color: AppColor.neutral_500)),
                                  AppTextWidget(
                                      title: 'Switch to open or close the doors',
                                      style: AppTextStyle.normalTextStyle(
                                          FontSize.sp_6, AppColor.neutral_500)),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: Dimensions.h_5, bottom: Dimensions.h_5),
                                child: AppSwitch(
                                  iconOff: Icons.lock_open,
                                  iconOn: Icons.lock,
                                  colorOn: AppColor.darkCardColor,
                                  colorOff: AppColor.darkCardColor,
                                  width: Dimensions.w_70,
                                  value: false,
                                  textOff: '',
                                  textOn: '',
                                  onChanged: (bool state) {},
                                  onDoubleTap: () {},
                                  onSwipe: () {
                                    // TTLock.controlLock('', TTControlAction.unlock,(lockTime, electricQuantity, uniqueId) {
                                    //   print('success');
                                    // }, (errorCode, errorMsg) {
                                    //   print('errorCode');
                                    // });
                                  },
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      VerticalSpacing(height: Dimensions.h_25),
                      Row(
                        children: [
                          AppTextWidget(
                              title: 'Room ',
                              style: AppTextStyle.normalTextStyle(
                                  FontSize.sp_9, AppColor.neutral_500,
                                  weight: FontWeight.w400)),
                          AppTextWidget(
                              title: 'Scenes',
                              style: AppTextStyle.normalTextStyle(
                                  FontSize.sp_9, AppColor.white,
                                  weight: FontWeight.w400,
                                  style: FontStyle.italic)),
                        ],
                      ),
                      VerticalSpacing(height: Dimensions.h_15),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.roomScene.length ?? 0,
                          itemBuilder: (c, i) {
                            return Container(
                              margin: EdgeInsets.only(bottom: Dimensions.h_10),
                              height: Dimensions.h_50,
                              width: double.infinity,
                              padding:
                              EdgeInsets.symmetric(horizontal: Dimensions.w_12),
                              decoration: BoxDecoration(
                                  color: AppColor.darkCardColor,
                                  borderRadius:
                                  BorderRadius.circular(Dimensions.h_15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                          height: Dimensions.h_35,
                                          width: Dimensions.h_35,
                                          child: Image.asset(
                                              'assets/Frame 1504 (1).png')),
                                      HorizontalSpacing(width: Dimensions.w_10),
                                      AppTextWidget(
                                          title: controller.roomScene[i].name ?? '',
                                          style: AppTextStyle.normalTextStyle(
                                              FontSize.sp_8, AppColor.white,
                                              weight: FontWeight.w400)),
                                    ],
                                  ),
                                  Transform.scale(
                                      scale: 0.8,
                                      child: CupertinoSwitch(
                                          activeColor: AppColor.appColor,
                                          value: controller.roomScene[i].isSelected,
                                          onChanged: (e) {
                                            controller.roomScene[i].isSelected = e;
                                            setState(() {});
                                          }))
                                ],
                              ),
                            );
                          }),
                      VerticalSpacing(height: Dimensions.h_25),
                      Row(
                        children: [
                          AppTextWidget(
                              title: 'Quick ',
                              style: AppTextStyle.normalTextStyle(
                                  FontSize.sp_9, AppColor.neutral_500,
                                  weight: FontWeight.w400)),
                          AppTextWidget(
                              title: 'Calls',
                              style: AppTextStyle.normalTextStyle(
                                  FontSize.sp_9, AppColor.white,
                                  weight: FontWeight.w400,
                                  style: FontStyle.italic)),
                        ],
                      ),
                      VerticalSpacing(height: Dimensions.h_15),
                      SizedBox(
                        height: Dimensions.h_120,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.quickCalls.length,
                            itemBuilder: (c, i) {
                              return Container(
                                width: Dimensions.w_90,
                                margin: EdgeInsets.only(right: Dimensions.w_15),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(Dimensions.h_10),
                                    color: AppColor.darkCardColor),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: Dimensions.h_30,
                                        width: Dimensions.h_30,
                                        child: Image.asset(quickCalls[i].image)),
                                    VerticalSpacing(height: Dimensions.h_10),
                                    AppTextWidget(
                                        title: controller.quickCalls[i].name ?? '',
                                        style: AppTextStyle.normalTextStyle(
                                          FontSize.sp_8,
                                          Colors.white,
                                          weight: FontWeight.w500,
                                        )),
                                    AppTextWidget(
                                        maxLines: 2,
                                        textOverflow: TextOverflow.visible,
                                        textAlign: TextAlign.center,
                                        title:
                                        controller.quickCalls[i].description ??
                                            '',
                                        style: AppTextStyle.normalTextStyle(
                                          FontSize.sp_6,
                                          Colors.white,
                                          weight: FontWeight.w300,
                                        )),
                                  ],
                                ),
                              );
                            }),
                      ),
                      VerticalSpacing(height: Dimensions.h_25),
                      Row(
                        children: [
                          AppTextWidget(
                              title: 'Quick ',
                              style: AppTextStyle.normalTextStyle(
                                  FontSize.sp_9, AppColor.neutral_500,
                                  weight: FontWeight.w400)),
                          AppTextWidget(
                              title: 'Actions',
                              style: AppTextStyle.normalTextStyle(
                                  FontSize.sp_9, AppColor.white,
                                  weight: FontWeight.w400,
                                  style: FontStyle.italic)),
                        ],
                      ),
                      VerticalSpacing(height: Dimensions.h_15),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                LocalStorage.writeBool(GetXStorageConstants.serviceBack, true);
                                Get.toNamed(AppRoutes.service);
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: Dimensions.h_140,
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
                                          horizontal: Dimensions.w_12,
                                          vertical: Dimensions.h_10),
                                      height: Dimensions.h_140,
                                      decoration: BoxDecoration(
                                          border: const Border(
                                            top: BorderSide(
                                                color: Color(0xFFEC804F), width: 2),
                                          ),
                                          borderRadius: BorderRadius.circular(30)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  height: Dimensions.h_18,
                                                  width: Dimensions.h_18,
                                                  child: Image.asset(
                                                      'assets/serviceRequest.png')),
                                              Container(
                                                padding:
                                                EdgeInsets.all(Dimensions.h_5),
                                                height: Dimensions.h_22,
                                                width: Dimensions.h_22,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: AppColor.appColor)),
                                                child: Image.asset(
                                                    'assets/up_arrow.png'),
                                              )
                                            ],
                                          ),
                                          VerticalSpacing(height: Dimensions.h_15),
                                          AppTextWidget(
                                              title: 'Service',
                                              style: AppTextStyle.normalTextStyle(
                                                  FontSize.sp_8, AppColor.white,
                                                  weight: FontWeight.w500)),
                                          AppTextWidget(
                                              title: 'Request',
                                              style: AppTextStyle.normalTextStyle(
                                                  FontSize.sp_8, AppColor.white,
                                                  weight: FontWeight.w500)),
                                          VerticalSpacing(height: Dimensions.h_8),
                                          AppTextWidget(
                                              title: 'From 8:00 am - 11:pm',
                                              style: AppTextStyle.normalTextStyle(
                                                  FontSize.sp_6,
                                                  AppColor.neutral_400))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          HorizontalSpacing(width: Dimensions.w_10),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Get.toNamed(AppRoutes.lightControl);
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: Dimensions.h_140,
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
                                          horizontal: Dimensions.w_12,
                                          vertical: Dimensions.h_10),
                                      height: Dimensions.h_140,
                                      decoration: BoxDecoration(
                                          border: const Border(
                                            top: BorderSide(
                                                color: Color(0xFF6CB528), width: 2),
                                          ),
                                          borderRadius: BorderRadius.circular(30)),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  height: Dimensions.h_18,
                                                  width: Dimensions.h_18,
                                                  child: Image.asset(
                                                      'assets/lightsControl.png')),
                                              Container(
                                                padding:
                                                EdgeInsets.all(Dimensions.h_5),
                                                height: Dimensions.h_22,
                                                width: Dimensions.h_22,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: AppColor.appColor)),
                                                child: Image.asset(
                                                    'assets/up_arrow.png'),
                                              )
                                            ],
                                          ),
                                          VerticalSpacing(height: Dimensions.h_12),
                                          AppTextWidget(
                                              title: 'Lights',
                                              style: AppTextStyle.normalTextStyle(
                                                  FontSize.sp_8, AppColor.white,
                                                  weight: FontWeight.w500)),
                                          AppTextWidget(
                                              title: 'Control',
                                              style: AppTextStyle.normalTextStyle(
                                                  FontSize.sp_8, AppColor.white,
                                                  weight: FontWeight.w500)),
                                          Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  Transform.scale(
                                                      alignment: Alignment.centerLeft,
                                                      scale: 0.6,
                                                      child: CupertinoSwitch(
                                                          activeColor:
                                                          AppColor.appColor,
                                                          value: controller.masterValue,
                                                          onChanged: (e) {
                                                            controller.toggleValue(e);
                                                          })),
                                                ],
                                              ),
                                              Positioned(
                                                  top: Dimensions.h_8,
                                                  left: Dimensions.w_40,
                                                  child: AppTextWidget(
                                                      title: 'Master Switch',
                                                      style: AppTextStyle
                                                          .normalTextStyle(
                                                          FontSize.sp_6,
                                                          AppColor
                                                              .neutral_400)))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      VerticalSpacing(height: Dimensions.h_15),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Get.toNamed(AppRoutes.airCon);
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: Dimensions.h_140,
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
                                          horizontal: Dimensions.w_12,
                                          vertical: Dimensions.h_10),
                                      height: Dimensions.h_140,
                                      decoration: BoxDecoration(
                                          border: const Border(
                                            top: BorderSide(
                                                color: Color(0xFFE1AABC), width: 2),
                                          ),
                                          borderRadius: BorderRadius.circular(30)),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  height: Dimensions.h_18,
                                                  width: Dimensions.h_18,
                                                  child: Image.asset(
                                                      'assets/airCon.png')),
                                              Container(
                                                padding:
                                                EdgeInsets.all(Dimensions.h_5),
                                                height: Dimensions.h_22,
                                                width: Dimensions.h_22,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: AppColor.appColor)),
                                                child: Image.asset(
                                                    'assets/up_arrow.png'),
                                              )
                                            ],
                                          ),
                                          VerticalSpacing(height: Dimensions.h_12),
                                          AppTextWidget(
                                              title: 'Air',
                                              style: AppTextStyle.normalTextStyle(
                                                  FontSize.sp_8, AppColor.white,
                                                  weight: FontWeight.w500)),
                                          AppTextWidget(
                                              title: 'Conditioner',
                                              style: AppTextStyle.normalTextStyle(
                                                  FontSize.sp_8, AppColor.white,
                                                  weight: FontWeight.w500)),
                                          Transform.scale(
                                              alignment: Alignment.centerLeft,
                                              scale: 0.6,
                                              child: CupertinoSwitch(
                                                  activeColor: AppColor.appColor,
                                                  value: controller.airConValue,
                                                  onChanged: (e) {
                                                    controller.toggleValueAirCon(e);
                                                  })),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          HorizontalSpacing(width: Dimensions.w_10),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Get.toNamed(AppRoutes.foodOrder);
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: Dimensions.h_140,
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
                                          horizontal: Dimensions.w_12,
                                          vertical: Dimensions.h_10),
                                      height: Dimensions.h_140,
                                      decoration: BoxDecoration(
                                          border: const Border(
                                            top: BorderSide(
                                                color: Color(0xFFF5D545), width: 2),
                                          ),
                                          borderRadius: BorderRadius.circular(30)),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  height: Dimensions.h_18,
                                                  width: Dimensions.h_18,
                                                  child: Image.asset(
                                                      'assets/food.png')),
                                              Container(
                                                padding:
                                                EdgeInsets.all(Dimensions.h_5),
                                                height: Dimensions.h_22,
                                                width: Dimensions.h_22,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: AppColor.appColor)),
                                                child: Image.asset(
                                                    'assets/up_arrow.png'),
                                              )
                                            ],
                                          ),
                                          VerticalSpacing(height: Dimensions.h_13),
                                          AppTextWidget(
                                              title: 'Food ',
                                              style: AppTextStyle.normalTextStyle(
                                                  FontSize.sp_8, AppColor.white,
                                                  weight: FontWeight.w500)),
                                          AppTextWidget(
                                              title: 'Order',
                                              style: AppTextStyle.normalTextStyle(
                                                  FontSize.sp_8, AppColor.white,
                                                  weight: FontWeight.w500)),
                                          VerticalSpacing(height: Dimensions.h_8),
                                          AppTextWidget(
                                              title: 'From 8:00 am - 11: pm',
                                              style: AppTextStyle.normalTextStyle(
                                                  FontSize.sp_6,
                                                  AppColor.neutral_400))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      VerticalSpacing(height: Dimensions.h_15),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Container buildRoomWidget(String image, String title, bool value) {
    return Container(
      height: Dimensions.h_50,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
      decoration: BoxDecoration(
          color: AppColor.darkCardColor,
          borderRadius: BorderRadius.circular(Dimensions.h_15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                  height: Dimensions.h_35,
                  width: Dimensions.h_35,
                  child: Image.asset(image)),
              HorizontalSpacing(width: Dimensions.w_10),
              AppTextWidget(
                  title: title,
                  style: AppTextStyle.normalTextStyle(
                      FontSize.sp_15, AppColor.white,
                      weight: FontWeight.w400)),
            ],
          ),
          Transform.scale(
              scale: 0.8,
              child: CupertinoSwitch(
                  activeColor: AppColor.appColor,
                  value: true,
                  onChanged: (e) {}))
        ],
      ),
    );
  }
}

class QuickCalls {
  final String image;
  final String title;
  final String subtitle;

  QuickCalls(
      {required this.image, required this.title, required this.subtitle});
}
