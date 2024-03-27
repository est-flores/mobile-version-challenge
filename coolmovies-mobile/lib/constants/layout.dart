import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// sbh -> SizedBox Height
Widget sbh(double height) {
  return SizedBox(
    height: height,
  );
}

// sbw -> SizedBox Width
Widget sbw(double width) {
  return SizedBox(
    width: width,
  );
}

//SVG assets
svg({required String assetName, Color? color, double? height}) {
  return SvgPicture.asset(
    'assets/icons/$assetName.svg',
    height: height ?? 30,
    colorFilter: ColorFilter.mode(color ?? Colors.white, BlendMode.srcIn),
  );
}
