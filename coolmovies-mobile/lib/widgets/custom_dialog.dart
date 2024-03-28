import 'package:coolmovies/constants/colors.dart';
import 'package:coolmovies/constants/layout.dart';
import 'package:coolmovies/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final Widget? content;
  final double? horizontalPadding;
  final double? verticalSpacing;
  final Color? backgroundColor;
  const CustomDialog(
      {Key? key,
      this.title,
      this.content,
      this.horizontalPadding,
      this.verticalSpacing,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 17),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 0, horizontal: horizontalPadding ?? 5),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(35)),
            color: backgroundColor ?? darkGray),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Text(
                title ?? '',
                style: boldText.copyWith(fontSize: 23),
                textAlign: TextAlign.center,
              ),
            content ?? Container(),
          ],
        ),
      ),
    );
  }
}

displayCustomDialog({
  required BuildContext context,
  String? title,
  Widget? content,
  double? horizontalPadding,
  double? verticalSpacing,
  bool? dismissible,
  Color? backgroundColor,
}) {
  showDialog(
      barrierDismissible: dismissible ?? true,
      context: context,
      builder: (((context) => CustomDialog(
            title: title,
            content: content,
            horizontalPadding: horizontalPadding,
            verticalSpacing: verticalSpacing,
            backgroundColor: backgroundColor,
          ))));
}
