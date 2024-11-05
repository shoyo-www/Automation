import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class PlaceHolderWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Duration? animationDuration;
  final Color? color;

  final BoxShape? shape;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;

  final Widget? child;

  const PlaceHolderWidget({
    this.height,
    this.width,
    this.animationDuration,
    this.padding,
    this.margin,
    this.color,
    this.alignment,
    this.shape,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.gradient,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: height,
      duration: animationDuration ?? 500.milliseconds,
      width: width,
      decoration: BoxDecoration(
        color:
        color ?? lightColors[Random.secure().nextInt(lightColors.length)],
        shape: shape ?? BoxShape.rectangle,
        borderRadius: borderRadius,
        border: border,
        boxShadow: boxShadow,
        gradient: gradient,
      ),
      alignment: alignment,
      padding: padding,
      margin: margin,
      child: child,
    );
  }
}
List<Color> lightColors = [
  const Color(0xffcffada),
  const Color(0xFFf0efeb),
  const Color(0xffd4dffa),
  const Color(0xfff8eadf),
  const Color(0xfffcdce1),
  const Color(0xffddf8fa),
  const Color(0xfffcfade),
  const Color(0xffe2f8d8),
  const Color(0xfffdf2e8),
  const Color(0xffece8fd),
  const Color(0xffdcfaf2),
];