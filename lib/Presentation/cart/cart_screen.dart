import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelautomationapp/Presentation/food_order/food_order_controller.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/data/datasource/local/local_storage.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/otp_response.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';
import 'package:hotelautomationapp/widgets/appTextfield.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/appbutton.dart';
import 'package:hotelautomationapp/widgets/cache_image.dart';
import 'package:hotelautomationapp/widgets/common_appbar.dart';
import 'package:hotelautomationapp/widgets/dashed_divider.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FoodOrderController foodOrderController = Get.arguments['controller'];
    OtpResponse? userData = LocalStorage.getData();
    return GetBuilder(
      id: ControllerBuilders.cartScreen,
      init: foodOrderController,
      builder: (controller) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            if(orientation == Orientation.portrait) {
              return AppScaffold(
                bottom: false,
                body:SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.w_15, right: Dimensions.w_15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonAppbar(),
                          VerticalSpacing(height: Dimensions.h_12),
                          AppTextWidget(
                              title: 'Cart',
                              style: AppTextStyle.themeBoldNormalTextStyle(
                                  fontSize: FontSize.sp_22,
                                  color: AppColor.white)),
                          VerticalSpacing(height: Dimensions.h_5),
                          AppTextWidget(
                              title: 'Room${LocalStorage.getString(GetXStorageConstants.userRoomNo)}',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w300,
                                  fontSize: FontSize.sp_11,
                                  color: AppColor.neutral_500
                              )),
                          VerticalSpacing(height: Dimensions.h_20),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: controller.foodItems.length,
                              itemBuilder: (c,i) {
                                return Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(bottom: Dimensions.h_10, top: Dimensions.h_5),
                                      decoration: BoxDecoration(
                                        border: const Border(
                                          bottom: BorderSide(color: AppColor.neutral_600, width: 0.5),
                                          top: BorderSide(color: AppColor.neutral_600, width: 0.5),
                                          right: BorderSide(color: AppColor.neutral_600, width: 0.5),
                                        ),
                                        borderRadius: BorderRadius.circular(Dimensions.h_10),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CachedImageWidget(url:  controller.foodItems[i].image ?? '', height: Dimensions.h_80, radius: 15,fit: BoxFit.cover),
                                          Padding(
                                            padding: EdgeInsets.only(left: Dimensions.w_15, top: Dimensions.h_4, bottom: Dimensions.h_4),
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
                                                        title:  controller.foodItems[i].name ?? '',
                                                        style: AppTextStyle.normalTextStyle(
                                                          FontSize.sp_15,
                                                          AppColor.white,
                                                          weight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      AppTextWidget(
                                                        title: "Add on-${controller.foodItems[i].addon?.isNotEmpty ?? false ?controller.foodItems[i].addon : 'No add on '}",
                                                        style: AppTextStyle.normalTextStyle(
                                                          FontSize.sp_11,
                                                          AppColor.white,
                                                          weight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                VerticalSpacing(height: Dimensions.h_13),
                                                AppTextWidget(
                                                  title: '₹ ${controller.foodItems[i].price}',
                                                  style: AppTextStyle.normalTextStyle(
                                                    FontSize.sp_15,
                                                    AppColor.appColor,
                                                    weight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: Dimensions.w_10,
                                      top: Dimensions.h_20,
                                      child: SizedBox(
                                        height: Dimensions.h_15,
                                        width: Dimensions.h_15,
                                        child: Image.asset('assets/Non veg.png'),
                                      ),
                                    )
                                  ],
                                );
                              }),
                          VerticalSpacing(height: Dimensions.h_10),
                          AppTextField(
                              radius: Dimensions.h_25,
                              textStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w300,
                                  fontSize: FontSize.sp_13,
                                  color: AppColor.black
                              ),
                              hintText: 'Apply Code',
                              title: '',
                              controller: TextEditingController(),
                              borderEnable: true,
                              hintStyle: GoogleFonts.inter(
                                  fontSize: FontSize.sp_14,
                                  fontWeight: FontWeight.w300,
                                  color: const Color(0xFFA1A1A1)
                              ),
                              color: AppColor.transparent),
                          VerticalSpacing(height: Dimensions.h_4),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColor.darkCardColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(Dimensions.h_10)
                            ),
                            child:  Column(
                              children: [
                                VerticalSpacing(height: Dimensions.h_15),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: Dimensions.h_15,
                                      width: Dimensions.h_15,
                                      child: Image.asset('assets/delivery_dining.png'),
                                    ),
                                    HorizontalSpacing(width: Dimensions.w_20),
                                    AppTextWidget(title: 'Delivery in', style: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.neutral_600,weight: FontWeight.w400)),
                                    HorizontalSpacing(width: Dimensions.w_5),
                                    AppTextWidget(title: '20 mins', style: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.white,weight: FontWeight.w600)),
                                  ],
                                ),
                                VerticalSpacing(height: Dimensions.h_15),
                                const DashedDivider(color: AppColor.neutral_700),
                                VerticalSpacing(height: Dimensions.h_15),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: Dimensions.h_10,
                                      width: Dimensions.h_10,
                                      child: Image.asset('assets/Home full.png'),
                                    ),
                                    HorizontalSpacing(width: Dimensions.w_25),
                                    AppTextWidget(title: 'Delivery at ', style: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.neutral_600,weight: FontWeight.w400)),
                                    HorizontalSpacing(width: Dimensions.w_5),
                                    AppTextWidget(title: 'Room No. ${LocalStorage.getString(GetXStorageConstants.userRoomNo)}', style: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.white,weight: FontWeight.w600)),
                                  ],
                                ),
                                VerticalSpacing(height: Dimensions.h_15),
                                const DashedDivider(color: AppColor.neutral_700),
                                VerticalSpacing(height: Dimensions.h_15),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: Dimensions.h_10,
                                      width: Dimensions.h_10,
                                      child: Image.asset('assets/Reception fulll.png'),
                                    ),
                                    HorizontalSpacing(width: Dimensions.w_25),
                                    AppTextWidget(title: userData?.data?.user?.name ?? '', style: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.neutral_600,weight: FontWeight.w400)),
                                    HorizontalSpacing(width: Dimensions.w_5),
                                    AppTextWidget(title: userData?.data?.user?.phoneNumber ?? '', style: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.white,weight: FontWeight.w600)),
                                  ],
                                ),
                                VerticalSpacing(height: Dimensions.h_15),
                                const DashedDivider(color: AppColor.neutral_700),
                                VerticalSpacing(height: Dimensions.h_8),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: Dimensions.h_15,
                                      width: Dimensions.h_15,
                                      child: Image.asset('assets/notes.png'),
                                    ),
                                    HorizontalSpacing(width: Dimensions.w_20),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AppTextWidget(title: 'Total Bill ', style: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.neutral_600,weight: FontWeight.w400)),
                                            HorizontalSpacing(width: Dimensions.w_5),
                                            AppTextWidget(title: '₹ ${controller.getTotalPrice()}', style: AppTextStyle.normalTextStyle(FontSize.sp_12, AppColor.white,weight: FontWeight.w600)),
                                          ],
                                        ),
                                        AppTextWidget(title: 'Incl. Taxes and charges', style: AppTextStyle.normalTextStyle(FontSize.sp_10, AppColor.neutral_600,weight: FontWeight.w400)),

                                      ],
                                    ),

                                  ],
                                ),
                                VerticalSpacing(height: Dimensions.h_8)
                              ],
                            ),
                          ),
                          VerticalSpacing(height: Dimensions.h_80)
                        ]),
                  ),
                ),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w_10, vertical: Dimensions.w_15),
                  height: Dimensions.h_60,
                  width: double.infinity,
                  color: AppColor.darkCardColor,
                  child: AppButton(
                    style: AppTextStyle.buttonTextStyle(
                      color: AppColor.black
                    ),
                      loading: controller.buttonLoading,
                      borderRadius: Dimensions.h_13,
                      title: 'Place Order - ₹ ${controller.getTotalPrice()}',
                      margin: EdgeInsets.only(left: Dimensions.w_25,right: Dimensions.w_25),
                      onTap: () {
                        controller.foodOrder();
                      }),
                ),
              );

            }
            return  AppScaffold(
              bottom: false,
              body:SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.w_15, right: Dimensions.w_15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CommonAppbar(),
                        VerticalSpacing(height: Dimensions.h_12),
                        AppTextWidget(
                            title: 'Cart',
                            style: AppTextStyle.themeBoldNormalTextStyle(
                                fontSize: FontSize.sp_12,
                                color: AppColor.white)),
                        VerticalSpacing(height: Dimensions.h_5),
                        AppTextWidget(
                            title: 'Room${LocalStorage.getString(GetXStorageConstants.userRoomNo)}',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w300,
                                fontSize: FontSize.sp_8,
                                color: AppColor.neutral_500
                            )),
                        VerticalSpacing(height: Dimensions.h_20),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: controller.foodItems.length,
                            itemBuilder: (c,i) {
                              return Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(bottom: Dimensions.h_5, top: Dimensions.h_5),
                                    decoration: BoxDecoration(
                                      border: const Border(
                                        bottom: BorderSide(color: AppColor.neutral_600, width: 0.5),
                                        top: BorderSide(color: AppColor.neutral_600, width: 0.5),
                                        right: BorderSide(color: AppColor.neutral_600, width: 0.5),
                                      ),
                                      borderRadius: BorderRadius.circular(Dimensions.h_10),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CachedImageWidget(url:  controller.foodItems[i].image ?? '', height: Dimensions.w_50, radius: 15,fit: BoxFit.cover),
                                        Padding(
                                          padding: EdgeInsets.only(left: Dimensions.w_15, top: Dimensions.h_4, bottom: Dimensions.h_4),
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
                                                      title:  StringUtils.capitalize(controller.foodItems[i].name ?? ''),
                                                      style: AppTextStyle.normalTextStyle(
                                                        FontSize.sp_8,
                                                        AppColor.white,
                                                        weight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    AppTextWidget(
                                                      title: "Add on-${controller.foodItems[i].addon?.isNotEmpty ?? false ?controller.foodItems[i].addon : 'No add on '}",
                                                      style: AppTextStyle.normalTextStyle(
                                                        FontSize.sp_6,
                                                        AppColor.neutral_600,
                                                        weight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              VerticalSpacing(height: Dimensions.h_5),
                                              AppTextWidget(
                                                title: '₹ ${controller.foodItems[i].price}',
                                                style: AppTextStyle.normalTextStyle(
                                                  FontSize.sp_9,
                                                  AppColor.appColor,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: Dimensions.w_10,
                                    top: Dimensions.h_20,
                                    child: SizedBox(
                                      height: Dimensions.h_15,
                                      width: Dimensions.h_15,
                                      child: Image.asset('assets/Non veg.png'),
                                    ),
                                  )
                                ],
                              );
                            }),
                        VerticalSpacing(height: Dimensions.h_10),
                        AppTextField(
                            radius: Dimensions.h_25,
                            textStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w300,
                                fontSize: FontSize.sp_8,
                                color: AppColor.black
                            ),
                            hintText: 'Apply Code',
                            title: '',
                            controller: TextEditingController(),
                            borderEnable: true,
                            hintStyle: GoogleFonts.inter(
                                fontSize: FontSize.sp_8,
                                fontWeight: FontWeight.w300,
                                color: const Color(0xFFA1A1A1)
                            ),
                            color: AppColor.transparent),
                        VerticalSpacing(height: Dimensions.h_4),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColor.darkCardColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(Dimensions.h_10)
                          ),
                          child:  Column(
                            children: [
                              VerticalSpacing(height: Dimensions.h_15),
                              Row(
                                children: [
                                  SizedBox(
                                    height: Dimensions.h_15,
                                    width: Dimensions.h_15,
                                    child: Image.asset('assets/delivery_dining.png'),
                                  ),
                                  HorizontalSpacing(width: Dimensions.w_20),
                                  AppTextWidget(title: 'Delivery in', style: AppTextStyle.normalTextStyle(FontSize.sp_6, AppColor.neutral_600,weight: FontWeight.w400)),
                                  HorizontalSpacing(width: Dimensions.w_5),
                                  AppTextWidget(title: '20 mins', style: AppTextStyle.normalTextStyle(FontSize.sp_6, AppColor.white,weight: FontWeight.w600)),
                                ],
                              ),
                              VerticalSpacing(height: Dimensions.h_15),
                              const DashedDivider(color: AppColor.neutral_700),
                              VerticalSpacing(height: Dimensions.h_15),
                              Row(
                                children: [
                                  SizedBox(
                                    height: Dimensions.h_10,
                                    width: Dimensions.h_10,
                                    child: Image.asset('assets/Home full.png'),
                                  ),
                                  HorizontalSpacing(width: Dimensions.w_20),
                                  AppTextWidget(title: ' Delivery at ', style: AppTextStyle.normalTextStyle(FontSize.sp_6, AppColor.neutral_600,weight: FontWeight.w400)),
                                  HorizontalSpacing(width: Dimensions.w_5),
                                  AppTextWidget(title: 'Room No. ${LocalStorage.getString(GetXStorageConstants.userRoomNo)}', style: AppTextStyle.normalTextStyle(FontSize.sp_6, AppColor.white,weight: FontWeight.w600)),
                                ],
                              ),
                              VerticalSpacing(height: Dimensions.h_15),
                              const DashedDivider(color: AppColor.neutral_700),
                              VerticalSpacing(height: Dimensions.h_15),
                              Row(
                                children: [
                                  SizedBox(
                                    height: Dimensions.h_10,
                                    width: Dimensions.h_12,
                                    child: Image.asset('assets/Reception fulll.png'),
                                  ),
                                  HorizontalSpacing(width: Dimensions.w_20),
                                  AppTextWidget(title: userData?.data?.user?.name ?? '', style: AppTextStyle.normalTextStyle(FontSize.sp_6, AppColor.neutral_600,weight: FontWeight.w400)),
                                  HorizontalSpacing(width: Dimensions.w_5),
                                  AppTextWidget(title: userData?.data?.user?.phoneNumber ?? '', style: AppTextStyle.normalTextStyle(FontSize.sp_6, AppColor.white,weight: FontWeight.w600)),
                                ],
                              ),
                              VerticalSpacing(height: Dimensions.h_15),
                              const DashedDivider(color: AppColor.neutral_700),
                              VerticalSpacing(height: Dimensions.h_8),
                              Row(
                                children: [
                                  SizedBox(
                                    height: Dimensions.h_15,
                                    width: Dimensions.h_15,
                                    child: Image.asset('assets/notes.png'),
                                  ),
                                  HorizontalSpacing(width: Dimensions.w_20),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          AppTextWidget(title: 'Total Bill ', style: AppTextStyle.normalTextStyle(FontSize.sp_6, AppColor.neutral_600,weight: FontWeight.w400)),
                                          HorizontalSpacing(width: Dimensions.w_5),
                                          AppTextWidget(title: '₹ ${controller.getTotalPrice()}', style: AppTextStyle.normalTextStyle(FontSize.sp_6, AppColor.white,weight: FontWeight.w600)),
                                        ],
                                      ),
                                      AppTextWidget(title: 'Incl. Taxes and charges', style: AppTextStyle.normalTextStyle(FontSize.sp_6, AppColor.neutral_600,weight: FontWeight.w400)),

                                    ],
                                  ),

                                ],
                              ),
                              VerticalSpacing(height: Dimensions.h_8)
                            ],
                          ),
                        ),
                        VerticalSpacing(height: Dimensions.h_80)
                      ]),
                ),
              ),
              bottomNavigationBar: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w_10, vertical: Dimensions.h_10),
                width: double.infinity,
                height: Dimensions.h_50,
                color: AppColor.darkCardColor,
                child: AppButton(
                  style: AppTextStyle.buttonTextStyle(
                    fontSize: FontSize.sp_8,color: AppColor.black
                  ),
                    loading: controller.buttonLoading,
                    borderRadius: Dimensions.h_13,
                    title: 'Place Order - ₹ ${controller.getTotalPrice()}',
                    margin: EdgeInsets.only(left: Dimensions.w_25,right: Dimensions.w_25),
                    onTap: () {
                      controller.foodOrder();
                    }),
              ),
            );
          },
        );
      },
    );

  }
}
