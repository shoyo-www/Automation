import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/apptextstyle.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:hotelautomationapp/widgets/app_text.dart';
import 'package:hotelautomationapp/widgets/spacing.dart';

void showAppSnack(BuildContext context, String message, bool status) {
  OverlayEntry? overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + Dimensions.h_20,
      right: Dimensions.w_10,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: Dimensions.w_10, right: Dimensions.w_10),
            height: Dimensions.h_70,
            width: MediaQuery.sizeOf(context).width / 1.27,
            decoration: BoxDecoration(
              color: status ? const Color(0xFF76BF4C) : const Color(0xFFD94A3F),
              borderRadius: BorderRadius.circular(Dimensions.h_18),
            ),
            child: Row(
              children: [
                status
                    ? SizedBox(
                  height: Dimensions.h_40,
                  width: Dimensions.h_40,
                  child: Image.asset('assets/success.png'),
                )
                    : Container(
                  padding: EdgeInsets.all(Dimensions.h_10),
                  height: Dimensions.h_40,
                  width: Dimensions.h_40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF8A0B00),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/close.png'),
                ),
                HorizontalSpacing(width: Dimensions.w_10),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: Dimensions.h_1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          title: status ? 'Great!' : 'Ooops!',
                          style: AppTextStyle.normalTextStyle(
                            MediaQuery.of(context).orientation == Orientation.portrait ? FontSize.sp_20 : FontSize.sp_12,
                            AppColor.white,
                            weight: FontWeight.w500,
                          ),
                        ),
                        AppTextWidget(
                          maxLines: 3,
                          textOverflow: TextOverflow.visible,
                          title: message,
                          style: AppTextStyle.normalTextStyle(
                            MediaQuery.of(context).orientation == Orientation.portrait ? FontSize.sp_11 : FontSize.sp_7,
                            AppColor.white,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: Dimensions.w_15,
            top: Dimensions.h_10,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                overlayEntry?.remove();
                overlayEntry = null;
              },
              child: SizedBox(
                height: Dimensions.h_15,
                width: Dimensions.h_15,
                child: Image.asset('assets/close.png'),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Overlay.of(context).insert(overlayEntry!);

  Future.delayed(const Duration(seconds: 3), () {
    if (overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  });
}
