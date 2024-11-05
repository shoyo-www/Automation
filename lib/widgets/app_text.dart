import 'package:flutter/material.dart';

class AppTextWidget extends StatelessWidget {
  final String title;
  final TextStyle style;
  final TextAlign textAlign;
  final TextOverflow textOverflow;
  final int? maxLines;

  const AppTextWidget(
      {super.key,
      required this.title,
      required this.style,
      this.textAlign = TextAlign.start,
      this.textOverflow = TextOverflow.ellipsis,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style,
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
      softWrap: true,
    );
  }
}
