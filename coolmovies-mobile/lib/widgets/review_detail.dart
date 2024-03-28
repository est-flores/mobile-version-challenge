import 'package:coolmovies/constants/colors.dart';
import 'package:coolmovies/constants/layout.dart';
import 'package:coolmovies/constants/text_styles.dart';
import 'package:coolmovies/controllers/reviews_controller.dart';
import 'package:coolmovies/controllers/user_controller.dart';
import 'package:coolmovies/models/review.dart';
import 'package:coolmovies/widgets/custom_button.dart';
import 'package:coolmovies/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class ReviewDetail extends StatefulWidget {
  final String reviewId;
  final String movieId;
  const ReviewDetail(
      {super.key, required this.reviewId, required this.movieId});

  @override
  State<ReviewDetail> createState() => _ReviewDetailState();
}

class _ReviewDetailState extends State<ReviewDetail> {
  bool loading = false;
  Review? review;
  late ReviewsController _reviewsController;

  void getReviewById(String reviewId) async {
    setState(() {
      loading = true;
    });
    var client = GraphQLProvider.of(context).value;

    final QueryResult result = await client.query(QueryOptions(
      document: gql('''
          query MovieReviewById(\$reviewId: UUID!) {
              movieReviewById(id: \$reviewId) {
                body
                id
                movieByMovieId {
                  id
                  releaseDate
                  title
                  movieDirectorByMovieDirectorId {
                    age
                    id
                    name
                  }
                }
                rating
                nodeId
                title
                userByUserReviewerId {
                  name
                  id
                }
              }
            }
        '''),
      variables: {'reviewId': reviewId},
    ));

    if (result.hasException) {
      setState(() {
        loading = false;
      });
    }

    if (result.data != null) {
      final Map<String, dynamic> reviewData = result.data!['movieReviewById'];
      review = Review(
          id: reviewData['id'],
          title: reviewData['title'],
          body: reviewData['body'],
          rating: reviewData['rating'],
          userReviewerId: reviewData['userByUserReviewerId']['id']);

      setState(() {
        loading = false;
      });
    }
  }

  deleteReview() async {
    EasyLoading.show();
    await _reviewsController.deleteReviewById(
        context: context, reviewId: widget.reviewId, movieId: widget.movieId);
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    super.initState();
    _reviewsController = Provider.of<ReviewsController>(context, listen: false);
    Future.delayed(Duration.zero, () => getReviewById(widget.reviewId));
  }

  @override
  Widget build(BuildContext context) {
    String currentUserId = Provider.of<UserController>(context).currentUser.id;

    return loading
        ? const Center(
            child: CircularProgressIndicator(color: Colors.white),
          )
        : review != null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
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
                                  '"${review!.title}"',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: boldText.copyWith(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              RatingBarIndicator(
                                rating: review!.rating.toDouble(),
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
                            review!.body,
                            style: regularText.copyWith(
                                fontSize: 15, color: lightGray),
                          ),
                          sbh(30),
                          if (currentUserId == review!.userReviewerId)
                            CustomButton(
                              padding: const EdgeInsets.only(bottom: 0),
                              backgroundColor: Colors.red,
                              height: 40,
                              onTap: () {
                                deleteReview();
                                showToastWidget(
                                    const CustomToast(
                                      icon: Padding(
                                          padding: EdgeInsets.only(bottom: 0),
                                          child: Icon(
                                            Icons.delete_forever_rounded,
                                            color: mediumGray,
                                            size: 70,
                                          )),
                                      text: 'Deleted',
                                      textColor: darkGray,
                                    ),
                                    duration: const Duration(seconds: 2));
                                Navigator.of(context).pop();
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.close_rounded,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  Text(
                                    'Delete',
                                    style: regularText.copyWith(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container();
  }
}
