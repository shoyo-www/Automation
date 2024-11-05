import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelautomationapp/Presentation/services/service_controller.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/data/datasource/local/local_storage.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/appbutton.dart';
import 'package:hotelautomationapp/widgets/common_appbar.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';
import 'package:intl/intl.dart';

class PendingRequestScreen extends StatefulWidget {
  const PendingRequestScreen({super.key});

  @override
  State<PendingRequestScreen> createState() => _PendingRequestScreenState();
}

class _PendingRequestScreenState extends State<PendingRequestScreen> {
  late ServiceController serviceController;

  @override
  void initState() {
    serviceController = Get.arguments['controller'];
    super.initState();
  }

  String formatTime(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }
    return DateFormat.jm().format(dateTime.toLocal());
  }

  String getStatus (int status) {
    if(status == 1) {
      return "Pending";
    } else if(status == 2) {
      return "Approved";
    } else if(status == 3) {
      return "Disapproved";
    } else if( status == 4) {
      return "Cancelled";
    }
    return '';
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: ControllerBuilders.pendingRequest,
      init: serviceController,
      builder: (controller) {
        return AppScaffold(
          bottom: false,
            body: OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                if(orientation == Orientation.portrait) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.w_15, right: Dimensions.w_15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonAppbar(onTap: () {
                            LocalStorage.clearValueByKey(GetXStorageConstants.serviceBack);
                            Get.toNamed(AppRoutes.dashBoard,arguments: {
                              'index' : 3
                            });
                          },),
                          VerticalSpacing(height: Dimensions.h_12),
                          AppTextWidget(
                              title: 'Pending Request',
                              style: AppTextStyle.themeBoldNormalTextStyle(
                                  fontSize: FontSize.sp_22,
                                  color: AppColor.serviceTextColor)),
                          VerticalSpacing(height: Dimensions.h_10),
                          Expanded(
                            child: ListView.builder(
                              reverse: true,
                              itemBuilder: (c,i) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: Dimensions.h_10),
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10,vertical: Dimensions.h_10),
                                  decoration: BoxDecoration(
                                      color: AppColor.darkCardColor,
                                      borderRadius: BorderRadius.circular(Dimensions.h_8)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppTextWidget(
                                            title: controller.pendingList[i].facilityName ?? '',
                                            style:  GoogleFonts.inter(
                                                fontWeight: FontWeight.w500,
                                                fontSize: FontSize.sp_13,
                                                color: AppColor.serviceTextColor
                                            ),
                                          ),
                                          AppTextWidget(
                                            title: formatTime(controller.pendingList[i].requestedAt),
                                            style:  GoogleFonts.inter(
                                                fontWeight: FontWeight.w300,
                                                fontSize: FontSize.sp_11,
                                                color: AppColor.serviceTextColor
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: Dimensions.w_250,
                                        child: AppTextWidget(
                                          maxLines: 3,
                                          textOverflow: TextOverflow.visible,
                                          title: controller.pendingList[i].description ?? '',
                                          style:  GoogleFonts.inter(
                                              fontWeight: FontWeight.w300,
                                              fontSize: FontSize.sp_10,
                                              color: AppColor.serviceTextColor
                                          ),
                                        ),
                                      ),
                                      VerticalSpacing(height: Dimensions.h_10),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: Dimensions.h_2,
                                            bottom: Dimensions.h_2,
                                            right: Dimensions.w_5,
                                            left: Dimensions.w_5,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color:  AppColor.appColor,
                                            ),
                                            borderRadius: BorderRadius.circular(Dimensions.h_6),
                                          ),
                                          child: AppTextWidget(
                                            title: getStatus(controller.pendingList[i].status ?? 0) ,
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w700,
                                              color:  AppColor.appColor,
                                              fontSize: FontSize.sp_11,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: controller.pendingList.length,
                            ),
                          ),
                          AppButton(title: 'Add New Request',onTap: () {
                            LocalStorage.clearValueByKey(GetXStorageConstants.serviceBack);
                            Get.toNamed(AppRoutes.dashBoard,arguments: {
                              'index' : 3
                            });
                          }),
                          VerticalSpacing(height: Dimensions.h_20)
                        ]),
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.w_15, right: Dimensions.w_15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonAppbar(onTap: () {
                          LocalStorage.clearValueByKey(GetXStorageConstants.serviceBack);
                          Get.toNamed(AppRoutes.dashBoard,arguments: {
                            'index' : 3
                          });
                        },),
                        VerticalSpacing(height: Dimensions.h_12),
                        AppTextWidget(
                            title: 'Pending Request',
                            style: AppTextStyle.themeBoldNormalTextStyle(
                                fontSize: FontSize.sp_13,
                                color: AppColor.serviceTextColor)),
                        VerticalSpacing(height: Dimensions.h_10),
                        Expanded(
                          child: ListView.builder(
                            reverse: true,
                            itemBuilder: (c,i) {
                              return Container(
                                margin: EdgeInsets.only(bottom: Dimensions.h_10),
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10,vertical: Dimensions.h_10),
                                decoration: BoxDecoration(
                                    color: AppColor.darkCardColor,
                                    borderRadius: BorderRadius.circular(Dimensions.h_8)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppTextWidget(
                                          title: controller.pendingList[i].facilityName ?? '',
                                          style:  GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontSize: FontSize.sp_8,
                                              color: AppColor.serviceTextColor
                                          ),
                                        ),
                                        AppTextWidget(
                                          title: formatTime(controller.pendingList[i].requestedAt),
                                          style:  GoogleFonts.inter(
                                              fontWeight: FontWeight.w300,
                                              fontSize: FontSize.sp_6,
                                              color: AppColor.serviceTextColor
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: Dimensions.w_250,
                                      child: AppTextWidget(
                                        maxLines: 3,
                                        textOverflow: TextOverflow.visible,
                                        title: controller.pendingList[i].description ?? '',
                                        style:  GoogleFonts.inter(
                                            fontWeight: FontWeight.w300,
                                            fontSize: FontSize.sp_6,
                                            color: AppColor.serviceTextColor
                                        ),
                                      ),
                                    ),
                                    VerticalSpacing(height: Dimensions.h_10),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          top: Dimensions.h_2,
                                          bottom: Dimensions.h_2,
                                          right: Dimensions.w_5,
                                          left: Dimensions.w_5,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:  AppColor.appColor,
                                          ),
                                          borderRadius: BorderRadius.circular(Dimensions.h_6),
                                        ),
                                        child: AppTextWidget(
                                          title: getStatus(controller.pendingList[i].status ?? 0) ,
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w700,
                                            color:  AppColor.appColor,
                                            fontSize: FontSize.sp_6,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: controller.pendingList.length,
                          ),
                        ),
                        AppButton(title: 'Add New Request',style: AppTextStyle.buttonTextStyle(
                          fontSize: FontSize.sp_8,color: AppColor.black
                        ),onTap: () {
                          LocalStorage.clearValueByKey(GetXStorageConstants.serviceBack);
                          Get.toNamed(AppRoutes.dashBoard,arguments: {
                            'index' : 3
                          });
                        }),
                        VerticalSpacing(height: Dimensions.h_20)
                      ]),
                );
              },
            )
        );
      },
    );
  }
}
