import 'package:coolmovies/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget title;
  final double? height;
  final Color? backgroundColor;
  final double? borderRadius;
  final List<BoxShadow>? shadow;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;
  const CustomButton(
      {super.key,
      required this.title,
      this.borderRadius,
      this.backgroundColor,
      this.onTap,
      this.shadow,
      this.height,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 55,
        decoration: BoxDecoration(
          boxShadow: shadow ?? <BoxShadow>[],
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
          color: backgroundColor ?? mediumGray,
        ),
        child: Center(
            child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 0),
          child: title,
        )),
      ),
    );
  }
}
