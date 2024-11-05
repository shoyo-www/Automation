import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';

const double BUBBLE_RADIUS = 25;


class BubbleNormal extends StatelessWidget {
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final String text;
  final bool tail;
  final bool sent;
  final bool delivered;
  final bool seen;
  final TextStyle? textStyle;
  final BoxConstraints? constraints;

  const BubbleNormal({
    super.key,
    required this.text,
    this.constraints,
    this.bubbleRadius = BUBBLE_RADIUS,
    this.isSender = true,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.textStyle
  });

  ///chat bubble builder method
  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
        isSender
            ? const Expanded(
          child: SizedBox(
            width: 5,
          ),
        )
            : Container(),
        Container(
          color: Colors.transparent,
          constraints: constraints ??
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(bubbleRadius),
                  topRight: Radius.circular(tail
                      ? isSender
                      ? 0
                      : bubbleRadius
                      : BUBBLE_RADIUS),
                  bottomLeft: Radius.circular(tail
                      ? isSender
                      ? bubbleRadius
                      : 0
                      : BUBBLE_RADIUS),
                  bottomRight: Radius.circular(tail
                      ? isSender
                      ? bubbleRadius
                      : bubbleRadius
                      : BUBBLE_RADIUS),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: Dimensions.h_8, horizontal: Dimensions.w_15),
                    child: Text(
                      text,
                      style: textStyle ?? GoogleFonts.inter(
                        fontSize: FontSize.sp_12,
                        color: AppColor.black,
                        fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
