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
import 'package:hotelautomationapp/data/datasource/remote/models/request/book_service_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_facility_response.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/appbutton.dart';
import 'package:hotelautomationapp/widgets/cache_image.dart';
import 'package:hotelautomationapp/widgets/common_appbar.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';
import 'package:lottie/lottie.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ServiceController controller = Get.put(ServiceController());
    return GetBuilder(
      init: controller,
      id: ControllerBuilders.serviceController,
      builder: (controller) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            if(orientation == Orientation.portrait) {
              return AppScaffold(
                isLoading: controller.loading,
                body: Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.w_12, right: Dimensions.w_12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (LocalStorage.getBool(GetXStorageConstants.serviceBack) == true) const CommonAppbar() else const SizedBox.shrink(),
                      VerticalSpacing(height: Dimensions.h_20),
                      AppTextWidget(title: 'Service Request',
                          style: AppTextStyle.themeBoldNormalTextStyle(
                              fontSize: FontSize.sp_20, color: AppColor.white)),
                      VerticalSpacing(height: Dimensions.h_20),
                     controller.serviceList.isNotEmpty ?  Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.serviceList.length,
                            itemBuilder: (context,i) {
                              return Theme(
                                data: ThemeData(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                ),
                                child:  Stack(
                                  children: [
                                    Card(
                                        margin: EdgeInsets.only(bottom: Dimensions.h_15),
                                        color: AppColor.darkCardColor,
                                        child: Obx(() {
                                          return ExpansionTile(
                                            onExpansionChanged: (e) {
                                              controller.onChanged(e);
                                            },
                                            trailing: controller.isChanged.value ?const Icon(
                                              Icons.arrow_drop_up,
                                              color: AppColor.appColor,
                                            ) : const Icon(
                                              Icons.arrow_drop_down,
                                              color: AppColor.appColor,
                                            ),
                                            iconColor: AppColor.appColor,
                                            collapsedShape:  ContinuousRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(Dimensions.h_18))
                                            ),
                                            shape:  ContinuousRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(Dimensions.h_18))
                                            ),
                                            title: Padding(
                                              padding:  EdgeInsets.only(left: Dimensions.w_6),
                                              child: AppTextWidget(title: controller.serviceList[i].name ?? '', style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.serviceTextColor

                                              )),
                                            ),
                                            children :  <Widget>[
                                              ListView.builder(
                                                  itemCount: controller.serviceList[i].subCategoriesIds?.length ?? 0,
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemBuilder: (c,index) {
                                                    SubCategoriesId? sub = controller.serviceList[i].subCategoriesIds?[index];
                                                    return  Padding(
                                                      padding:  EdgeInsets.symmetric(horizontal: Dimensions.w_10,vertical: Dimensions.h_10),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.all(Dimensions.h_8),
                                                            margin: EdgeInsets.only(right: Dimensions.w_12),
                                                            height: Dimensions.h_50,
                                                            width: Dimensions.h_50,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(Dimensions.h_8),
                                                                border: Border.all(color: AppColor.white.withOpacity(0.8))
                                                            ),
                                                            child: CachedImageWidget(url: sub?.icon ?? '', height: Dimensions.h_50),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                AppTextWidget(title: sub?.name ?? '', style: GoogleFonts.inter(
                                                                    fontWeight: FontWeight.w500,
                                                                    color: AppColor.serviceTextColor,
                                                                    fontSize: FontSize.sp_15
                                                                )),
                                                                AppTextWidget(textOverflow: TextOverflow.visible,title: sub?.description ?? '', style: GoogleFonts.inter(
                                                                    fontWeight: FontWeight.w300,
                                                                    color: AppColor.serviceTextColor,
                                                                    fontSize: FontSize.sp_10
                                                                )),
                                                              ],
                                                            ),
                                                          ),
                                                          sub?.isPending == 1 ? GestureDetector(
                                                            onTap:() {
                                                              Get.toNamed(AppRoutes.pendingRequest,arguments: {
                                                                'controller' : controller
                                                              });
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets.only(
                                                                top: Dimensions.h_2,
                                                                bottom: Dimensions.h_2,
                                                                right: Dimensions.w_5,
                                                                left: Dimensions.w_5,
                                                              ),
                                                              margin: EdgeInsets.only(
                                                                  left: Dimensions.w_10),
                                                              decoration:
                                                              BoxDecoration(
                                                                border: Border.all(
                                                                  color: AppColor.transparent,
                                                                ),
                                                                borderRadius: BorderRadius.circular(Dimensions.h_8),
                                                                color: AppColor.appColor,
                                                              ),
                                                              child:
                                                              AppTextWidget(
                                                                title: "Requested",
                                                                style: GoogleFonts.inter(
                                                                  fontWeight: FontWeight.w700,
                                                                  color: AppColor.black,
                                                                  fontSize: FontSize.sp_11,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                              : GestureDetector(
                                                            behavior: HitTestBehavior.opaque,
                                                            onTap: () async {
                                                              controller.addData(AddRequest(title: controller.serviceList[i].name ?? '', subtitle: sub?.name ?? '', description: sub?.description ?? '', id: sub?.id ?? ''),
                                                                  SubCategory(subCategoryId: sub?.id,description: sub?.description ?? ''));
                                                              Get.toNamed(AppRoutes.reviewRequest,arguments: {
                                                                "Controller" : controller,
                                                                "title" : controller.serviceList[i].name,
                                                                "subList" : controller.subCat,
                                                                "id" : sub?.hotelFacilityId ?? ''
                                                              });
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets.only(
                                                                top: Dimensions.h_2,
                                                                bottom: Dimensions.h_2,
                                                                right: Dimensions.w_5,
                                                                left: Dimensions.w_5,
                                                              ),
                                                              margin: EdgeInsets.only(left: Dimensions.w_10),
                                                              decoration: BoxDecoration(
                                                                border: Border.all(
                                                                  color:  AppColor.appColor,
                                                                ),
                                                                borderRadius: BorderRadius.circular(Dimensions.h_8),
                                                                color: AppColor.transparent,
                                                              ),
                                                              child: AppTextWidget(
                                                                title: 'Request',
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
                                                  })

                                            ],
                                          );
                                        })
                                    ),
                                    Positioned(
                                      top: Dimensions.h_8,
                                      child: Container(
                                        height: Dimensions.h_30,
                                        width: Dimensions.w_10,
                                        color: AppColor.appColorLight,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      )  : controller.loading == false ?  Center(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           VerticalSpacing(height: Dimensions.h_150),
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
                bottomNavigationBar: controller.iSelected ?  AppButton(
                  title: 'Review Request',
                  onTap: () {
                    Get.toNamed(AppRoutes.reviewRequest,arguments: {
                      'Controller' : controller
                    });
                  },
                  margin: EdgeInsets.only(
                      left: Dimensions.w_25,
                      right: Dimensions.w_25,
                      bottom: Dimensions.h_15),) : const SizedBox.shrink(),
              );

            }
            return AppScaffold(
              isLoading: controller.loading,
              body: Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.w_12, right: Dimensions.w_12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (LocalStorage.getBool(GetXStorageConstants.serviceBack) == true) const CommonAppbar() else const SizedBox.shrink(),
                    VerticalSpacing(height: Dimensions.h_20),
                    AppTextWidget(title: 'Service Request',
                        style: AppTextStyle.themeBoldNormalTextStyle(
                            fontSize: FontSize.sp_13, color: AppColor.white)),
                    VerticalSpacing(height: Dimensions.h_20),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.serviceList.length,
                          itemBuilder: (context,i) {
                            return Theme(
                              data: ThemeData(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                              child:  Stack(
                                children: [
                                  Card(
                                      margin: EdgeInsets.only(bottom: Dimensions.h_15),
                                      color: AppColor.darkCardColor,
                                      child: Obx(() {
                                        return ExpansionTile(
                                          onExpansionChanged: (e) {
                                            controller.onChanged(e);
                                          },
                                          trailing: controller.isChanged.value ?const Icon(
                                            Icons.arrow_drop_up,
                                            color: AppColor.appColor,
                                          ) : const Icon(
                                            Icons.arrow_drop_down,
                                            color: AppColor.appColor,
                                          ),
                                          iconColor: AppColor.appColor,
                                          collapsedShape:  ContinuousRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(Dimensions.h_18))
                                          ),
                                          shape:  ContinuousRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(Dimensions.h_18))
                                          ),
                                          title: Padding(
                                            padding:  EdgeInsets.only(left: Dimensions.w_6),
                                            child: AppTextWidget(title: controller.serviceList[i].name ?? '', style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.serviceTextColor

                                            )),
                                          ),
                                          children :  <Widget>[
                                            ListView.builder(
                                                itemCount: controller.serviceList[i].subCategoriesIds?.length ?? 0,
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemBuilder: (c,index) {
                                                  SubCategoriesId? sub = controller.serviceList[i].subCategoriesIds?[index];
                                                  return  Padding(
                                                    padding:  EdgeInsets.symmetric(horizontal: Dimensions.w_10,vertical: Dimensions.h_10),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.all(Dimensions.h_8),
                                                          margin: EdgeInsets.only(right: Dimensions.w_12),
                                                          height: Dimensions.h_50,
                                                          width: Dimensions.h_50,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(Dimensions.h_8),
                                                              border: Border.all(color: AppColor.white.withOpacity(0.8))
                                                          ),
                                                          child: CachedImageWidget(url: sub?.icon ?? '', height: Dimensions.h_50),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              AppTextWidget(title: sub?.name ?? '', style: GoogleFonts.inter(
                                                                  fontWeight: FontWeight.w500,
                                                                  color: AppColor.serviceTextColor,
                                                                  fontSize: FontSize.sp_8
                                                              )),
                                                              AppTextWidget(textOverflow: TextOverflow.visible,title: sub?.description ?? '', style: GoogleFonts.inter(
                                                                  fontWeight: FontWeight.w300,
                                                                  color: AppColor.serviceTextColor,
                                                                  fontSize: FontSize.sp_6
                                                              )),
                                                            ],
                                                          ),
                                                        ),
                                                        sub?.isPending == 1 ? GestureDetector(
                                                          onTap:() {
                                                            Get.toNamed(AppRoutes.pendingRequest,arguments: {
                                                              'controller' : controller
                                                            });
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.only(
                                                              top: Dimensions.h_2,
                                                              bottom: Dimensions.h_2,
                                                              right: Dimensions.w_5,
                                                              left: Dimensions.w_5,
                                                            ),
                                                            margin: EdgeInsets.only(
                                                                left: Dimensions.w_10),
                                                            decoration:
                                                            BoxDecoration(
                                                              border: Border.all(
                                                                color: AppColor.transparent,
                                                              ),
                                                              borderRadius: BorderRadius.circular(Dimensions.h_8),
                                                              color: AppColor.appColor,
                                                            ),
                                                            child:
                                                            AppTextWidget(
                                                              title: "Requested",
                                                              style: GoogleFonts.inter(
                                                                fontWeight: FontWeight.w700,
                                                                color: AppColor.black,
                                                                fontSize: FontSize.sp_6,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                            : GestureDetector(
                                                          behavior: HitTestBehavior.opaque,
                                                          onTap: () async {
                                                            controller.addData(AddRequest(title: controller.serviceList[i].name ?? '', subtitle: sub?.name ?? '', description: sub?.description ?? '', id: sub?.id ?? ''),
                                                                SubCategory(subCategoryId: sub?.id,description: sub?.description ?? ''));
                                                            Get.toNamed(AppRoutes.reviewRequest,arguments: {
                                                              "Controller" : controller,
                                                              "title" : controller.serviceList[i].name,
                                                              "subList" : controller.subCat,
                                                              "id" : sub?.hotelFacilityId ?? ''
                                                            });
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.only(
                                                              top: Dimensions.h_2,
                                                              bottom: Dimensions.h_2,
                                                              right: Dimensions.w_5,
                                                              left: Dimensions.w_5,
                                                            ),
                                                            margin: EdgeInsets.only(left: Dimensions.w_10),
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color:  AppColor.appColor,
                                                              ),
                                                              borderRadius: BorderRadius.circular(Dimensions.h_8),
                                                              color: AppColor.transparent,
                                                            ),
                                                            child: AppTextWidget(
                                                              title: 'Request',
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
                                                })

                                          ],
                                        );
                                      })
                                  ),
                                  Positioned(
                                    top: Dimensions.h_8,
                                    child: Container(
                                      height: Dimensions.h_30,
                                      width: Dimensions.w_10,
                                      color: AppColor.appColorLight,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: controller.iSelected ?  AppButton(
                title: 'Review Request',
                onTap: () {
                  Get.toNamed(AppRoutes.reviewRequest,arguments: {
                    'Controller' : controller
                  });
                },
                margin: EdgeInsets.only(
                    left: Dimensions.w_25,
                    right: Dimensions.w_25,
                    bottom: Dimensions.h_15),) : const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
