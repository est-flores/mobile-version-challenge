import 'package:cached_network_image/cached_network_image.dart';
import 'package:coolmovies/constants/colors.dart';
import 'package:coolmovies/constants/layout.dart';
import 'package:coolmovies/constants/text_styles.dart';
import 'package:coolmovies/widgets/shimmer_container.dart';
import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String releaseDate;
  final Function()? onTap;
  const MovieTile(
      {super.key,
      this.onTap,
      required this.imgUrl,
      required this.title,
      required this.releaseDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              placeholder: (context, url) => ShimmerContainer(
                                  child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey,
                                ),
                                width: 95,
                                height: 145,
                              )),
                              width: 95,
                              height: 145,
                              imageUrl: imgUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          sbw(15),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title,
                                    style: mediumText.copyWith(
                                        fontSize: 18, color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                                sbh(10),
                                Text('Released $releaseDate',
                                    style: regularText.copyWith(
                                        fontSize: 15, color: mediumGray),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        color: lightGray)
                  ],
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 130, right: 20),
                  child: Divider(
                    height: 0,
                    thickness: 0.7,
                    color: lightGray,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
