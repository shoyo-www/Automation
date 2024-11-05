import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/Presentation/facilities/facitlity_controller.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/data/datasource/local/local_storage.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/cache_image.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';
import 'package:lottie/lottie.dart';

class FacilitiesScreen extends StatelessWidget {
  const FacilitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FacilitiesController facilitiesController = Get.put(FacilitiesController());
    return GetBuilder(
      init: facilitiesController,
      id: ControllerBuilders.facilitiesController,
      builder: (controller) {
        return AppScaffold(
          isLoading: controller.loading,
            body: OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                if (orientation == Orientation.portrait) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                            title: ' Welcome,',
                            style: AppTextStyle.normalTextStyle(
                                FontSize.sp_18, AppColor.neutral_500)),
                        AppTextWidget(title: '${LocalStorage.getString(GetXStorageConstants.userName)} 👋🏻', style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_26,color:  AppColor.white)),
                        VerticalSpacing(height: Dimensions.h_4),
                        AppTextWidget(title: ' Room ${LocalStorage.getString(GetXStorageConstants.userRoomNo)}, ${LocalStorage.getString(GetXStorageConstants.category)}', style: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.neutral_500)),
                        VerticalSpacing(height: Dimensions.h_20),
                        SizedBox(
                          height: Dimensions.h_35,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.facilitiesList.length,
                              itemBuilder: (c,i) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    controller.getIndex(i);
                                    controller.getFacilitiesSingle(controller.facilitiesList[i].id ?? '');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: Dimensions.w_12),
                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
                                    height: Dimensions.h_30,
                                    decoration: controller.selectedIndex == i ? BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end:Alignment.bottomRight,
                                          colors: [
                                            Color(0xFFBD8C2A),
                                            Color(0xFFF3E166),

                                          ]),
                                      borderRadius: BorderRadius.circular(Dimensions.h_13),
                                    ) : BoxDecoration(
                                      color: AppColor.darkCardColor,
                                      borderRadius: BorderRadius.circular(Dimensions.h_13),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            height: Dimensions.h_25,
                                            width: Dimensions.h_25,
                                            child: CachedImageWidget(url: controller.facilitiesList[i].imageUrl ?? '', height: Dimensions.h_25,circle: true,fit: BoxFit.cover,)),
                                        HorizontalSpacing(width: Dimensions.w_5),
                                        AppTextWidget(title: controller.facilitiesList[i].name ?? '', style: AppTextStyle.normalTextStyle(FontSize.sp_14, controller.selectedIndex == i ? AppColor.black : AppColor.white,weight: FontWeight.w500))
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        VerticalSpacing(height: Dimensions.h_30),
                        controller.categoryList.isNotEmpty ?  Expanded(
                          child: ListView.builder(
                              itemCount: controller.categoryList.length,
                              shrinkWrap: true,
                              itemBuilder: (c,i) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: Dimensions.h_10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.h_15),
                                      border: Border.all(
                                        color: AppColor.neutral_600,
                                      )
                                  ),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      Get.toNamed(AppRoutes.facility,arguments:  {
                                        'fController' : controller,
                                        'data' : facilitiesController.categoryList[i]
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: Dimensions.w_12,top: Dimensions.h_5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                AppTextWidget(title: StringUtils.capitalize(controller.categoryList[i].name ?? ''), style: AppTextStyle.normalTextStyle(FontSize.sp_14, AppColor.white,weight: FontWeight.w600)),
                                                VerticalSpacing(height: Dimensions.h_5),
                                                AppTextWidget(maxLines: 2,textOverflow:TextOverflow.visible,title: 'Cuisine -${controller.categoryList[i].cuisine}', style: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.white,weight: FontWeight.w300)),
                                                VerticalSpacing(height: Dimensions.h_6),
                                                AppTextWidget(maxLines: 4,textOverflow:TextOverflow.visible,title: 'Timings -Opens at ${controller.categoryList[i].startTime}AM and Close at ${controller.categoryList[i].endTime} PM', style: AppTextStyle.normalTextStyle(FontSize.sp_11, AppColor.white,weight: FontWeight.w300)),
                                                VerticalSpacing(height: Dimensions.h_6),
                                                AppTextWidget(maxLines: 1,textOverflow:TextOverflow.visible,title: 'Avg price for 2 ₹ ${controller.categoryList[i].pricing}', style: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.appColor,weight: FontWeight.w500)),
                                                VerticalSpacing(height: Dimensions.h_10),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(child: CachedImageWidget(url: controller.categoryList[i].image ?? '', height: Dimensions.h_120,radius: Dimensions.h_12,))
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ) : controller.loading == false ?  Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              VerticalSpacing(height: Dimensions.h_50),
                              Lottie.asset('assets/no_data_found.json', fit: BoxFit.cover, height: Dimensions.h_150),
                              AppTextWidget(
                                title: 'Oops! No items found',
                                style: AppTextStyle.themeBoldNormalTextStyle(color: AppColor.white, fontSize: FontSize.sp_16),
                              ),
                            ],
                          ),
                        ) : const SizedBox()
                      ],
                    ),
                  );
                }
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                            title: ' Welcome,',
                            style: AppTextStyle.normalTextStyle(
                                FontSize.sp_12, AppColor.neutral_500)),
                        AppTextWidget(title: '${LocalStorage.getString(GetXStorageConstants.userName)} 👋🏻', style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_18,color:  AppColor.white)),
                        VerticalSpacing(height: Dimensions.h_4),
                        AppTextWidget(title: ' Room ${LocalStorage.getString(GetXStorageConstants.userRoomNo)}, ${LocalStorage.getString(GetXStorageConstants.category)}', style: AppTextStyle.normalTextStyle(FontSize.sp_8, AppColor.neutral_500)),
                        VerticalSpacing(height: Dimensions.h_20),
                        SizedBox(
                          height: Dimensions.h_35,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.facilitiesList.length,
                              itemBuilder: (c,i) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    controller.getIndex(i);
                                    controller.getFacilitiesSingle(controller.facilitiesList[i].id ?? '');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: Dimensions.w_12),
                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
                                    height: Dimensions.h_30,
                                    decoration: controller.selectedIndex == i ? BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end:Alignment.bottomRight,
                                          colors: [
                                            Color(0xFFBD8C2A),
                                            Color(0xFFF3E166),
                    
                                          ]),
                                      borderRadius: BorderRadius.circular(Dimensions.h_13),
                                    ) : BoxDecoration(
                                      color: AppColor.darkCardColor,
                                      borderRadius: BorderRadius.circular(Dimensions.h_13),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            height: Dimensions.h_25,
                                            width: Dimensions.h_25,
                                            child: CachedImageWidget(url: controller.facilitiesList[i].imageUrl ?? '', height: Dimensions.h_25,circle: true,fit: BoxFit.cover,)),
                                        HorizontalSpacing(width: Dimensions.w_5),
                                        AppTextWidget(title: controller.facilitiesList[i].name ?? '', style: AppTextStyle.normalTextStyle(FontSize.sp_8, controller.selectedIndex == i ? AppColor.black : AppColor.white,weight: FontWeight.w500))
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        VerticalSpacing(height: Dimensions.h_30),
                        controller.categoryList.isNotEmpty ?  ListView.builder(
                            itemCount: controller.categoryList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (c,i) {
                              return Container(
                                margin: EdgeInsets.only(bottom: Dimensions.h_10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.h_15),
                                    border: Border.all(
                                      color: AppColor.neutral_600,
                                    )
                                ),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Get.toNamed(AppRoutes.facility,arguments:  {
                                      'fController' : controller,
                                      'data' : facilitiesController.categoryList[i]
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: Dimensions.w_12,top: Dimensions.h_5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AppTextWidget(title: StringUtils.capitalize(controller.categoryList[i].name ?? ''), style: AppTextStyle.normalTextStyle(FontSize.sp_8, AppColor.white,weight: FontWeight.w600)),
                                              VerticalSpacing(height: Dimensions.h_5),
                                              AppTextWidget(maxLines: 2,textOverflow:TextOverflow.visible,title: 'Cuisine -${controller.categoryList[i].cuisine}', style: AppTextStyle.normalTextStyle(FontSize.sp_8, AppColor.white,weight: FontWeight.w300)),
                                              VerticalSpacing(height: Dimensions.h_6),
                                              AppTextWidget(maxLines: 4,textOverflow:TextOverflow.visible,title: 'Timings -Opens at ${controller.categoryList[i].startTime}AM and Close at ${controller.categoryList[i].endTime} PM', style: AppTextStyle.normalTextStyle(FontSize.sp_6, AppColor.white,weight: FontWeight.w300)),
                                              VerticalSpacing(height: Dimensions.h_6),
                                              AppTextWidget(maxLines: 1,textOverflow:TextOverflow.visible,title: 'Avg price for 2 ₹ ${controller.categoryList[i].pricing}', style: AppTextStyle.normalTextStyle(FontSize.sp_8, AppColor.appColor,weight: FontWeight.w500)),
                                              VerticalSpacing(height: Dimensions.h_10),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(child: CachedImageWidget(url: controller.categoryList[i].image ?? '', height: Dimensions.w_80,radius: Dimensions.h_12,fit: BoxFit.cover))
                                    ],
                                  ),
                                ),
                              );
                            }) : controller.loading == false ?  Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              VerticalSpacing(height: Dimensions.h_50),
                              Lottie.asset('assets/no_data_found.json', fit: BoxFit.cover, height: Dimensions.h_150),
                              AppTextWidget(
                                title: 'Oops! No items found',
                                style: AppTextStyle.themeBoldNormalTextStyle(color: AppColor.white, fontSize: FontSize.sp_16),
                              ),
                            ],
                          ),
                        ) : const SizedBox()
                      ],
                    ),
                  ),
                );
              },
             
            ));
      },
    );
  }
}
