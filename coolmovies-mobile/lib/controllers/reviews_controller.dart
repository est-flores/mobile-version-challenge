import 'package:coolmovies/models/review.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ReviewsController extends ChangeNotifier {
  List<Review> reviews = [];

  fetchReviews({required BuildContext context, required String movieId}) async {
    var client = GraphQLProvider.of(context).value;
    reviews.clear();

    final QueryResult result = await client.query(
      QueryOptions(
        document: gql('''
            query MovieReviews(\$movieId: UUID!) {
              allMovieReviews(
                filter: { movieId: { equalTo: \$movieId } }
              ) {
                nodes {
                  id
                  title
                  body
                  rating
                  movieByMovieId {
                    title
                  }
                }
              }
            }
          '''),
        fetchPolicy: FetchPolicy.noCache,
        variables: {
          'movieId': movieId,
        },
      ),
    );

    if (result.hasException) {
      reviews = [];
    }

    if (result.data != null) {
      final List<dynamic> reviewsData =
          result.data!['allMovieReviews']['nodes'];
      reviews = reviewsData.map((json) => Review.fromJson(json)).toList();
    }

    notifyListeners();
  }

  createReview(
      {required BuildContext context,
      required String currentUserId,
      required String movieId,
      required String title,
      required String body,
      required int rating}) async {
    var client = GraphQLProvider.of(context).value;
    await client.mutate(MutationOptions(
      document: gql('''
            mutation CreateMovieReview(\$title: String!, \$body: String!, \$rating: Int!, \$movieId: UUID!, \$userReviewerId: UUID!) {
              createMovieReview(input: {
                movieReview: {
                  title: \$title,
                  body: \$body,
                  rating: \$rating,
                  movieId: \$movieId,
                  userReviewerId: \$userReviewerId
                }
              }) {
                movieReview {
                  id
                  title
                  body
                  rating
                  movieByMovieId {
                    title
                  }
                  userByUserReviewerId {
                    name
                  }
                }
              }
            }
          '''),
      fetchPolicy: FetchPolicy.noCache,
      variables: {
        'movieId': movieId,
        'title': title,
        'body': body,
        'rating': rating,
        'userReviewerId': currentUserId
      },
      onCompleted: (data) async {
        await fetchReviews(context: context, movieId: movieId);
      },
    ));
  }

  deleteReviewById({
    required BuildContext context,
    required String reviewId,
    required String movieId,
  }) async {
    var client = GraphQLProvider.of(context).value;
    await client.mutate(MutationOptions(
      document: gql('''
            mutation DeleteMovieReview(\$id: UUID!) {
            deleteMovieReviewById(input: { id: \$id }) {
              deletedMovieReviewId
            }
          }
          '''),
      fetchPolicy: FetchPolicy.noCache,
      variables: {
        'id': reviewId,
      },
      onCompleted: (data) async {
        await fetchReviews(context: context, movieId: movieId);
      },
    ));
  }
}
