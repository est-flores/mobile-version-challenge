import 'package:coolmovies/constants/colors.dart';
import 'package:coolmovies/constants/navigation.dart';
import 'package:coolmovies/constants/text_styles.dart';
import 'package:coolmovies/models/movie.dart';
import 'package:coolmovies/views/movie_detail_view.dart';
import 'package:coolmovies/widgets/movie_tile.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<Movie> movies = [];
  bool loading = false;

  void _fetchData() async {
    setState(() {
      loading = true;
    });
    var client = GraphQLProvider.of(context).value;

    final QueryResult result = await client.query(QueryOptions(
      document: gql(r"""
          query AllMovies {
            allMovies {
              nodes {
                id
                imgUrl
                movieDirectorId
                userCreatorId
                title
                releaseDate
                nodeId
                userByUserCreatorId {
                  id
                  name
                  nodeId
                }
              }
            }
          }
        """),
    ));

    if (result.hasException) {
      setState(() {
        loading = false;
      });
    }

    if (result.data != null) {
      final List<dynamic> moviesData = result.data!['allMovies']['nodes'];
      movies = moviesData.map((json) => Movie.fromJson(json)).toList();

      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _fetchData());
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        : movies.isNotEmpty
            ? ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  Movie movie = movies[index];
                  return Padding(
                    padding: EdgeInsets.only(top: index == 0 ? 80 : 0),
                    child: MovieTile(
                      onTap: () => pushNavigation(
                          context: context,
                          view: MovieDetailView(
                            id: movie.id,
                            imgUrl: movie.imgUrl,
                            title: movie.title,
                            releaseDate: movie.releaseDate,
                          )),
                      id: movie.id,
                      imgUrl: movie.imgUrl,
                      title: movie.title,
                      releaseDate: movie.releaseDate,
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  'No movies available',
                  style: regularText.copyWith(color: mediumGray, fontSize: 20),
                ),
              );
  }
}
