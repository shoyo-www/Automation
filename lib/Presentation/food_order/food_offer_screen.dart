import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/Presentation/food_order/food_order_controller.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/food_offer_response.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/cache_image.dart';
import 'package:hotelautomationapp/widgets/common_appbar.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';
import 'package:readmore/readmore.dart';

class FoodOfferScreen extends StatelessWidget {
  const FoodOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FoodOrderController foodOrderController = Get.arguments['controller'];
    List<ApplicableItemsDatum>? applicableItemsData = Get.arguments['data'];
    CouponDatum couponDatum = Get.arguments['offerData'];
    return  GetBuilder(
      init: foodOrderController,
      builder: (controller) {
        return AppScaffold(
          bottom: false,
          body: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              if(orientation == Orientation.portrait) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                              height: Dimensions.h_200,
                              width: double.infinity,
                              child: CachedImageWidget(url: couponDatum.image ?? '', height: Dimensions.h_200,fit: BoxFit.cover)),
                          Positioned(
                              top: Dimensions.h_5,
                              left: Dimensions.w_10,
                              child: const CommonAppbar())
                        ],
                      ),
                      VerticalSpacing(height: Dimensions.h_20),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.w_15, right: Dimensions.w_15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                                title: couponDatum.name ?? '',
                                style: AppTextStyle.normalTextStyle(
                                    FontSize.sp_18, AppColor.white,
                                    weight: FontWeight.w500)),
                            VerticalSpacing(height: Dimensions.h_20),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: applicableItemsData?.length ?? 0,
                                shrinkWrap: true,
                                itemBuilder: (c,i) {
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
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_4, bottom: Dimensions.h_4),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                behavior: HitTestBehavior.opaque,
                                                onTap: () {
                                                  // Get.toNamed(AppRoutes.foodOrderDetail);
                                                },
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    AppTextWidget(
                                                      title:  applicableItemsData?[i].name ?? '',
                                                      style: AppTextStyle.normalTextStyle(
                                                        FontSize.sp_15,
                                                        AppColor.white,
                                                        weight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Dimensions.w_200,
                                                      child: ReadMoreText(
                                                        applicableItemsData?[i].description ?? '',
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
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              VerticalSpacing(height: Dimensions.h_5),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  AppTextWidget(
                                                    title:   '₹ ${couponDatum.discountType == 2 ?
                                                    (applicableItemsData?[i].price ?? 0) - (couponDatum.discountValue ?? 0) :
                                                    controller.getPercentage((applicableItemsData?[i].price ?? 0), (couponDatum.discountValue ?? 0)).toStringAsFixed(0)}',
                                                    style: AppTextStyle.normalTextStyle(
                                                      FontSize.sp_15,
                                                      AppColor.appColor,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  HorizontalSpacing(width: Dimensions.w_10),
                                                  AppTextWidget(
                                                    title: '₹ ${(applicableItemsData?[i].price ?? 0)}',
                                                    style: AppTextStyle.normalTextStyle(
                                                      decoration: TextDecoration.lineThrough,
                                                      FontSize.sp_13,
                                                      AppColor.appColor,
                                                      weight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              VerticalSpacing(height: Dimensions.h_10)
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Get.toNamed(AppRoutes.foodOrderDetail);
                                          },
                                          child: CachedImageWidget(url: applicableItemsData?[i].imageUrl ?? '', height: Dimensions.h_100,fit: BoxFit.cover, radius: 15),
                                        ),

                                      ],
                                    ),
                                  );
                                })

                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                            height: Dimensions.h_350,
                            width: double.infinity,
                            child: CachedImageWidget(url: couponDatum.image ?? '', height: Dimensions.h_200,fit: BoxFit.cover)),
                        Positioned(
                            top: Dimensions.h_5,
                            left: Dimensions.w_10,
                            child: const CommonAppbar())
                      ],
                    ),
                    VerticalSpacing(height: Dimensions.h_20),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.w_15, right: Dimensions.w_15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                              title: couponDatum.name ?? '',
                              style: AppTextStyle.normalTextStyle(
                                  FontSize.sp_12, AppColor.white,
                                  weight: FontWeight.w500)),
                          VerticalSpacing(height: Dimensions.h_20),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: applicableItemsData?.length ?? 0,
                              shrinkWrap: true,
                              itemBuilder: (c,i) {
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
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_4, bottom: Dimensions.h_4),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () {
                                                // Get.toNamed(AppRoutes.foodOrderDetail);
                                              },
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  AppTextWidget(
                                                    title:  applicableItemsData?[i].name ?? '',
                                                    style: AppTextStyle.normalTextStyle(
                                                      FontSize.sp_9,
                                                      AppColor.white,
                                                      weight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Dimensions.w_200,
                                                    child: ReadMoreText(
                                                      applicableItemsData?[i].description ?? '',
                                                      trimLines: 2,
                                                      colorClickableText: AppColor.white,
                                                      lessStyle: AppTextStyle.normalTextStyle(
                                                        FontSize.sp_6,
                                                        AppColor.white,
                                                        weight: FontWeight.w400,
                                                      ),
                                                      trimMode: TrimMode.Line,
                                                      textAlign: TextAlign.start,
                                                      trimCollapsedText: 'Read more',
                                                      trimExpandedText: 'Read less',
                                                      style: AppTextStyle.normalTextStyle(
                                                        FontSize.sp_6,
                                                        AppColor.neutral_500,
                                                        weight: FontWeight.w400,
                                                      ),
                                                      moreStyle: AppTextStyle.normalTextStyle(
                                                        FontSize.sp_6,
                                                        AppColor.white,
                                                        weight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            VerticalSpacing(height: Dimensions.h_5),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                AppTextWidget(
                                                  title:   '₹ ${couponDatum.discountType == 2 ?
                                                  (applicableItemsData?[i].price ?? 0) - (couponDatum.discountValue ?? 0) :
                                                  controller.getPercentage((applicableItemsData?[i].price ?? 0), (couponDatum.discountValue ?? 0)).toStringAsFixed(0)}',
                                                  style: AppTextStyle.normalTextStyle(
                                                    FontSize.sp_9,
                                                    AppColor.appColor,
                                                    weight: FontWeight.w600,
                                                  ),
                                                ),
                                                HorizontalSpacing(width: Dimensions.w_10),
                                                AppTextWidget(
                                                  title: '₹ ${(applicableItemsData?[i].price ?? 0)}',
                                                  style: AppTextStyle.normalTextStyle(
                                                    decoration: TextDecoration.lineThrough,
                                                    FontSize.sp_9,
                                                    AppColor.appColor,
                                                    weight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            VerticalSpacing(height: Dimensions.h_10)
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Get.toNamed(AppRoutes.foodOrderDetail);
                                        },
                                        child: CachedImageWidget(url: applicableItemsData?[i].imageUrl ?? '', height: Dimensions.w_80,fit: BoxFit.cover, radius: 15),
                                      ),

                                    ],
                                  ),
                                );
                              })

                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
