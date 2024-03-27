import 'package:cached_network_image/cached_network_image.dart';
import 'package:coolmovies/constants/colors.dart';
import 'package:coolmovies/constants/layout.dart';
import 'package:coolmovies/constants/text_styles.dart';
import 'package:coolmovies/widgets/shimmer_container.dart';
import 'package:flutter/material.dart';

class MovieDetailView extends StatefulWidget {
  final String id;
  final String imgUrl;
  final String title;
  final String releaseDate;
  const MovieDetailView(
      {super.key,
      required this.id,
      required this.imgUrl,
      required this.title,
      required this.releaseDate});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(children: [
          SingleChildScrollView(
            physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: <Color>[
                          darkGray,
                          Colors.black.withOpacity(0.0),
                        ],
                        stops: const [
                          0,
                          1
                        ]),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      sbh(20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          placeholder: (context, url) => ShimmerContainer(
                              child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey,
                            ),
                            width: 155,
                          )),
                          width: 155,
                          imageUrl: widget.imgUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      sbh(20),
                      Text(widget.title,
                          style: mediumText.copyWith(
                              fontSize: 20, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5),
                      sbh(15),
                      Text('Released ${widget.releaseDate}',
                          style: regularText.copyWith(
                              fontSize: 15, color: mediumGray),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2),
                      sbh(25)
                    ],
                  ),
                ),
                sbh(1500),
              ],
            ),
          ),
          _backButton(context),
        ]),
      ),
    );
  }

  Align _backButton(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: darkGray,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_rounded,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
