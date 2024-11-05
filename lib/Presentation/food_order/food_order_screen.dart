import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelautomationapp/Presentation/food_order/food_order_controller.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/data/datasource/local/local_storage.dart';
import 'package:hotelautomationapp/widgets/appSearchField.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/appbutton.dart';
import 'package:hotelautomationapp/widgets/cache_image.dart';
import 'package:hotelautomationapp/widgets/common_appbar.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';

class FoodOrderScreen extends StatelessWidget {
  const FoodOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FoodOrderController foodOrderController = Get.put(FoodOrderController());
    return GetBuilder(
      id: ControllerBuilders.foodController,
      init: foodOrderController,
      builder: (controller) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            if(orientation == Orientation.portrait) {
              return AppScaffold(
                isLoading: controller.loading,
                bottom: false,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.w_15, right: Dimensions.w_15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonAppbar(onTap: ()=> Get.toNamed(AppRoutes.dashBoard),),
                            VerticalSpacing(height: Dimensions.h_8),
                            AppTextWidget(
                                title: 'Food Order',
                                style: AppTextStyle.themeBoldNormalTextStyle(
                                    fontSize: FontSize.sp_22,
                                    color: AppColor.white)),
                            AppTextWidget(
                                title:
                                'Room ${LocalStorage.getString(GetXStorageConstants.userRoomNo)}',
                                style: AppTextStyle.normalTextStyle(
                                    FontSize.sp_12, AppColor.white)),
                            VerticalSpacing(height: Dimensions.h_20),
                            AppSearchTextField(
                                hintText: 'Search for favourite food',
                                controller: TextEditingController()),
                            VerticalSpacing(height: Dimensions.h_10),
                            AppTextWidget(
                                title: 'Special Offers',
                                style: AppTextStyle.normalTextStyle(
                                    FontSize.sp_14, AppColor.white,
                                    weight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      VerticalSpacing(height: Dimensions.h_10),
                      SizedBox(
                        height: Dimensions.h_100,
                        child: ListView.builder(
                            padding: EdgeInsets.only(left: Dimensions.w_15),
                            itemCount: controller.foodOfferItems.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (c, i) {
                              return Padding(
                                padding: EdgeInsets.only(right: Dimensions.w_10),
                                child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.foodOffer,arguments: {
                                        'controller' : controller,
                                        'data' : controller.foodOfferItems[i].applicableItemsData,
                                        'offerData' : controller.foodOfferItems[i]
                                      });
                                    },
                                    child: CachedImageWidget(url: controller.foodOfferItems[i].image ?? '', height: Dimensions.h_180,radius: Dimensions.h_12,fit: BoxFit.cover,)),
                              );
                            }),
                      ),
                      VerticalSpacing(height: Dimensions.h_18),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.w_15, right: Dimensions.w_15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                                title: 'Categories',
                                style: AppTextStyle.normalTextStyle(
                                    FontSize.sp_14, AppColor.white,
                                    weight: FontWeight.w400)),
                            VerticalSpacing(height: Dimensions.h_20),
                          ],
                        ),
                      ),
                      AbsorbPointer(
                        absorbing: controller.loading,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Dimensions.h_30,
                              child: ListView.builder(
                                  padding: EdgeInsets.only(left: Dimensions.w_15),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.food.length,
                                  itemBuilder: (c, i) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.getIndex(i,category: i);
                                        controller.filter(controller.food[i].name ?? '');
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: Dimensions.w_8),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.w_10),
                                        height: Dimensions.h_40,
                                        decoration: controller.categoriesIndex == i
                                            ? BoxDecoration(
                                          gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xFFBD8C2A),
                                                Color(0xFFF3E166),
                                              ]),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.h_10),
                                        )
                                            : BoxDecoration(
                                          color: AppColor.darkCardColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.h_10),
                                        ),
                                        child: Center(
                                            child: AppTextWidget(
                                                title: StringUtils.capitalize(controller.food[i].name ?? ''),
                                                style: AppTextStyle.normalTextStyle(
                                                    FontSize.sp_12,
                                                    controller.categoriesIndex == i
                                                        ? AppColor.black
                                                        : AppColor.white,
                                                    weight: FontWeight.w400))),
                                      ),
                                    );
                                  }),
                            ),
                            VerticalSpacing(height: Dimensions.h_10),
                            controller.filterList.isNotEmpty ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(left: Dimensions.w_15, right: Dimensions.w_15),
                                itemCount:  controller.filterList.length ,
                                itemBuilder: (c, i) {
                                  return Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(bottom: Dimensions.h_10, top: Dimensions.h_5),
                                    decoration: BoxDecoration(
                                      border: const Border(
                                        bottom: BorderSide(color: AppColor.neutral_600, width: 0.5),
                                        top: BorderSide(color: AppColor.neutral_600, width: 0.5),
                                        left: BorderSide(color: AppColor.neutral_600, width: 0.5),
                                      ),
                                      borderRadius: BorderRadius.circular(Dimensions.h_10),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_4, bottom: Dimensions.h_4),
                                          child: SizedBox(
                                            width: Dimensions.w_190,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  behavior: HitTestBehavior.opaque,
                                                  onTap: () {
                                                    Get.toNamed(AppRoutes.foodOrderDetail,arguments: {
                                                      "controller" : controller,
                                                      "foodId" : controller.filterList[i].id
                                                    });
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      AppTextWidget(
                                                        title: controller.filterList[i].name ?? '',
                                                        style: AppTextStyle.normalTextStyle(
                                                          FontSize.sp_15,
                                                          AppColor.white,
                                                          weight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      VerticalSpacing(height: Dimensions.h_5),
                                                      ReadMoreText(
                                                        controller.filterList[i].description ?? '',
                                                        trimLines: 2,
                                                        colorClickableText: AppColor.white,
                                                        lessStyle: AppTextStyle.normalTextStyle(
                                                          FontSize.sp_11,
                                                          AppColor.white,
                                                          weight: FontWeight.w400,
                                                        ),
                                                        trimMode: TrimMode.Line,
                                                        textAlign: TextAlign.start,
                                                        trimCollapsedText: 'Read more',
                                                        trimExpandedText: 'Read less',
                                                        style: AppTextStyle.normalTextStyle(
                                                          FontSize.sp_11,
                                                          AppColor.neutral_500,
                                                          weight: FontWeight.w400,
                                                        ),
                                                        moreStyle: AppTextStyle.normalTextStyle(
                                                          FontSize.sp_11,
                                                          AppColor.white,
                                                          weight: FontWeight.w400,
                                                        ),
                                                      ),
                                                      VerticalSpacing(height: Dimensions.h_4),
                                                      AppTextWidget(
                                                        title: "${controller.filterList[i].kcal} Kcal" ?? "",
                                                        style: AppTextStyle.normalTextStyle(
                                                          FontSize.sp_11,
                                                          AppColor.white,
                                                          weight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                VerticalSpacing(height: Dimensions.h_8),
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    AppTextWidget(
                                                      title: '₹ ${controller.filterList[i].price.toString()}',
                                                      style: AppTextStyle.normalTextStyle(
                                                        FontSize.sp_11,
                                                        AppColor.appColor,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    controller.filterList[i].quantity !=0 ?
                                                    Container(
                                                      padding: EdgeInsets.symmetric(vertical: Dimensions.h_2, horizontal: Dimensions.w_8),
                                                      margin: EdgeInsets.only(right: Dimensions.w_10, bottom: Dimensions.h_4),
                                                      decoration: BoxDecoration(
                                                        color: AppColor.appColor,
                                                        borderRadius: BorderRadius.circular(Dimensions.h_8),
                                                      ),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                controller.decrementCounter(controller.filterList[i], i);
                                                              },
                                                              child: Icon(Icons.remove, color: AppColor.black, size: Dimensions.h_12),
                                                            ),
                                                            HorizontalSpacing(width: Dimensions.w_5),
                                                            AppTextWidget(
                                                              title: controller.filterList[i].quantity.toString(),
                                                              style: AppTextStyle.themeBoldTextStyle(fontSize: FontSize.sp_13, color: AppColor.black),
                                                            ),
                                                            HorizontalSpacing(width: Dimensions.w_5),
                                                            GestureDetector(
                                                              onTap: () {
                                                                controller.incrementCounter(controller.filterList[i], i);

                                                              },
                                                              child: Icon(Icons.add, color: AppColor.black, size: Dimensions.h_13),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                        : GestureDetector(
                                                      behavior: HitTestBehavior.opaque,
                                                      onTap: () {
                                                        controller.incrementCounter(controller.filterList[i], i);
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(vertical: Dimensions.h_2, horizontal: Dimensions.w_10),
                                                        margin: EdgeInsets.only(right: Dimensions.w_10),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(Dimensions.h_8),
                                                          border: Border.all(color: AppColor.appColor, width: 1),
                                                        ),
                                                        child: Center(
                                                          child: AppTextWidget(
                                                            title: 'Add',
                                                            style: AppTextStyle.themeBoldTextStyle(fontSize: FontSize.sp_12, color: AppColor.appColor),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(AppRoutes.foodOrderDetail,arguments: {
                                              'controller' : controller,
                                              'foodId' : controller.filterList[i].id
                                            });
                                          },
                                          child: CachedImageWidget(url: controller.filterList[i].imageUrl ?? '', height: Dimensions.h_110,fit: BoxFit.cover, radius: 15
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            ) : controller.loading == false ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  VerticalSpacing(height: Dimensions.h_40),
                                  Lottie.asset('assets/no_data_found.json', fit: BoxFit.cover, height: Dimensions.h_100),
                                  AppTextWidget(
                                    title: 'Oops! No items found',
                                    style: AppTextStyle.themeBoldNormalTextStyle(color: AppColor.white, fontSize: FontSize.sp_16),
                                  ),
                                ],
                              ),
                            ) : const SizedBox(),
                          ],
                        ),
                      ),
                      VerticalSpacing(height: controller.added? Dimensions.h_60 : Dimensions.h_20),
                    ],
                  ),
                ),
                bottomNavigationBar: controller.added? Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w_60, vertical: Dimensions.h_8),
                  height: Dimensions.h_60,
                  width: double.infinity,
                  color: AppColor.darkCardColor,
                  child: Center(
                    child: AppButton(
                      style: AppTextStyle.buttonTextStyle(color: AppColor.black),
                        title: "${controller.quantity.toString()} item added -->",
                        margin: EdgeInsets.zero,
                        onTap: () {
                          Get.toNamed(AppRoutes.cart,arguments: {
                            'controller' : controller
                          });
                        }
                    ),),
                ) : const SizedBox.shrink(),
              );
            }
            return AppScaffold(
              isLoading: controller.loading,
              bottom: false,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.w_15, right: Dimensions.w_15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonAppbar(onTap: ()=> Get.toNamed(AppRoutes.dashBoard)),
                          VerticalSpacing(height: Dimensions.h_8),
                          AppTextWidget(
                              title: 'Food Order',
                              style: AppTextStyle.themeBoldNormalTextStyle(
                                  fontSize: FontSize.sp_13,
                                  color: AppColor.white)),
                          AppTextWidget(
                              title:
                              'Room ${LocalStorage.getString(GetXStorageConstants.userRoomNo)}',
                              style: AppTextStyle.normalTextStyle(
                                  FontSize.sp_8, AppColor.white)),
                          VerticalSpacing(height: Dimensions.h_20),
                          AppSearchTextField(
                            hintStyle: AppTextStyle.normalTextStyle(FontSize.sp_7, AppColor.neutral_400),
                              hintText: 'Search for favourite food',
                              controller: TextEditingController()),
                          VerticalSpacing(height: Dimensions.h_10),
                          AppTextWidget(
                              title: 'Special Offers',
                              style: AppTextStyle.normalTextStyle(
                                  FontSize.sp_9, AppColor.white,
                                  weight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    VerticalSpacing(height: Dimensions.h_10),
                    SizedBox(
                      height: Dimensions.h_200,
                      child: ListView.builder(
                          padding: EdgeInsets.only(left: Dimensions.w_15),
                          itemCount: controller.foodOfferItems.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (c, i) {
                            return Padding(
                              padding: EdgeInsets.only(right: Dimensions.w_10),
                              child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.foodOffer,arguments: {
                                      'controller' : controller,
                                      'data' : controller.foodOfferItems[i].applicableItemsData,
                                      'offerData' : controller.foodOfferItems[i]
                                    });
                                  },
                                  child: CachedImageWidget(url: controller.foodOfferItems[i].image ?? '', height: Dimensions.w_150,radius: Dimensions.h_12,fit: BoxFit.cover,)),
                            );
                          }),
                    ),
                    VerticalSpacing(height: Dimensions.h_18),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.w_15, right: Dimensions.w_15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                              title: 'Categories',
                              style: AppTextStyle.normalTextStyle(
                                  FontSize.sp_9, AppColor.white,
                                  weight: FontWeight.w400)),
                          VerticalSpacing(height: Dimensions.h_20),
                        ],
                      ),
                    ),
                    AbsorbPointer(
                      absorbing: controller.loading,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Dimensions.h_30,
                            child: ListView.builder(
                                padding: EdgeInsets.only(left: Dimensions.w_15),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.food.length,
                                itemBuilder: (c, i) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.getIndex(i,category: i);
                                      controller.filter(controller.food[i].name ?? '');
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: Dimensions.w_8),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.w_10),
                                      height: Dimensions.h_40,
                                      decoration: controller.categoriesIndex == i
                                          ? BoxDecoration(
                                        gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xFFBD8C2A),
                                              Color(0xFFF3E166),
                                            ]),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.h_10),
                                      )
                                          : BoxDecoration(
                                        color: AppColor.darkCardColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.h_10),
                                      ),
                                      child: Center(
                                          child: AppTextWidget(
                                              title: StringUtils.capitalize(controller.food[i].name ?? ''),
                                              style: AppTextStyle.normalTextStyle(
                                                  FontSize.sp_7,
                                                  controller.categoriesIndex == i
                                                      ? AppColor.black
                                                      : AppColor.white,
                                                  weight: FontWeight.w400))),
                                    ),
                                  );
                                }),
                          ),
                          VerticalSpacing(height: Dimensions.h_10),
                          controller.filterList.isNotEmpty ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(left: Dimensions.w_15, right: Dimensions.w_15),
                              itemCount:  controller.filterList.length ,
                              itemBuilder: (c, i) {
                                return Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(bottom: Dimensions.h_10, top: Dimensions.h_5),
                                  decoration: BoxDecoration(
                                    border: const Border(
                                      bottom: BorderSide(color: AppColor.neutral_600, width: 0.5),
                                      top: BorderSide(color: AppColor.neutral_600, width: 0.5),
                                      left: BorderSide(color: AppColor.neutral_600, width: 0.5),
                                    ),
                                    borderRadius: BorderRadius.circular(Dimensions.h_10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_4, bottom: Dimensions.h_4),
                                        child: SizedBox(
                                          width: Dimensions.w_180,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                behavior: HitTestBehavior.opaque,
                                                onTap: () {
                                                  Get.toNamed(AppRoutes.foodOrderDetail,arguments: {
                                                    "controller" : controller,
                                                    "foodId" : controller.filterList[i].id
                                                  });
                                                },
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    AppTextWidget(
                                                      title: controller.filterList[i].name ?? '',
                                                      style: AppTextStyle.normalTextStyle(
                                                        FontSize.sp_10,
                                                        AppColor.white,
                                                        weight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    VerticalSpacing(height: Dimensions.h_5),
                                                    ReadMoreText(
                                                      controller.filterList[i].description ?? '',
                                                      trimLines: 2,
                                                      colorClickableText: AppColor.white,
                                                      lessStyle: AppTextStyle.normalTextStyle(
                                                        FontSize.sp_8,
                                                        AppColor.white,
                                                        weight: FontWeight.w400,
                                                      ),
                                                      trimMode: TrimMode.Line,
                                                      textAlign: TextAlign.start,
                                                      trimCollapsedText: 'Read more',
                                                      trimExpandedText: 'Read less',
                                                      style: AppTextStyle.normalTextStyle(
                                                        FontSize.sp_8,
                                                        AppColor.neutral_500,
                                                        weight: FontWeight.w400,
                                                      ),
                                                      moreStyle: AppTextStyle.normalTextStyle(
                                                        FontSize.sp_8,
                                                        AppColor.white,
                                                        weight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    VerticalSpacing(height: Dimensions.h_4),
                                                    AppTextWidget(
                                                      title: "${controller.filterList[i].kcal} Kcal" ?? "",
                                                      style: AppTextStyle.normalTextStyle(
                                                        FontSize.sp_6,
                                                        AppColor.white,
                                                        weight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              VerticalSpacing(height: Dimensions.h_8),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  AppTextWidget(
                                                    title: '₹ ${controller.filterList[i].price.toString()}',
                                                    style: AppTextStyle.normalTextStyle(
                                                      FontSize.sp_8,
                                                      AppColor.appColor,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  controller.filterList[i].quantity !=0 ?
                                                  Container(
                                                    padding: EdgeInsets.symmetric(vertical: Dimensions.h_2, horizontal: Dimensions.w_8),
                                                    margin: EdgeInsets.only(right: Dimensions.w_10, bottom: Dimensions.h_4),
                                                    decoration: BoxDecoration(
                                                      color: AppColor.appColor,
                                                      borderRadius: BorderRadius.circular(Dimensions.h_8),
                                                    ),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              controller.decrementCounter(controller.filterList[i], i);
                                                            },
                                                            child: Icon(Icons.remove, color: AppColor.black, size: Dimensions.h_12),
                                                          ),
                                                          HorizontalSpacing(width: Dimensions.w_5),
                                                          AppTextWidget(
                                                            title: controller.filterList[i].quantity.toString(),
                                                            style: AppTextStyle.themeBoldTextStyle(fontSize: FontSize.sp_9, color: AppColor.black),
                                                          ),
                                                          HorizontalSpacing(width: Dimensions.w_5),
                                                          GestureDetector(
                                                            onTap: () {
                                                              controller.incrementCounter(controller.filterList[i], i);

                                                            },
                                                            child: Icon(Icons.add, color: AppColor.black, size: Dimensions.h_13),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                      : GestureDetector(
                                                    behavior: HitTestBehavior.opaque,
                                                    onTap: () {
                                                      controller.incrementCounter(controller.filterList[i], i);
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(vertical: Dimensions.h_2, horizontal: Dimensions.w_10),
                                                      margin: EdgeInsets.only(right: Dimensions.w_10),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.h_8),
                                                        border: Border.all(color: AppColor.appColor, width: 1),
                                                      ),
                                                      child: Center(
                                                        child: AppTextWidget(
                                                          title: 'Add',
                                                          style: AppTextStyle.themeBoldTextStyle(fontSize: FontSize.sp_9, color: AppColor.appColor),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.foodOrderDetail,arguments: {
                                            'controller' : controller,
                                            'foodId' : controller.filterList[i].id
                                          });
                                        },
                                        child: CachedImageWidget(url: controller.filterList[i].imageUrl ?? '', height: Dimensions.w_100,fit: BoxFit.cover, radius: 15
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ) : controller.loading == false ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                VerticalSpacing(height: Dimensions.h_40),
                                Lottie.asset('assets/no_data_found.json', fit: BoxFit.cover, height: Dimensions.h_100),
                                AppTextWidget(
                                  title: 'Oops! No items found',
                                  style: AppTextStyle.themeBoldNormalTextStyle(color: AppColor.white, fontSize: FontSize.sp_16),
                                ),
                              ],
                            ),
                          ) : const SizedBox(),
                        ],
                      ),
                    ),
                    VerticalSpacing(height: controller.added? Dimensions.h_60 : Dimensions.h_20),
                  ],
                ),
              ),
              bottomNavigationBar: controller.added ? Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w_60, vertical: Dimensions.h_8),
                height: Dimensions.h_100,
                width: double.infinity,
                color: AppColor.darkCardColor,
                child: Center(
                  child: AppButton(
                    style: AppTextStyle.buttonTextStyle(
                      color: AppColor.black,
                      fontSize: FontSize.sp_8
                    ),
                      title: "${controller.quantity.toString()} item added -->",
                      margin: EdgeInsets.zero,
                      onTap: () {
                        Get.toNamed(AppRoutes.cart,arguments: {
                          'controller' : controller
                        });
                      }
                  ),),
              ) : const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}


