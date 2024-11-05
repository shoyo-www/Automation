import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelautomationapp/Presentation/services/service_controller.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';
import 'package:hotelautomationapp/widgets/app_snackbar.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/appbutton.dart';
import 'package:hotelautomationapp/widgets/common_appbar.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';

class ReviewRequest extends StatefulWidget {
  const ReviewRequest({super.key});

  @override
  State<ReviewRequest> createState() => _ReviewRequestState();
}

class _ReviewRequestState extends State<ReviewRequest> {
  late ServiceController serviceController;
  late String id;

  @override
  void initState() {
    serviceController = Get.arguments['Controller'];
    id = Get.arguments['id'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: serviceController,
      id: ControllerBuilders.reviewController,
      builder: (controller) {
        return AppScaffold(
            body: OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) { 
                if(orientation == Orientation.portrait) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.w_15, right: Dimensions.w_15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CommonAppbar(),
                        VerticalSpacing(height: Dimensions.h_8),
                        AppTextWidget(
                            title: 'Review Request',
                            style: AppTextStyle.themeBoldNormalTextStyle(
                                fontSize: FontSize.sp_22,
                                color: AppColor.serviceTextColor)),
                        VerticalSpacing(height: Dimensions.h_15),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              Map<String, List<AddRequest>> groupedItems = {};

                              for (var request in controller.addRequest) {
                                groupedItems.putIfAbsent(request.title ?? '', () => []).add(request);
                              }

                              return ListView(
                                children: groupedItems.entries.map((entry) {
                                  String title = entry.key;
                                  List<AddRequest> items = entry.value;

                                  return Container(
                                    margin: EdgeInsets.only(bottom: Dimensions.h_15),
                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_12),
                                    decoration: BoxDecoration(
                                      color: AppColor.darkCardColor,
                                      borderRadius: BorderRadius.circular(Dimensions.h_10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppTextWidget(
                                          title: title,
                                          style: GoogleFonts.inter(
                                            color: AppColor.serviceTextColor,
                                            fontSize: FontSize.sp_16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        VerticalSpacing(height: Dimensions.h_10),
                                        ...items.map((item) {
                                          int itemIndex = controller.addRequest.indexOf(item); // Get the index for deletion

                                          return Container(
                                            margin: EdgeInsets.only(bottom: Dimensions.h_10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      AppTextWidget(
                                                        title: item.subtitle ?? '',
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.serviceTextColor,
                                                          fontSize: FontSize.sp_13,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: Dimensions.w_280,
                                                        child: AppTextWidget(
                                                          maxLines: 3,
                                                          textOverflow: TextOverflow.visible,
                                                          title: item.description ?? '',
                                                          style: GoogleFonts.inter(
                                                            color: AppColor.serviceTextColor,
                                                            fontSize: FontSize.sp_10,
                                                            fontWeight: FontWeight.w200,
                                                          ),
                                                        ),
                                                      ),
                                                      VerticalSpacing(height: Dimensions.h_10),
                                                      (item.details?.isNotEmpty ?? false)
                                                          ? Row(
                                                        children: [
                                                          AppTextWidget(
                                                            title: "Details: ",
                                                            style: GoogleFonts.inter(
                                                              fontWeight: FontWeight.w400,
                                                              color: AppColor.serviceTextColor,
                                                              fontSize: FontSize.sp_11,
                                                            ),
                                                          ),
                                                          HorizontalSpacing(width: Dimensions.w_5),
                                                          AppTextWidget(
                                                            title: item.details ?? "",
                                                            style: GoogleFonts.inter(
                                                              fontWeight: FontWeight.w400,
                                                              color: AppColor.serviceTextColor,
                                                              fontSize: FontSize.sp_11,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                          : GestureDetector(
                                                        behavior: HitTestBehavior.opaque,
                                                        onTap: () async {
                                                          Get.toNamed(AppRoutes.addDetail, arguments: {
                                                            'controller': controller,
                                                            'title': item.title,
                                                            'subTitle': item.subtitle,
                                                            'desc': item.description,
                                                            'index': itemIndex,
                                                            'id': id,
                                                          });
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets.only(
                                                            top: Dimensions.h_2,
                                                            bottom: Dimensions.h_2,
                                                            right: Dimensions.w_5,
                                                            left: Dimensions.w_5,
                                                          ),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: AppColor.appColor,
                                                            ),
                                                            borderRadius: BorderRadius.circular(Dimensions.h_6),
                                                          ),
                                                          child: AppTextWidget(
                                                            title: 'Add Details',
                                                            style: GoogleFonts.inter(
                                                              fontWeight: FontWeight.w700,
                                                              color: AppColor.appColor,
                                                              fontSize: FontSize.sp_11,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      VerticalSpacing(height: Dimensions.h_10),
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(onTap: () {
                                                  controller.removeData(itemIndex);
                                                },child: const Icon(Icons.delete, color: AppColor.appColor)),

                                              ],
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                        AppButton(loading: controller.buttonLoading,title: 'Submit',onTap: () {
                          if(controller.category.isNotEmpty) {
                            controller.bookService(id,controller.category,controller);
                          } else {
                            showAppSnack(context, 'Please Add services', false);
                          }
                        }),
                        VerticalSpacing(height: Dimensions.h_5)
                      ],),
                  );
                  
                } 
                return Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.w_15, right: Dimensions.w_15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonAppbar(),
                      VerticalSpacing(height: Dimensions.h_8),
                      AppTextWidget(
                          title: 'Review Request',
                          style: AppTextStyle.themeBoldNormalTextStyle(
                              fontSize: FontSize.sp_13,
                              color: AppColor.serviceTextColor)),
                      VerticalSpacing(height: Dimensions.h_15),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            Map<String, List<AddRequest>> groupedItems = {};

                            for (var request in controller.addRequest) {
                              groupedItems.putIfAbsent(request.title ?? '', () => []).add(request);
                            }

                            return ListView(
                              children: groupedItems.entries.map((entry) {
                                String title = entry.key;
                                List<AddRequest> items = entry.value;

                                return Container(
                                  margin: EdgeInsets.only(bottom: Dimensions.h_15),
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_12),
                                  decoration: BoxDecoration(
                                    color: AppColor.darkCardColor,
                                    borderRadius: BorderRadius.circular(Dimensions.h_10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        title: title,
                                        style: GoogleFonts.inter(
                                          color: AppColor.serviceTextColor,
                                          fontSize: FontSize.sp_12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      VerticalSpacing(height: Dimensions.h_10),
                                      ...items.map((item) {
                                        int itemIndex = controller.addRequest.indexOf(item); // Get the index for deletion

                                        return Container(
                                          margin: EdgeInsets.only(bottom: Dimensions.h_10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    AppTextWidget(
                                                      title: item.subtitle ?? '',
                                                      style: GoogleFonts.inter(
                                                        color: AppColor.serviceTextColor,
                                                        fontSize: FontSize.sp_9,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Dimensions.w_280,
                                                      child: AppTextWidget(
                                                        maxLines: 3,
                                                        textOverflow: TextOverflow.visible,
                                                        title: item.description ?? '',
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.serviceTextColor,
                                                          fontSize: FontSize.sp_6,
                                                          fontWeight: FontWeight.w200,
                                                        ),
                                                      ),
                                                    ),
                                                    VerticalSpacing(height: Dimensions.h_10),
                                                    (item.details?.isNotEmpty ?? false)
                                                        ? Row(
                                                      children: [
                                                        AppTextWidget(
                                                          title: "Details: ",
                                                          style: GoogleFonts.inter(
                                                            fontWeight: FontWeight.w400,
                                                            color: AppColor.serviceTextColor,
                                                            fontSize: FontSize.sp_6,
                                                          ),
                                                        ),
                                                        HorizontalSpacing(width: Dimensions.w_5),
                                                        AppTextWidget(
                                                          title: item.details ?? "",
                                                          style: GoogleFonts.inter(
                                                            fontWeight: FontWeight.w400,
                                                            color: AppColor.serviceTextColor,
                                                            fontSize: FontSize.sp_6,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                        : GestureDetector(
                                                      behavior: HitTestBehavior.opaque,
                                                      onTap: () async {
                                                        Get.toNamed(AppRoutes.addDetail, arguments: {
                                                          'controller': controller,
                                                          'title': item.title,
                                                          'subTitle': item.subtitle,
                                                          'desc': item.description,
                                                          'index': itemIndex,
                                                          'id': id,
                                                        });
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                          top: Dimensions.h_2,
                                                          bottom: Dimensions.h_2,
                                                          right: Dimensions.w_5,
                                                          left: Dimensions.w_5,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: AppColor.appColor,
                                                          ),
                                                          borderRadius: BorderRadius.circular(Dimensions.h_6),
                                                        ),
                                                        child: AppTextWidget(
                                                          title: 'Add Details',
                                                          style: GoogleFonts.inter(
                                                            fontWeight: FontWeight.w700,
                                                            color: AppColor.appColor,
                                                            fontSize: FontSize.sp_6,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    VerticalSpacing(height: Dimensions.h_10),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(onTap: () {
                                                controller.removeData(itemIndex);
                                              },child: const Icon(Icons.delete, color: AppColor.appColor)),

                                            ],
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                      AppButton(loading: controller.buttonLoading,style: AppTextStyle.buttonTextStyle(
                        fontSize: FontSize.sp_8,color: AppColor.black
                      ),title: 'Submit',onTap: () {
                        if(controller.category.isNotEmpty) {
                          controller.bookService(id,controller.category,controller);
                        } else {
                          showAppSnack(context, 'Please Add services', false);
                        }
                      }),
                      VerticalSpacing(height: Dimensions.h_5)
                    ],),
                );
              },
            ));
      },
    );
  }
}
