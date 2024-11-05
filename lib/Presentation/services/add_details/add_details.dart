import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelautomationapp/Presentation/services/service_controller.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/book_service_request.dart';
import 'package:hotelautomationapp/widgets/appScaffold.dart';
import 'package:hotelautomationapp/widgets/appTextfield.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/appbutton.dart';
import 'package:hotelautomationapp/widgets/common_appbar.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';

class AddDetailsScreen extends StatelessWidget {
  const AddDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ServiceController serviceController = Get.arguments['controller'];
    String title = Get.arguments['title'];
    String subTitle = Get.arguments['subTitle'];
    String desc = Get.arguments['desc'];
    int i = Get.arguments['index'];
    String id = Get.arguments['id'];
    return GetBuilder(
      id: ControllerBuilders.reviewController,
      init: serviceController,
      builder: (controller) {
        return AppScaffold(
            body: OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                if(orientation == Orientation.portrait) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.w_15, right: Dimensions.w_30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonAppbar(),
                          VerticalSpacing(height: Dimensions.h_12),
                          AppTextWidget(
                              title: 'Add detail',
                              style: AppTextStyle.themeBoldNormalTextStyle(
                                  fontSize: FontSize.sp_22,
                                  color: AppColor.serviceTextColor)),
                          VerticalSpacing(height: Dimensions.h_30),
                          AppTextWidget(
                              title: title,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSize.sp_16,
                                  color: AppColor.serviceTextColor
                              )),
                          VerticalSpacing(height: Dimensions.h_20),
                          AppTextWidget(
                            title: subTitle,
                            style:  GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: FontSize.sp_13,
                                color: AppColor.serviceTextColor
                            ),
                          ),
                          AppTextWidget(
                            maxLines: 3,textOverflow: TextOverflow.visible,
                            title: desc,
                            style:  GoogleFonts.inter(
                                fontWeight: FontWeight.w300,
                                fontSize: FontSize.sp_10,
                                color: AppColor.serviceTextColor
                            ),
                          ),
                          VerticalSpacing(height: Dimensions.h_10),
                          AppTextField(
                              textStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w300,
                                  fontSize: FontSize.sp_13,
                                  color: AppColor.black
                              ),
                              maxLines: 6,
                              hintText: 'Write your message',
                              title: '',
                              controller: controller.addDetailsCont,
                              borderEnable: false,
                              hintStyle: GoogleFonts.inter(
                                  fontSize: FontSize.sp_12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFA1A1A1)
                              ),
                              color: AppColor.white),
                          const Spacer(),
                          AppButton(title: 'Submit',onTap: () {
                            controller.insertData(i,AddRequest(description: desc,subtitle: subTitle,title: title,details: controller.addDetailsCont.text),SubCategory(
                                description: desc,
                                subCategoryId: id));
                            Get.back();
                          },),
                          VerticalSpacing(height: Dimensions.h_20)
                        ]),
                  );

                }
                return Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.w_15, right: Dimensions.w_30),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonAppbar(),
                          VerticalSpacing(height: Dimensions.h_12),
                          AppTextWidget(
                              title: 'Add detail',
                              style: AppTextStyle.themeBoldNormalTextStyle(
                                  fontSize: FontSize.sp_13,
                                  color: AppColor.serviceTextColor)),
                          VerticalSpacing(height: Dimensions.h_30),
                          AppTextWidget(
                              title: title,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSize.sp_10,
                                  color: AppColor.serviceTextColor
                              )),
                          VerticalSpacing(height: Dimensions.h_20),
                          AppTextWidget(
                            title: subTitle,
                            style:  GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: FontSize.sp_7,
                                color: AppColor.serviceTextColor
                            ),
                          ),
                          AppTextWidget(
                            maxLines: 3,textOverflow: TextOverflow.visible,
                            title: desc,
                            style:  GoogleFonts.inter(
                                fontWeight: FontWeight.w300,
                                fontSize: FontSize.sp_6,
                                color: AppColor.serviceTextColor
                            ),
                          ),
                          VerticalSpacing(height: Dimensions.h_10),
                          AppTextField(
                              textStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w300,
                                  fontSize: FontSize.sp_7,
                                  color: AppColor.black
                              ),
                              maxLines: 4,
                              hintText: 'Write your message',
                              title: '',
                              controller: controller.addDetailsCont,
                              borderEnable: false,
                              hintStyle: GoogleFonts.inter(
                                  fontSize: FontSize.sp_6,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFA1A1A1)
                              ),
                              color: AppColor.white),
                          AppButton(title: 'Submit',style: AppTextStyle.buttonTextStyle(
                            fontSize: FontSize.sp_8,color: AppColor.black
                          ),onTap: () {
                            controller.insertData(i,AddRequest(description: desc,subtitle: subTitle,title: title,details: controller.addDetailsCont.text),SubCategory(
                                description: desc,
                                subCategoryId: id));
                            Get.back();
                          },),
                          VerticalSpacing(height: Dimensions.h_20)
                        ]),
                  ),
                );
              },
            )
        );
      },
    );
  }
}
