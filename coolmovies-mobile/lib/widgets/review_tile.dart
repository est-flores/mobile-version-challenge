import 'package:coolmovies/constants/colors.dart';
import 'package:coolmovies/constants/layout.dart';
import 'package:coolmovies/constants/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewTile extends StatelessWidget {
  final String title;
  final String body;
  final double rating;
  const ReviewTile({
    super.key,
    required this.title,
    required this.body,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(
              color: mediumGray,
              width: 1,
            ),
          )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
            child: SizedBox(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Text(
                            '"$title"',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: boldText.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        RatingBarIndicator(
                          rating: rating,
                          itemCount: 5,
                          itemSize: 20,
                          physics: const BouncingScrollPhysics(),
                          unratedColor:
                              const Color.fromARGB(255, 206, 206, 206),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    )),
                    sbh(10),
                    Text(
                      body,
                      style:
                          regularText.copyWith(fontSize: 15, color: lightGray),
                    ),
                    sbh(20),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
