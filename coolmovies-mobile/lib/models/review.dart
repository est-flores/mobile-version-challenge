class Review {
  final String title;
  final String body;
  final num rating;

  Review({
    required this.title,
    required this.body,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      title: json['title'],
      body: json['body'],
      rating: json['rating'],
    );
  }
}
