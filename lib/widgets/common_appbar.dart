import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/constants/images.dart';

class CommonAppbar extends StatelessWidget {
  final void Function()? onTap;
  const CommonAppbar({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap ?? () {
        Get.back();
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
            height: Dimensions.h_25,
            width: Dimensions.h_25,
            child: Image.asset(Images.back,color: AppColor.white)),
      ),
    );
  }
}
