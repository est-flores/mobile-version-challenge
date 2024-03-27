import 'package:coolmovies/models/review.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ReviewsController extends ChangeNotifier {
  List<Review> reviews = [];

  fetchReviews({required BuildContext context, required String movieId}) async {
    var client = GraphQLProvider.of(context).value;

    final QueryResult result = await client.query(
      QueryOptions(
        document: gql('''
            query MovieReviews(\$movieId: UUID!) {
              allMovieReviews(
                filter: { movieId: { equalTo: \$movieId } }
              ) {
                nodes {
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
}
