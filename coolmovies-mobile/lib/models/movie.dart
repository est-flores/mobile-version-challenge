class Movie {
  final String id;
  final String imgUrl;
  final String title;
  final String releaseDate;

  Movie({
    required this.id,
    required this.imgUrl,
    required this.title,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      imgUrl: json['imgUrl'],
      title: json['title'],
      releaseDate: json['releaseDate'],
    );
  }
}
