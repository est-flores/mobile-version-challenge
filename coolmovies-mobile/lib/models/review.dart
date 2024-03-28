class Review {
  final String id;
  final String title;
  final String body;
  final num rating;
  final String userReviewerId;

  Review({
    required this.id,
    required this.title,
    required this.body,
    required this.rating,
    required this.userReviewerId,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      rating: json['rating'],
      userReviewerId: json['userByUserReviewerId']?['id'] ?? '',
    );
  }
}
