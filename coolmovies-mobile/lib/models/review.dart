class Review {
  final String id;
  final String title;
  final String body;
  final num rating;

  Review({
    required this.id,
    required this.title,
    required this.body,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      rating: json['rating'],
    );
  }
}
