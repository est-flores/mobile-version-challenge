import 'package:cached_network_image/cached_network_image.dart';
import 'package:coolmovies/constants/colors.dart';
import 'package:coolmovies/constants/layout.dart';
import 'package:coolmovies/constants/navigation.dart';
import 'package:coolmovies/constants/text_styles.dart';
import 'package:coolmovies/controllers/reviews_controller.dart';
import 'package:coolmovies/controllers/user_controller.dart';
import 'package:coolmovies/models/review.dart';
import 'package:coolmovies/views/write_review_view.dart';
import 'package:coolmovies/widgets/review_tile.dart';
import 'package:coolmovies/widgets/shimmer_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailView extends StatefulWidget {
  final String id;
  final String imgUrl;
  final String title;
  final String releaseDate;
  const MovieDetailView({
    super.key,
    required this.id,
    required this.imgUrl,
    required this.title,
    required this.releaseDate,
  });

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  late ReviewsController _reviewsController;
  late UserController _userController;
  bool loading = false;

  void getReviews() async {
    setState(() {
      loading = true;
    });
    await _reviewsController.fetchReviews(context: context, movieId: widget.id);
    setState(() {
      loading = false;
    });
  }

  void getCurrentUser() async {
    setState(() {
      loading = true;
    });
    await _userController.fetchCurrentUser(context);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _reviewsController = Provider.of<ReviewsController>(context, listen: false);
    _userController = Provider.of<UserController>(context, listen: false);
    Future.delayed(Duration.zero, () => getReviews());
    Future.delayed(Duration.zero, () => getCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    List<Review> reviews = Provider.of<ReviewsController>(context).reviews;
    String? currentUserId = Provider.of<UserController>(context).currentUser.id;
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
                              fontSize: 15, color: lightGray),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2),
                      sbh(25)
                    ],
                  ),
                ),
                loading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 28.0),
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(
                            bottom: kFloatingActionButtonMargin + 90),
                        itemCount: reviews.length,
                        itemBuilder: ((context, index) {
                          Review review = reviews[index];
                          return ReviewTile(
                              id: review.id,
                              movieId: widget.id,
                              title: review.title,
                              body: review.body,
                              rating: review.rating.toDouble());
                        })),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: <Color>[
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(0),
                  ],
                      stops: const [
                    0,
                    1
                  ])),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () => pushNavigation(
                    context: context,
                    view: WriteReviewView(
                      currentUserId: currentUserId,
                      movieId: widget.id,
                    )),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: mediumGray,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Write a Review',
                              style: regularText.copyWith(
                                  fontSize: 15, color: Colors.white),
                            ),
                            svg(
                              assetName: 'edit_icon',
                              color: Colors.white,
                              height: 22,
                            )
                          ],
                        ),
                      ),
                    )),
              ),
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
