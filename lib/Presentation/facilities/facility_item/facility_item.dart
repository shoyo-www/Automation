import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/Presentation/facilities/facitlity_controller.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_single_category.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/appbutton.dart';
import 'package:hotelautomationapp/widgets/cache_image.dart';
import 'package:hotelautomationapp/widgets/common_appbar.dart';
import 'package:hotelautomationapp/widgets/app_snackbar.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';
import 'package:readmore/readmore.dart';

class FacilityItemScreen extends StatefulWidget {
  const FacilityItemScreen({super.key});

  @override
  State<FacilityItemScreen> createState() => _FacilityItemScreenState();
}

class _FacilityItemScreenState extends State<FacilityItemScreen> {
  late FacilitiesController fController;
  late HotelFacilityTypesDatum data;


  @override
  void initState() {
    fController = Get.arguments['fController'];
    data = Get.arguments['data'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: fController,
      builder: (controller) {
        return  OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            if(orientation == Orientation.portrait) {
              return AppScaffold(
                  bottom: false,
                  body:  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                                height: Dimensions.h_250,
                                width: double.infinity,
                                child: CachedImageWidget(url: data.image ?? '', height: Dimensions.h_250,fit: BoxFit.cover)),
                            Positioned(
                                top: Dimensions.h_15,
                                left: Dimensions.w_10,
                                child: CommonAppbar(onTap: () {
                                  controller.isVisible.value ? controller.getBack() : Get.back();
                                },))
                          ],
                        ),
                        VerticalSpacing(height: Dimensions.h_20),
                        Padding(
                          padding: EdgeInsets.only(
                              left: Dimensions.w_15, right: Dimensions.w_15),
                          child: Column(
                            children: [
                              Obx(() {
                                return Visibility(
                                  visible: controller.isVisible.value == false,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: Dimensions.w_5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppTextWidget(
                                            title: data.name ?? '',
                                            style: AppTextStyle.normalTextStyle(
                                                FontSize.sp_20, AppColor.white,
                                                weight: FontWeight.w500)),
                                        VerticalSpacing(height: Dimensions.h_20),
                                        AppTextWidget(
                                            title: 'Description',
                                            style: AppTextStyle.normalTextStyle(
                                                FontSize.sp_14, AppColor.neutral_500,
                                                weight: FontWeight.w600)),
                                        VerticalSpacing(height: Dimensions.h_6),
                                        ReadMoreText(
                                          data.description ?? '',
                                          trimLines: 4,
                                          colorClickableText: AppColor.white,
                                          lessStyle: AppTextStyle.normalTextStyle(
                                              FontSize.sp_13, AppColor.white,
                                              weight: FontWeight.w600),
                                          trimMode: TrimMode.Line,
                                          textAlign: TextAlign.start,
                                          trimCollapsedText: 'Show more',
                                          trimExpandedText: 'Show less',
                                          style: AppTextStyle.normalTextStyle(
                                              FontSize.sp_13, AppColor.neutral_500,
                                              weight: FontWeight.w300),
                                          moreStyle: AppTextStyle.normalTextStyle(
                                              FontSize.sp_13, AppColor.white,
                                              weight: FontWeight.w600),
                                        ),
                                        VerticalSpacing(height: Dimensions.h_20),
                                        AppTextWidget(
                                            title: 'Cuisine',
                                            style: AppTextStyle.normalTextStyle(
                                                FontSize.sp_14, AppColor.neutral_500,
                                                weight: FontWeight.w600)),
                                        AppTextWidget(
                                            title: data.cuisine ?? '',
                                            style: AppTextStyle.normalTextStyle(
                                                FontSize.sp_12, AppColor.neutral_500,
                                                weight: FontWeight.w400)),
                                        VerticalSpacing(height: Dimensions.h_20),
                                        AppTextWidget(
                                            title: 'Timings',
                                            style: AppTextStyle.normalTextStyle(
                                                FontSize.sp_14, AppColor.neutral_500,
                                                weight: FontWeight.w600)),
                                        AppTextWidget(
                                            maxLines: 3,
                                            textOverflow: TextOverflow.visible,
                                            title:
                                            'Opens at ${data.startTime}AM and Close at ${data.endTime} PM',
                                            style: AppTextStyle.normalTextStyle(
                                                FontSize.sp_12, AppColor.neutral_500,
                                                weight: FontWeight.w400)),
                                        VerticalSpacing(height: Dimensions.h_6),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              Obx(() {
                                return Visibility(
                                  visible: controller.isVisible.value == true,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      VerticalSpacing(height: Dimensions.h_15),
                                      GestureDetector(
                                        onTap: () {
                                          controller.showDateDialog(context);
                                        },
                                        child: Container(
                                          height: Dimensions.h_50,
                                          padding: EdgeInsets.only(
                                              left: Dimensions.w_15, right: Dimensions.w_15),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF363636).withOpacity(0.4),
                                              borderRadius:
                                              BorderRadius.circular(Dimensions.h_10)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              GetBuilder(
                                                init: controller,
                                                builder: (controller) {
                                                  return AppTextWidget(
                                                      title: (controller.datePicked?.isNotEmpty ?? false) ? controller.datePicked ?? '' :'Date And Time',
                                                      style: AppTextStyle.normalTextStyle(
                                                          FontSize.sp_14, AppColor.white,
                                                          weight: FontWeight.w500));
                                                },
                                              ),
                                              SizedBox(
                                                height: Dimensions.h_20,
                                                width: Dimensions.h_20,
                                                child:
                                                Image.asset('assets/calendar_today.png'),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      VerticalSpacing(height: Dimensions.h_15),
                                      Theme(
                                        data: ThemeData(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                        ),
                                        child:  Stack(
                                          children: [
                                            Card(
                                                margin: EdgeInsets.only(bottom: Dimensions.h_15),
                                                color: const Color(0xFF363636).withOpacity(0.4),
                                                child: Obx(() {
                                                  return ExpansionTile(
                                                    initiallyExpanded: controller.isExpanded,
                                                    onExpansionChanged: (e) {
                                                      controller.onChanged(e);
                                                    },
                                                    trailing: controller.isChanged.value ?const Icon(
                                                      Icons.arrow_drop_up,
                                                      color: AppColor.white,
                                                    ) : const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: AppColor.white,
                                                    ),
                                                    iconColor: AppColor.white,
                                                    collapsedShape:  ContinuousRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.h_18))
                                                    ),
                                                    shape:  ContinuousRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.h_18))
                                                    ),
                                                    title: Padding(
                                                      padding:  EdgeInsets.only(left: Dimensions.w_6),
                                                      child: AppTextWidget(title:controller.guests.value, style: AppTextStyle.normalTextStyle(
                                                          FontSize.sp_14, AppColor.white,
                                                          weight: FontWeight.w500)),
                                                    ),
                                                    children :  <Widget>[
                                                      ListView.builder(
                                                          itemCount: 10,
                                                          shrinkWrap: true,
                                                          itemBuilder: (c,index) {
                                                            return  GestureDetector(
                                                              behavior: HitTestBehavior.opaque,
                                                              onTap: () {
                                                                controller.getGuests(index);
                                                              },
                                                              child: Padding(
                                                                padding:  EdgeInsets.only(left: Dimensions.w_20,bottom: Dimensions.h_15),
                                                                child: AppTextWidget(title: '${index + 1}', style: AppTextStyle.normalTextStyle(
                                                                    FontSize.sp_14, AppColor.white,
                                                                    weight: FontWeight.w500)),
                                                              ),
                                                            );
                                                          })

                                                    ],
                                                  );
                                                })
                                            ),
                                          ],
                                        ),
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
                  ),
                  bottomNavigationBar: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w_60, vertical: Dimensions.w_15),
                    height: Dimensions.h_60,
                    width: double.infinity,
                    color: AppColor.darkCardColor,
                    child: Center(
                      child:  AppButton(
                        style: AppTextStyle.buttonTextStyle(
                          color: AppColor.black
                        ),
                          loading: fController.buttonLoading,
                          title: "Reserve a table",
                          margin: EdgeInsets.zero,
                          onTap: () => fController.isVisible.value == false ? fController.checkAvailability() : fController.bookService(data.facilityId ?? '',data.id ?? '')),
                    ),
                  ));
            }
            return AppScaffold(
                bottom: false,
                body:  SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                              height: Dimensions.h_400,
                              width: double.infinity,
                              child: CachedImageWidget(url: data.image ?? '', height: Dimensions.h_400,fit: BoxFit.cover)),
                          Positioned(
                              top: Dimensions.h_15,
                              left: Dimensions.w_10,
                              child: CommonAppbar(onTap: () {
                                controller.isVisible.value ? controller.getBack() : Get.back();
                              },))
                        ],
                      ),
                      VerticalSpacing(height: Dimensions.h_20),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.w_15, right: Dimensions.w_15,bottom: Dimensions.h_50),
                        child: Column(
                          children: [
                            Obx(() {
                              return Visibility(
                                visible: controller.isVisible.value == false,
                                child: Padding(
                                  padding: EdgeInsets.only(right: Dimensions.w_5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                          title: StringUtils.capitalize(data.name ?? ''),
                                          style: AppTextStyle.normalTextStyle(
                                              FontSize.sp_11, AppColor.white,
                                              weight: FontWeight.w500)),
                                      VerticalSpacing(height: Dimensions.h_20),
                                      AppTextWidget(
                                          title: 'Description',
                                          style: AppTextStyle.normalTextStyle(
                                              FontSize.sp_8, AppColor.neutral_500,
                                              weight: FontWeight.w600)),
                                      VerticalSpacing(height: Dimensions.h_6),
                                      ReadMoreText(
                                        data.description ?? '',
                                        trimLines: 4,
                                        colorClickableText: AppColor.white,
                                        lessStyle: AppTextStyle.normalTextStyle(
                                            FontSize.sp_7, AppColor.white,
                                            weight: FontWeight.w600),
                                        trimMode: TrimMode.Line,
                                        textAlign: TextAlign.start,
                                        trimCollapsedText: 'Show more',
                                        trimExpandedText: 'Show less',
                                        style: AppTextStyle.normalTextStyle(
                                            FontSize.sp_7, AppColor.neutral_500,
                                            weight: FontWeight.w300),
                                        moreStyle: AppTextStyle.normalTextStyle(
                                            FontSize.sp_7, AppColor.white,
                                            weight: FontWeight.w600),
                                      ),
                                      VerticalSpacing(height: Dimensions.h_10),
                                      AppTextWidget(
                                          title: 'Cuisine',
                                          style: AppTextStyle.normalTextStyle(
                                              FontSize.sp_8, AppColor.neutral_500,
                                              weight: FontWeight.w600)),
                                      AppTextWidget(
                                          title: data.cuisine ?? '',
                                          style: AppTextStyle.normalTextStyle(
                                              FontSize.sp_6, AppColor.neutral_500,
                                              weight: FontWeight.w400)),
                                      VerticalSpacing(height: Dimensions.h_10),
                                      AppTextWidget(
                                          title: 'Timings',
                                          style: AppTextStyle.normalTextStyle(
                                              FontSize.sp_8, AppColor.neutral_500,
                                              weight: FontWeight.w600)),
                                      AppTextWidget(
                                          maxLines: 3,
                                          textOverflow: TextOverflow.visible,
                                          title:
                                          'Opens at ${data.startTime}AM and Close at ${data.endTime} PM',
                                          style: AppTextStyle.normalTextStyle(
                                              FontSize.sp_6, AppColor.neutral_500,
                                              weight: FontWeight.w400)),
                                      VerticalSpacing(height: Dimensions.h_15),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            Obx(() {
                              return Visibility(
                                visible: controller.isVisible.value == true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    VerticalSpacing(height: Dimensions.h_15),
                                    GestureDetector(
                                      onTap: () {
                                        controller.showDateDialog(context);
                                      },
                                      child: Container(
                                        height: Dimensions.h_50,
                                        padding: EdgeInsets.only(
                                            left: Dimensions.w_15, right: Dimensions.w_15),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF363636).withOpacity(0.4),
                                            borderRadius:
                                            BorderRadius.circular(Dimensions.h_10)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            GetBuilder(
                                              init: controller,
                                              builder: (controller) {
                                                return AppTextWidget(
                                                    title: (controller.datePicked?.isNotEmpty ?? false) ? controller.datePicked ?? '' :'Date And Time',
                                                    style: AppTextStyle.normalTextStyle(
                                                        FontSize.sp_7, AppColor.white,
                                                        weight: FontWeight.w500));
                                              },
                                            ),
                                            SizedBox(
                                              height: Dimensions.h_20,
                                              width: Dimensions.h_20,
                                              child:
                                              Image.asset('assets/calendar_today.png'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    VerticalSpacing(height: Dimensions.h_15),
                                    Theme(
                                      data: ThemeData(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                      ),
                                      child:  Stack(
                                        children: [
                                          Card(
                                              margin: EdgeInsets.only(bottom: Dimensions.h_15),
                                              color: const Color(0xFF363636).withOpacity(0.4),
                                              child: Obx(() {
                                                return ExpansionTile(
                                                  initiallyExpanded: controller.isExpanded,
                                                  onExpansionChanged: (e) {
                                                    controller.onChanged(e);
                                                  },
                                                  trailing: controller.isChanged.value ?const Icon(
                                                    Icons.arrow_drop_up,
                                                    color: AppColor.white,
                                                  ) : const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: AppColor.white,
                                                  ),
                                                  iconColor: AppColor.white,
                                                  collapsedShape:  ContinuousRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.h_18))
                                                  ),
                                                  shape:  ContinuousRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.h_18))
                                                  ),
                                                  title: Padding(
                                                    padding:  EdgeInsets.only(left: Dimensions.w_6),
                                                    child: AppTextWidget(title:controller.guests.value, style: AppTextStyle.normalTextStyle(
                                                        FontSize.sp_7, AppColor.white,
                                                        weight: FontWeight.w500)),
                                                  ),
                                                  children :  <Widget>[
                                                    ListView.builder(
                                                        itemCount: 10,
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemBuilder: (c,index) {
                                                          return  GestureDetector(
                                                            behavior: HitTestBehavior.opaque,
                                                            onTap: () {
                                                              controller.getGuests(index);
                                                            },
                                                            child: Padding(
                                                              padding:  EdgeInsets.only(left: Dimensions.w_20,bottom: Dimensions.h_15),
                                                              child: AppTextWidget(title: '${index + 1}', style: AppTextStyle.normalTextStyle(
                                                                  FontSize.sp_7, AppColor.white,
                                                                  weight: FontWeight.w500)),
                                                            ),
                                                          );
                                                        })

                                                  ],
                                                );
                                              })
                                          ),
                                        ],
                                      ),
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
                ),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w_60, vertical: Dimensions.w_15),
                  height: Dimensions.h_150,
                  width: double.infinity,
                  color: AppColor.darkCardColor,
                  child: Center(
                    child:  AppButton(
                      style: AppTextStyle.buttonTextStyle(
                        color: AppColor.black,fontSize: FontSize.sp_8
                      ),
                        loading: fController.buttonLoading,
                        title: "Reserve a table",
                        margin: EdgeInsets.zero,
                        onTap: () => fController.isVisible.value == false ? fController.checkAvailability() : fController.bookService(data.facilityId ?? '',data.id ?? '')),
                  ),
                ));
          },
        );
      },
    );
  }
}
