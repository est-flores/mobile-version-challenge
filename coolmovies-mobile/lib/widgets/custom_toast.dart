import 'package:coolmovies/constants/layout.dart';
import 'package:coolmovies/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final Color? textColor;
  final Color? backgroundColor;
  const CustomToast(
      {super.key, this.textColor, this.backgroundColor, this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: backgroundColor ??
            Color.fromARGB(255, 188, 188, 188).withOpacity(0.95),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            sbh(13),
            if (text != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  text!,
                  style: boldText.copyWith(
                    fontSize: 16,
                    color: textColor ?? Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
