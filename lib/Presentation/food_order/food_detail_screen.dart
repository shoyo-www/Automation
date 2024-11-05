import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/Presentation/food_order/food_order_controller.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/food_order_request.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/appbutton.dart';
import 'package:hotelautomationapp/widgets/cache_image.dart';
import 'package:hotelautomationapp/widgets/common_appbar.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({super.key});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  late FoodOrderController foodOrderController;
  String? foodId;

  @override
  void initState() {
    foodOrderController = Get.arguments['controller'];
    foodId = Get.arguments['foodId'];
    foodOrderController.getFoodDDetail(foodId ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: foodOrderController,
      id: ControllerBuilders.singleFoodController,
      builder: ( controller) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            if(orientation == Orientation.portrait) {
             return AppScaffold(
                isLoading: controller.loading,
                bottom: false,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                            height: Dimensions.h_300,
                            width: double.infinity,
                            child: CachedImageWidget(url: controller.foodData?.imageUrl ?? '', height: Dimensions.h_200,fit: BoxFit.cover)),
                        Positioned(
                            top: Dimensions.h_15,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppTextWidget(
                                  title: StringUtils.capitalize(controller.foodData?.name ?? ''),
                                  style: AppTextStyle.normalTextStyle(
                                      FontSize.sp_20, AppColor.white,
                                      weight: FontWeight.w500)),
                              SizedBox(
                                height: Dimensions.h_20,
                                width: Dimensions.h_20,
                                child: Image.asset(controller.foodData?.type == 2 ? 'assets/Non veg.png' : 'assets/Veg.png'),
                              )
                            ],
                          ),
                          VerticalSpacing(height: Dimensions.h_20),
                          AppTextWidget(
                              title: 'Description',
                              style: AppTextStyle.normalTextStyle(
                                  FontSize.sp_14, AppColor.neutral_500,
                                  weight: FontWeight.w600)),
                          VerticalSpacing(height: Dimensions.h_6),
                          AppTextWidget(
                              maxLines: 4,
                              textOverflow: TextOverflow.visible,
                              title: controller.foodData?.description ?? '',
                              style: AppTextStyle.normalTextStyle(
                                  FontSize.sp_12, AppColor.neutral_500,
                                  weight: FontWeight.w300)),
                          VerticalSpacing(height: Dimensions.h_20),
                          AppTextWidget(
                              title: 'Ingredients',
                              style: AppTextStyle.normalTextStyle(
                                  FontSize.sp_14, AppColor.neutral_500,
                                  weight: FontWeight.w600)),
                          SizedBox(
                            width: Dimensions.w_260,
                            child: AppTextWidget(maxLines: 3,textOverflow: TextOverflow.visible,
                                title: (controller.foodData?.addOnDetails?.isNotEmpty ?? false)
                                    ? (controller.foodData?.addOnDetails?[0].inGridients?.join(', ') ?? '')
                                    : "",
                                style: AppTextStyle.normalTextStyle(
                                    FontSize.sp_12, AppColor.neutral_500,
                                    weight: FontWeight.w300)),
                          ),
                          VerticalSpacing(height: Dimensions.h_20),
                          Visibility(
                            visible: (controller.foodData?.addOnDetails?.isNotEmpty ?? false) && (controller.foodData?.addOnDetails?[0].choiceOfAddOn?.isNotEmpty ?? false) ,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextWidget(
                                    title: 'Choice of Add On',
                                    style: AppTextStyle.normalTextStyle(
                                        FontSize.sp_14, AppColor.neutral_500,
                                        weight: FontWeight.w600)),
                                VerticalSpacing(height: Dimensions.h_6),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.foodData?.choiceOfAddOn?.length,
                                    itemBuilder: (c,i) {
                                      return Row(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: Dimensions.h_20,
                                                width: Dimensions.h_20,
                                                child: CachedImageWidget(url: controller.foodData?.choiceOfAddOn?[i] ?? '', height: Dimensions.h_20,circle: true),
                                              ),
                                              AppTextWidget(title: controller.foodData?.choiceOfAddOn?[i] ?? '', style: AppTextStyle.themeBoldTextStyle()),
                                            ],
                                          ),
                                        ],
                                      );
                                    })
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w_10, vertical: Dimensions.w_15),
                  height: Dimensions.h_60,
                  width: double.infinity,
                  color: AppColor.darkCardColor,
                  child: Row(
                    children: [
                      HorizontalSpacing(width: Dimensions.w_10),
                      Container(
                        width: Dimensions.w_80,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColor.appColor,
                                width: 0.5
                            ),
                            borderRadius: BorderRadius.circular(Dimensions.h_12)
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    controller.singleQuantityDecrease();
                                  },
                                  child: Icon(Icons.remove,color: AppColor.appColor,size: Dimensions.h_12)),
                              AppTextWidget(title: controller.quantity.toString(), style: AppTextStyle.themeBoldTextStyle(fontSize:FontSize.sp_15,color: AppColor.appColor)),
                              GestureDetector(
                                  onTap: () {
                                    controller.singleQuantity();
                                  },
                                  child: Icon(Icons.add,color: AppColor.appColor,size: Dimensions.h_13)),

                            ],
                          ),
                        ),
                      ),
                      HorizontalSpacing(width: Dimensions.w_15),
                      Expanded(
                        child: AppButton(
                            borderRadius: Dimensions.h_13,
                            title: 'Add items - ₹ ${controller.foodData?.price ?? ''}',
                            margin: EdgeInsets.zero,
                            onTap: () {
                              controller.addDataInCart(FoodItem(
                                  name: controller.foodData?.name,
                                  price: controller.foodData?.price,
                                  foodId: controller.foodData?.id,
                                  image: controller.foodData?.imageUrl,
                                  type: controller.foodData?.type
                              ));
                              Get.toNamed(AppRoutes.cart,arguments: {
                                'controller' : controller
                              });
                            }),
                      ),
                      HorizontalSpacing(width: Dimensions.w_10),
                    ],
                  ),
                ),
              );

            }
            return AppScaffold(
              isLoading: controller.loading,
              bottom: false,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                            height: Dimensions.h_350,
                            width: double.infinity,
                            child: CachedImageWidget(url: controller.foodData?.imageUrl ?? '', height: Dimensions.h_300,fit: BoxFit.cover)),
                        Positioned(
                            top: Dimensions.h_15,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppTextWidget(
                                  title: StringUtils.capitalize(controller.foodData?.name ?? ''),
                                  style: AppTextStyle.normalTextStyle(
                                      FontSize.sp_13, AppColor.white,
                                      weight: FontWeight.w500)),
                              SizedBox(
                                height: Dimensions.h_20,
                                width: Dimensions.h_20,
                                child: Image.asset(controller.foodData?.type == 2 ? 'assets/Non veg.png' : 'assets/Veg.png'),
                              )
                            ],
                          ),
                          VerticalSpacing(height: Dimensions.h_20),
                          AppTextWidget(
                              title: 'Description',
                              style: AppTextStyle.normalTextStyle(
                                  FontSize.sp_9, AppColor.neutral_500,
                                  weight: FontWeight.w600)),
                          VerticalSpacing(height: Dimensions.h_6),
                          AppTextWidget(
                              maxLines: 4,
                              textOverflow: TextOverflow.visible,
                              title: controller.foodData?.description ?? '',
                              style: AppTextStyle.normalTextStyle(
                                  FontSize.sp_7, AppColor.neutral_500,
                                  weight: FontWeight.w300)),
                          VerticalSpacing(height: Dimensions.h_20),
                          AppTextWidget(
                              title: 'Ingredients',
                              style: AppTextStyle.normalTextStyle(
                                  FontSize.sp_8, AppColor.neutral_500,
                                  weight: FontWeight.w600)),
                          SizedBox(
                            width: Dimensions.w_260,
                            child: AppTextWidget(maxLines: 3,textOverflow: TextOverflow.visible,
                                title: (controller.foodData?.addOnDetails?.isNotEmpty ?? false)
                                    ? (controller.foodData?.addOnDetails?[0].inGridients?.join(', ') ?? '')
                                    : "",
                                style: AppTextStyle.normalTextStyle(
                                    FontSize.sp_6, AppColor.neutral_500,
                                    weight: FontWeight.w300)),
                          ),
                          VerticalSpacing(height: Dimensions.h_20),
                          Visibility(
                            visible: (controller.foodData?.addOnDetails?.isNotEmpty ?? false) && (controller.foodData?.addOnDetails?[0].choiceOfAddOn?.isNotEmpty ?? false) ,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextWidget(
                                    title: 'Choice of Add On',
                                    style: AppTextStyle.normalTextStyle(
                                        FontSize.sp_8, AppColor.neutral_500,
                                        weight: FontWeight.w600)),
                                VerticalSpacing(height: Dimensions.h_6),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.foodData?.choiceOfAddOn?.length,
                                    itemBuilder: (c,i) {
                                      return Row(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: Dimensions.h_20,
                                                width: Dimensions.h_20,
                                                child: CachedImageWidget(url: controller.foodData?.choiceOfAddOn?[i] ?? '', height: Dimensions.h_20,circle: true),
                                              ),
                                              AppTextWidget(title: controller.foodData?.choiceOfAddOn?[i] ?? '', style: AppTextStyle.normalTextStyle(
                                                 FontSize.sp_8,AppColor.neutral_500
                                              )),
                                            ],
                                          ),
                                        ],
                                      );
                                    })
                              ],
                            ),
                          ),
                
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w_10, vertical: Dimensions.h_8),
                height: Dimensions.h_110,
                width: double.infinity,
                color: AppColor.darkCardColor,
                child: Row(
                  children: [
                    HorizontalSpacing(width: Dimensions.w_10),
                    Container(
                      width: Dimensions.w_80,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColor.appColor,
                              width: 0.5
                          ),
                          borderRadius: BorderRadius.circular(Dimensions.h_12)
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  controller.singleQuantityDecrease();
                                },
                                child: Icon(Icons.remove,color: AppColor.appColor,size: Dimensions.h_8)),
                            AppTextWidget(title: controller.quantity.toString(), style: AppTextStyle.themeBoldTextStyle(fontSize:FontSize.sp_7,color: AppColor.appColor)),
                            GestureDetector(
                                onTap: () {
                                  controller.singleQuantity();
                                },
                                child: Icon(Icons.add,color: AppColor.appColor,size: Dimensions.h_8)),

                          ],
                        ),
                      ),
                    ),
                    HorizontalSpacing(width: Dimensions.w_15),
                    Expanded(
                      child: AppButton(
                          borderRadius: Dimensions.h_13,
                          style: AppTextStyle.buttonTextStyle(
                            color: AppColor.black,fontSize: FontSize.sp_8
                          ),
                          title: 'Add items - ₹ ${controller.foodData?.price ?? ''}',
                          margin: EdgeInsets.zero,
                          onTap: () {
                            controller.addDataInCart(FoodItem(
                                name: controller.foodData?.name,
                                price: controller.foodData?.price,
                                foodId: controller.foodData?.id,
                                image: controller.foodData?.imageUrl,
                                type: controller.foodData?.type
                            ));
                            Get.toNamed(AppRoutes.cart,arguments: {
                              'controller' : controller
                            });
                          }),
                    ),
                    HorizontalSpacing(width: Dimensions.w_10),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
