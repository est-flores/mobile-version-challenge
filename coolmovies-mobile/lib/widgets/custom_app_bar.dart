import 'package:coolmovies/constants/layout.dart';
import 'package:coolmovies/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                color: Colors.transparent,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 2,
                    offset: Offset(0, 1),
                    spreadRadius: -1,
                    color: Color.fromARGB(100, 0, 0, 0),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 35,
                    ),
                    sbw(10),
                    Text(
                      title,
                      style:
                          boldText.copyWith(color: Colors.white, fontSize: 27),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
