import 'package:coolmovies/constants/colors.dart';
import 'package:coolmovies/constants/text_styles.dart';
import 'package:coolmovies/models/movie.dart';
import 'package:coolmovies/widgets/movie_tile.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final ValueNotifier<Map<String, dynamic>?> _data = ValueNotifier(null);
  List<Movie> movies = [];
  bool isLoading = false;

  void _fetchData() async {
    setState(() {
      isLoading = true;
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
        isLoading = false;
      });
    }

    if (result.data != null) {
      _data.value = result.data!['allMovies'];

      final List<dynamic> moviesData = _data.value?['nodes'];
      movies = moviesData.map((json) => Movie.fromJson(json)).toList();

      setState(() {
        isLoading = false;
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
    return isLoading
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
                  return Padding(
                    padding: EdgeInsets.only(top: index == 0 ? 80 : 0),
                    child: MovieTile(
                      imgUrl: movies[index].imgUrl,
                      title: movies[index].title,
                      releaseDate: movies[index].releaseDate,
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
