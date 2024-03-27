import 'package:coolmovies/constants/colors.dart';
import 'package:coolmovies/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.black,
                Colors.black.withOpacity(0.0),
              ],
              stops: const [
                0,
                1
              ]),
        ),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: mediumGray,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      blurRadius: 4,
                      offset: Offset(0, 1),
                      spreadRadius: -1,
                      color: Color.fromARGB(100, 0, 0, 0),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ))),
                    child: Center(
                        child: Text(
                      title,
                      style: mediumText.copyWith(color: Colors.white),
                    )),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
